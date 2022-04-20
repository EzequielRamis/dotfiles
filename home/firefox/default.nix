{ config, pkgs, lib, username, ... }: {
  programs.firefox = {
    enable = true;
    profiles."${username}" = {
      isDefault = true;
      userChrome = let monterey = "${pkgs.my.whitesur-firefox}";
      in ''
        /*------------------------USAGE----------------------------
        * Remove "/*" at the begining of "@import" line to ENABLE.
        * Add "/*" at the begining of "@import" line to DISABLE.
        */

        @import "${monterey}/theme.css"; /**/

        /*--------------Configure your Monterey theme--------------
        * ONLY for ${monterey} theme
        * Enable one of these options and disable the other ones.
        */

        /* How many buttons on left headerbar */
        /*@import "${monterey}/left_header_button_3.css"; /**/
        @import "${monterey}/left_header_button_4.css"; /**/
        /*@import "${monterey}/left_header_button_5.css"; /**/

        /* How many buttons on right headerbar */
        @import "${monterey}/right_header_button_3.css"; /**/
        /*@import "${monterey}/right_header_button_4.css"; /**/
        /*@import "${monterey}/right_header_button_5.css"; /**/


        /*--------------Configure common theme features--------------*/

        /* Move tab close button to left. */
        /*@import "${monterey}/left-tab-close-button.css"; /**/

        /* Hide the tab bar when only one tab is open (GNOMISH)
        * You should move the new tab button somewhere else for this to work, because by
        * default it is on the tab bar too. */
        /*@import "${monterey}/hide-single-tab.css"; /**/

        /* Limit the URL bar's autocompletion popup's width to the URL bar's width (GNOMISH)
        * This feature is included by default for Firefox 70+ */
        /*@import "${monterey}/matching-autocomplete-width.css"; /**/

        /* Rounded window even when it gets maximized */
        /*@import "${monterey}/rounded-window-maximized.css"; /**/

        /* Active tab high contrast */
        /*@import "${monterey}/active-tab-contrast.css"; /**/

        /* Use system theme icons instead of Adwaita icons included by theme [BUGGED] */
        /*@import "${monterey}/system-icons.css"; /**/

        /* Allow drag window from headerbar buttons (GNOMISH) [BUGGED] */
        /* It can activate button action, with unpleasant behavior. */
        /*@import "${monterey}/drag-window-headerbar-buttons.css"; /**/

        /* Make all tab icons look kinda like symbolic icons */
        /*@import "${monterey}/symbolic-tab-icons.css"; /**/

        /* Hide window buttons (close/min/max) in maximized windows */
        /*@import "${monterey}/hide-window-buttons.css"; /**/

        /* Import your custom stylesheet */
        @import "${builtins.path { path = ./customChrome.css; }}";
      '';
    };
  };
}
