{ pkgs, ... }: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        ripgrep
        fd
        # language server
        clang-tools
        nil
        lua-language-server

        # formatter
        stylua
        nixfmt
        prettierd

        # lints
        statix
        eslint_d
      ];
    };
  };
  # xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
  #   owner = "xenoxanite";
  #   repo = "nvim";
  #   rev = "main";
  #   hash = "sha256-kJZc5+IKaeA+vHLdJS4hiIOenHlR30TmPtYrCY9Tw24=";
  # };
}
