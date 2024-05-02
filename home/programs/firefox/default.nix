{ pkgs, config, lib, inputs, user, ... }: {
  options.firefox.enable = lib.mkEnableOption "Firefox";
  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPrefs = ''
          // Show more ssl cert infos
          lockPref("security.identityblock.show_extended_validation",true);
          lockPref("browser.EULA.override",true);
          lockPref("browser.tabs.inTitlebar",0);
          lockPref("browser.tabs.tabmanager.enabled",false);
          lockPref("gfx.webrender.all",true);
          // Allow search shortcuts
          lockPref("keyword.enabled",true);
          lockPref("webgl.disabled",false);
          lockPref("media.ffmpeg.vaapi.enabled",true);
          lockPref("media.ffvpx.enabled",true);
          lockPref("media.rdd-vpx.enabled",false);
          lockPref("media.navigator.mediadatadecoder_vpx_enabled",true);
          // Enable DRM
          lockPref("media.eme.enabled",true);

          // History & Session
          // delete history after one week
          lockPref("browser.history_expire_days",7);
          // restore pinned tabs
          lockPref("browser.sessionstore.restore_pinned_tabs_on_demand",true);

          lockPref("privacy.sanitize.sanitizeOnShutdown", false);
          lockPref("privacy.clearOnShutdown.cache", false);
          lockPref("privacy.clearOnShutdown.history", false);
          lockPref("privacy.clearOnShutdown.sessions", false);

          // remove the screenborders, makes you fingerprintable
          lockPref("privacy.resistFingerprinting.letterboxing",false);
          // Use system colors
          lockPref("browser.display.use_system_colors",true);
          // Enable startup page
          lockPref("browser.startup.page",0);
          // Enable search suggestions
          lockPref("browser.search.suggest.enabled",true);
          lockPref("browser.search.suggest.searches",true);
          // speed
          lockPref("network.http.max-persistent-connections-per-server", 30);
          lockPref("browser.cache.disk.enable", false);
          // disable pocket and firefox view
          lockPref("extensions.pocket.enabled", false);
          lockPref("browser.tabs.firefox-view",false);
          lockPref("browser.tabs.firefox-view-next",false);
          lockPref("browser.tabs.firefox-view-newIcon",false);
        '';
        extraPolicies = {
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          CaptivePortal = false;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          Cookies = { RejectTracker = true; };
          FirefoxHome = {
            Search = false;
            Pocket = false;
            SponsoredTopSites = false;
            SponsoredPocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };

          DisableFormHistory = true;
          DontCheckDefaultBrowser = true;

          enableArkenfoxUserjs = true;
          ExtensionSettings = {
            "ebay@search.mozilla.org".installation_mode = "blocked";
            "amazondotcom@search.mozilla.org".installation_mode = "blocked";
            "google@search.mozilla.org".installation_mode = "blocked";
            "bing@search.mozilla.org".installation_mode = "blocked";
            "wikipedia@search.mozilla.org".installation_mode = "blocked";
          };
        };
      };
      profiles.default = {
        name = "${user}";
        isDefault = true;
        extraConfig = builtins.readFile "${inputs.hardened-firefox}/user.js";
        search = {
          engines = {
            "Bing".metaData.hidden = true;
            "Amazon".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "eBay".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
            "DuckDuckGo".metaData.alias = "@d";
            "MyNixOS" = {
              urls =
                [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
              definedAliases = [ "@mn" ];
            };
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }];
              icon =
                "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
          };
          force = true;
          default = "DuckDuckGo";
          order = [ "DuckDuckGo" "Nix Packages" ];
        };
        userChrome = if config.pywal.enable then
          builtins.readFile (./userChrome-pywal.css)
        else
          builtins.readFile (./userChrome.css);
        settings = {
          "browser.compactmode.show" = true;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.fullscreen.autohide" = false;
          "browser.search.region" = "US";
          "browser.search.isUS" = true;
          "distribution.searchplugins.defaultLocale" = "en-US";
          "general.useragent.locale" = "en-US";
          "browser.bookmarks.showMobileBookmarks" = true;
          # Fix big fonts in 1080p screen
          "layout.css.devPixelsPerPx" = 0.98;
          # Downloading random PDFs from http website is super annoing with this.
          # "dom.block_download_insecure" = false;

          # Always use XDG portals for stuff
          "widget.use-xdg-desktop-portal.file-picker" = 2;

          # Enable userChrome.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Automatically enable extensions installed by home-manager
          "extensions.autoDisableScopes" = 0;

          # Deactivate disk cache to reduce unnecessary disk writes
          "browser.cache.disk.enable" = false;
          "browser.cache.memory.enable" = true;
          "browser.cache.memory.capacity" = 1048576; # 1GiB

          # Autoplay
          "media.autoplay.block-event.enabled" = true;
          "media.autoplay.default" = 5;

          # UI
          "browser.uidensity" = 1;
          "browser.tabs.inTitlebar" = 0;

          # Enable DRM :(
          "media.eme.enabled" = true;

          # Enable HTTPS only mode
          "dom.security.https_only_mode" = true;

          # Show punycode in URLs to prevent homograph attacks
          "network.IDN_show_punycode" = true;

          # Extensions
          "extensions.enabledScopes" = 5;
          "extensions.webextensions.restrictedDomains" = "";

          # Disable annoying firefox functionality
          "browser.aboutConfig.showWarning" = false; # about:config warning
          "browser.aboutwelcome.enabled" = false;
          "browser.formfill.enable" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.translations.automaticallyPopup" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.pocket.enabled" = false;
          "identity.fxaccounts.enabled" = false; # Firefox sync
          "privacy.webrtc.legacyGlobalIndicator" = false; # Sharing indicator
          "signon.autofillForms" = false;
          "signon.rememberSignons" = false;

          # Disable telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          permissions = { "default.desktop-notification" = false; };
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          vimium-c
          darkreader
          videospeed
          pywalfox
          search-by-image
        ];
      };
    };
    home = {
      sessionVariables = {
        BROWSER = "firefox";
        MOZ_DISABLE_CONTENT_SANDBOX = 1;
      };
    };
  };
}
