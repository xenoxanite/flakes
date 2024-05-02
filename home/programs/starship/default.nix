{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      line_break.disabled = true;
      cmd_duration.disabled = true;

      format = ''
        $directory
        $character'';
      right_format = "$time";

      character = {
        success_symbol = "[](green)";
        error_symbol = "[](red)";
        vimcmd_symbol = "[](teal)";
      };

      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style)) ";
        style = "blue";
        disabled = false;
      };

      time = {
        format = "[$time]($style)";
        style = "blue";
        disabled = false;
      };

      status = {
        format = "[$symbol]($style)";
        symbol = "[](red)";
        success_symbol = "[](green)";
        disabled = true;
      };

      git_branch = {
        style = "purple";
        symbol = "";
      };

      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      gcloud.symbol = " ";
      golang.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = " ";
      nim.symbol = " ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      package.symbol = " ";
      perl.symbol = " ";
      php.symbol = " ";
      python.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      swift.symbol = "ﯣ ";
      terraform.symbol = "行 ";
    };

  };
}
