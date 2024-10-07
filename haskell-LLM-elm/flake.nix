{
  description = "A flake for Haskell, Elm, and Ollama development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: let
    system = "x86_64-linux"; # You can change this to other systems if needed
    pkgs = import nixpkgs { inherit system; overlays = [ ]; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        haskell.compiler.ghc925
        elmPackages.elm
        ollama 
      ];
      
      shellHook = ''
        echo "Welcome to the development shell for Haskell, Elm, and Ollama!"
        ollama serve &  # Start Ollama in the background when entering the shell
      '';
    };
    
    packages.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        haskell.compiler.ghc925
        elmPackages.elm
        ollama 
      ];
    };
  };
}
