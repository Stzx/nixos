{ config, lib, pkgs, ... }:

let
  cfg = config.features;
in
{
  options.features = {
    cpu.amd = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "AMD CPU support";
    };
    cpu.intel = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Intel CPU support";
    };
    gpu.amd = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "AMD GPU support";
    };
    gpu.nvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "NVIDIA GPU support";
    };
  };

  config = lib.mkMerge [
    {
      hardware.opengl = {
        enable = true;
        driSupport = true;
      };

      environment = {
        systemPackages = with pkgs; [
          vulkan-tools

          opencl-info

          libva-utils
        ];
        sessionVariables = {
          NIXOS_OZONE_WL = "1";

          EGL_PLATFORM = "wayland";

          MOZ_ENABLE_WAYLAND = "1";
        };
      };
    }

    (lib.mkIf cfg.cpu.amd {
      hardware.cpu.amd = {
        updateMicrocode = true;
        sev.enable = true;
      };
    })

    (lib.mkIf cfg.gpu.amd {
      services.xserver.videoDrivers = [ "modesetting" ];

      hardware.opengl.extraPackages = with pkgs; [
        amdvlk
      ] ++ (with pkgs.rocmPackages; [
        clr
        clr.icd
      ]);
    })

    (lib.mkIf cfg.gpu.nvidia {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.opengl.extraPackages = [ pkgs.nvidia-vaapi-driver ];

      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        nvidiaSettings = false;
        nvidiaPersistenced = true;
        modesetting.enable = true;
        powerManagement.enable = true;
      };

      environment.sessionVariables = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";

        GBM_BACKEND = "nvidia-drm";

        # FIXME: https://github.com/elFarto/nvidia-vaapi-driver
        NVD_BACKEND = "direct";
        LIBVA_DRIVER_NAME = "nvidia";

        MOZ_DISABLE_RDD_SANDBOX = "1";
      };
    })
  ];
}
