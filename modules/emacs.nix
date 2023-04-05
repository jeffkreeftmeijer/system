{ pkgs, ... }:
{
  home.packages = [ pkgs.configured-emacs pkgs.elixir-ls ];
}
