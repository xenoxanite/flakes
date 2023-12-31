let ui = import ./../../theme/ui.nix { };
in {
  xdg.configFile."VencordDesktop/VencordDesktop/themes/custom.css".text =
    with ui.colors; ''
      @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@300;400;500;600;700&display=swap');
      @import url(https://mwittrien.github.io/BetterDiscordAddons/Themes/_res/SettingsIcons.css);
      .theme-dark {
          --background-primary: #${background}; /* background of background of chat window */
          --background-secondary: #${contrast}; /* background of channel bar */
          --background-secondary-alt: #${contrast};  /* background of profile */
          --channeltextarea-background: #${contrast};  /* background of textarea */
          --background-tertiary: #${statusline_bg};  /* background of channel bar */
          --background-accent: #${blue};
          --text-normal: #${foreground};
          --text-spotify: #${green};
          --text-muted: #${comments};
          --text-link: #${blue};
          --background-floating: #${statusline_bg};
          --header-primary: #${blue};
          --header-secondary: #${green};
          --header-spotify: #${green};
          --interactive-normal: #${blue};
          --interactive-hover: #${magenta};
          --interactive-active: #${blue};
          --ping: #${red};
          --background-modifier-selected: #26233ab4;
          --scrollbar-thin-thumb: #${cursorline}; 
          --scrollbar-thin-track: transparent; 
          --scrollbar-auto-thumb: #${cursorline}; 
          --scrollbar-auto-track: transparent; 
      }

      body {
          --font-display: ${ui.nerd-font};
      }
      * {
          font-family: ${ui.nerd-font} !important;
      }

      .body-2wLx-E, .headerTop-3GPUSF, .bodyInnerWrapper-2bQs1k, .footer-3naVBw {
          background-color: var(--background-tertiary);
      }

      .title-17SveM, .name-3Uvkvr{
          font-size: 12px;
      }

      .panels-3wFtMD {
          background-color: var(--background-secondary);
      }

      .username-h_Y3Us {
          font-family: var(--font-display);
          font-size: 12px;
      }

      .peopleColumn-1wMU14, .panels-j1Uci_, .peopleColumn-29fq28, .peopleList-2VBrVI, .content-2hZxGK, .header-1zd7se, .root-g14mjS .small-23Atuv .fullscreenOnMobile-ixj0e3{
          background-color: var(--background-secondary);
      }

      .textArea-12jD-V, .lookBlank-3eh9lL,  .threadSidebar-1o3BTy, .scrollableContainer-2NUZem, .perksModalContentWrapper-3RHugb, .theme-dark .footer-31IekZ, .theme-light .footer-31IekZ{
          background-color: var(--background-tertiary);
      }

      .numberBadge-2s8kKX, .base-PmTxvP, .baseShapeRound-1Mm1YW, .bar-30k2ka, .unreadMentionsBar-1Bu1dC, .mention-1f5kbO, .active-1SSsBb, .disableButton-220a9y {
          background-color: var(--ping) !important;
      }

      .lookOutlined-3sRXeN.colorRed-1TFJan, .lookOutlined-3sRXeN.colorRed-1TFJan {
          color: var(--ping) !important;
      }

      .header-3OsQeK, .container-ZMc96U {
          box-shadow: none!important;
          border: none!important;
      }

      .content-1gYQeQ, .layout-1qmrhw, .inputDefault-3FGxgL, .input-2g-os5, .input-2z42oC, .role-2TIOKu, .searchBar-jGtisZ {
          border-radius: 6px;
      }

      .layout-1qmrhw:hover, .content-1gYQeQ:hover {
          background-color: var(--background-modifier-selected)!important;
      }

      .container-3wLKDe {
          background-color: var(--background-secondary) !important;
      }

      .title-31SJ6t {
          background-color: var(--background-primary) !important;
      }
    '';
}
