final: prev: {
  netdata = prev.netdata.overrideAttrs (_: prev: {
    # FIXME: https://github.com/NixOS/nixpkgs/pull/249032
    buildInputs = prev.buildInputs ++ [ final.json_c ];
  });
}
