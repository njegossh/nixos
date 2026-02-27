{ ... } : {
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Marko";
      isDefault = true;
      containers = {
        Personal = { color = "orange";   icon = "fingerprint"; id = 1; };
        Work =     { color = "red";      icon = "briefcase";   id = 2; };
        Shop =     { color = "green";    icon = "cart";        id = 3; };
        Uni =      { color = "purple";   icon = "fence";       id = 4; };
        I2P =      { color = "toolbar";  icon = "chill";       id = 5; };
        Business = { color = "yellow";   icon = "briefcase";   id = 6; };
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";

        @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");

        /* --- Hide by default --- */
        #star-button-box,
        #back-button,
        #forward-button,
        #tracking-protection-icon-box,
        #identity-box { display: none !important; }

        /* --- Show only on dangerous/error pages (pageproxystate="invalid") --- */
        /* This matches about:blocked, about:certerror, about:neterror, etc. */
        *:root[privatebrowsingmode="temporary"] #nav-bar:not([customizing]) {
          /* Optional: keep icons hidden in PB mode too */
        }

        /* Show identity/tracking icons *and* nav buttons on error pages */
        #main-window[pageproxystate="invalid"] #identity-box,
        #main-window[pageproxystate="invalid"] #tracking-protection-icon-box,
        #main-window[pageproxystate="invalid"] #back-button,
        #main-window[pageproxystate="invalid"] #forward-button {
          display: -moz-box !important; /* or display: flex !important; in newer Firefox */
        }

        /* Also ensure nav buttons appear when back is enabled (i.e., history exists) */
        #main-window:not([pageproxystate="invalid"]) #back-button:not([disabled]) {
          display: -moz-box !important;
        }

        /* And forward if back is enabled (they’re usually linked) */
        #main-window:not([pageproxystate="invalid"]) #back-button:not([disabled]) ~ #forward-button {
          display: -moz-box !important;
        }
      '';
    };
  };
}
