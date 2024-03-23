{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            boost
            cmake
            ninja
            clang
            pkg-config
            pkgs.llvmPackages.bintools
            c-ares
            cryptopp
            lz4
            gnutls
            hwloc
            lksctp-tools
            numactl
            yaml-cpp
            ragel
            valgrind
            go
            zlib
            (python3.withPackages (ps: [
                ps.jsonschema
                ps.jinja2
            ]))
            snappy
            xxHash
            zstd
            protobuf
            libxml2
            openssl
            libxfs
            libsystemtap
            just
            cargo
          ];
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
