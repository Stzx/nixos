final: prev: {
  netdata = prev.netdata.overrideAttrs (_: _prev: {
    # FIXME: https://github.com/NixOS/nixpkgs/pull/249032
    buildInputs = _prev.buildInputs ++ [ final.json_c ];
  });
}
