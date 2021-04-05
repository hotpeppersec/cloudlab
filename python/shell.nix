let
  pkgs = import <nixpkgs> {};
  #nanomsg-py = ...build expression for this python library...;
in pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    pkgs.python3.pkgs.pip
    pkgs.python3.pkgs.setuptools
  ];
  shellHook = ''
    export NIX_PATH="nixpkgs=/nix"
    # Tells pip to put packages into $PIP_PREFIX instead of the usual locations.
    # See https://pip.pypa.io/en/stable/user_guide/#environment-variables.
    export PIP_PREFIX=$(pwd)/_build/pip_packages
    export PYTHONPATH="$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"
    unset SOURCE_DATE_EPOCH
  '';
}
