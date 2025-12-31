#Shell.nix without building nix over and over agin (Generation SB)

#CUDA_EST_PACKAGES

/*{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.python311Packages.virtualenv
    pkgs.gcc
    pkgs.cudaPackages.cudatoolkit
  ];

  shellHook = ''
    # Fix: Use stdenv.cc.cc.lib for the standard C++ library paths
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH"
    
    echo "Nix shell ready: Python + CUDA + GCC"
    echo "Unfree packages (CUDA) allowed."
  '';
}
*/

#==================================================================================================================

#CUDA_12

{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  packages = [
    pkgs.python311
    pkgs.python311Packages.virtualenv
    pkgs.python311Packages.torch-bin
    pkgs.cudaPackages_12.cudatoolkit
    pkgs.cudaPackages_12.cudnn
    pkgs.gcc
  ];

  shellHook = ''
    export CUDA_HOME=${pkgs.cudaPackages_12.cudatoolkit}
    export LD_LIBRARY_PATH=${pkgs.cudaPackages_12.cudatoolkit}/lib:${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    echo "Nix shell ready: PyTorch (CUDA) + Python"
  '';
}

