{ config, lib, pkgs, ... }:

let
  cfg = config.want;
in
{
  options.want.nvim = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Install Neovim";
  };

  config = lib.mkIf cfg.nvim {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withNodeJs = false;
      withPython3 = false;
      withRuby = false;
      extraPackages = with pkgs; [
        gcc_latest

        nil
        nixpkgs-fmt
      ];
      extraLuaConfig = ''
        vim.opt.cursorline = true
        vim.opt.expandtab = true
        vim.opt.number = true
        vim.opt.list = true
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.relativenumber = true

        require('lualine').setup()
        require('gitsigns').setup()
        require('neo-tree').setup()
      '';
      plugins = with pkgs.vimPlugins; [
        {
          type = "lua";
          plugin = monokai-pro-nvim;
          config = ''
            require('monokai-pro').setup {
              transparent_background = true,
            }

            vim.cmd.colorscheme('monokai-pro-classic')
          '';
        }

        lualine-nvim
        gitsigns-nvim
        neo-tree-nvim

        {
          type = "lua";
          plugin = nvim-treesitter.withPlugins (parser: with parser; [
            awk
            diff
            regex

            bash
            c
            comment
            latex
            lua
            nix
            python
            vim

            cmake
            ini
            json
            make
            markdown
            toml
            yaml
          ]);
          config = ''
            require('nvim-treesitter.configs').setup {
              auto_install = false,

              highlight = {
                enable = true,
              },
            }
          '';
        }

        nvim-lspconfig
        nvim-snippy

        cmp-nvim-lsp
        cmp-buffer
        cmp-snippy
        {
          type = "lua";
          plugin = nvim-cmp;
          config = ''
            local cmp = require('cmp')

            cmp.setup {
              snippet = {
                expand = function(args)
                  require('snippy').expand_snippet(args.body)
                end
              },
              mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true, }),
              }),
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'snippy' },
              }, {
                { name = 'buffer' },
              })
            }

            -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
            -- https://github.com/hrsh7th/cmp-nvim-lsp/issues/42#issuecomment-1283825572
            local caps = vim.tbl_deep_extend(
              'force',
              vim.lsp.protocol.make_client_capabilities(),
              require('cmp_nvim_lsp').default_capabilities(),
              -- File watching is disabled by default for neovim.
              -- See: https://github.com/neovim/neovim/pull/22405
              { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
            )

            require('lspconfig').nil_ls.setup {
              capabilities = caps,
              settings = {
                ['nil'] = {
                  formatting = {
                    command = { 'nixpkgs-fmt' },
                  },
                },
              },
            }
          '';
        }
      ];
    };
  };
}
