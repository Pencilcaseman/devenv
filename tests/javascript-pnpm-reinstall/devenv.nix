{ pkgs, ... }:
{
  languages.javascript = {
    enable = true;
    lsp.enable = false;
    pnpm = {
      enable = true;
      install.enable = true;
      # pnpm 10 prompts before replacing a modules directory. Newer majors
      # have different behavior and would not exercise this regression.
      package = pkgs.pnpm_10;
    };
  };
}
