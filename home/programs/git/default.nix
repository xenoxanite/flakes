{pkgs,...}:{
  programs.git = {
    enable = true;
    userName = "Xenoxanite";
    userEmail = "xenoxanite@gmail.com";
  };
  home.packages = with pkgs;[
    gh
    lazygit
  ];
}
