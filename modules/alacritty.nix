{
  home-manager.users.jeff.programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 15;
        normal.family = "Iosevka";
      };
      colors = {
        normal = {
          black = "#1d2235";
          red = "#ff5f59";
          green = "#44bc44";
          yellow = "#d0bc00";
          blue = "#2fafff";
          magenta = "#feacd0";
          cyan = "#00d3d0";
          white = "#ffffff";
        };
        bright = {
          black = "#4a4f69";
          red = "#ff7f9f";
          green = "#00c06f";
          yellow = "#dfaf7a";
          blue = "#00bcff";
          magenta = "#b6a0ff";
          cyan = "#6ae4b9";
          white = "#989898";
        };
        cursor = {
          cursor = "#ffffff";
          text = "#0d0e1c";
        };
        primary = {
          background = "#0d0e1c";
          foreground = "#ffffff";
        };
        selection = {
          background = "#555a66";
          text = "#ffffff";
        };
      };
    };
  };
}
