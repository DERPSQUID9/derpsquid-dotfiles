{ pkgs, ... }:
{
  packages = with pkgs; [
    bear # For creating compilation databases for clangd
    clang-tools # Provides clangd lsp
    cmake # Needed for exercism C++ tests
    gnumake # Needed for exercism C and C++ tests
  ];
}