let
  pkgs = let
    hostPkgs = import <nixpkgs> {};
    pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs-version.json;
    pinnedPkgs = hostPkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs-channels";
      inherit (pinnedVersion) rev sha256;
    };
  in import pinnedPkgs {};
  drv = pkgs.stdenv.mkDerivation rec {
    name = "env";
    env = pkgs.buildEnv { name = name; paths = buildInputs; };
    buildInputs = with pkgs.rPackages; [
      pkgs.R
      ggplot2
      devtools
    ];
  };
in
  drv
