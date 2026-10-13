{ pkgs, lib, ... }:
{
  languages.javascript = {
    enable = true;
    lsp.enable = false;
    pnpm = {
      enable = true;
      install.enable = true;
      package =
        (pkgs.writeShellScriptBin "pnpm" ''
          echo "intentional pnpm install failure" >&2
          exit 23
        '')
        // {
          version = "failure-fixture";
        };
    };
  };
  enterShell = lib.mkAfter ''
    touch "$DEVENV_ROOT/after-install"
  '';
}
