{ my, ... }:
let p = my.palette;
in ''
  @function gtkalpha($c,$a) {
    @return unquote("alpha(#{$c},#{$a})");
  }

  // base options
  @import 'theme-options-temp';
  @import 'gtk-base-temp';

  // colors palette
  @import 'colors-palette';

  // Base colors
  $base_color:                        if($variant == 'light', ${
    p."00"
  }, if($darker == 'true', ${p."0E"}, ${p."0E"}));
  $text_color:                        if($variant == 'light', ${p."0D"}, ${
    p."02"
  });
  $bg_color:                          if($variant == 'light', ${
    p."01"
  }, if($darker == 'true', ${p."0D"}, ${p."0D"}));
  $fg_color:                          if($variant == 'light', ${p."0C"}, ${
    p."03"
  });
  $alt_fg_color:                      if($variant == 'light', ${p."0A"}, ${
    p."05"
  });
  $hint_fg_color:                     if($variant == 'light', ${p."09"}, ${
    p."06"
  });

  @if $colorscheme == 'nord' {
    $base_color:                      if($variant == 'light', #fbfcfd, if($darker == 'true', #1d2025, #252932));
    $text_color:                      if($variant == 'light', #2b303b, #d3d7df);
    $bg_color:                        if($variant == 'light', #f8f9fc, if($darker == 'true', #23272f, #2b303b));
    $fg_color:                        if($variant == 'light', #1e222a, #d9dce3);
    $alt_fg_color:                    if($variant == 'light', #383f4d, #a2abbc);
    $hint_fg_color:                   if($variant == 'light', #495265, #8994a9);
  }

  $track_color:                       if($variant == 'light', rgba(black, 0.20), rgba(white, 0.16));
  $visit_color:                       if($variant == 'light', rgba(black, 0.16), rgba(white, 0.12));
  $divider_color:                     if($variant == 'light', rgba(black, 0.12), rgba(white, 0.1));
  $fill_color:                        if($variant == 'light', rgba(black, 0.06), rgba(white, 0.05));

  $light_fg_color:                    white;
  $light_alt_fg_color:                rgba(white, 0.85);
  $light_hint_fg_color:               rgba(white, 0.50);
  $light_disabled_fg_color:           rgba(white, 0.45);
  $light_alt_disabled_fg_color:       rgba(white, 0.35);
  $light_track_color:                 rgba(white, 0.28);
  $light_divider_color:               rgba(white, 0.15);

  $selected_fg_color:                 $light_fg_color;
  $selected_bg_color:                 if($colorscheme == 'nord', $nord_color_default, $theme_color_default);

  @if $theme == 'blue' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_blue, $theme_color_blue);
  }

  @if $theme == 'purple' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_purple, $theme_color_purple);
  }

  @if $theme == 'pink' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_pink, $theme_color_pink);
  }

  @if $theme == 'red' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_red, $theme_color_red);
  }

  @if $theme == 'orange' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_orange, $theme_color_orange);
  }

  @if $theme == 'yellow' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_yellow, $theme_color_yellow);
  }

  @if $theme == 'green' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_green, $theme_color_green);
  }

  @if $theme == 'grey' {
    $selected_bg_color:               if($colorscheme == 'nord', $nord_color_grey, $theme_color_grey);
  }

  $primary_color:                     $selected_bg_color;

  $selected_borders_color:            darken($selected_bg_color, 10%);
  $borders_color:                     if($variant == 'light', rgba(black, 0.12), rgba(white, 0.12));
  $light_borders_color:               if($variant == 'light', rgba(black, 0.08), rgba(white, 0.10));
  $dark_borders_color:                if($variant == 'light', rgba(black, 0.08), rgba(black, 0.15));
  $solid_borders_color:               if($variant == 'light', darken($bg_color, 12%), lighten($bg_color, 8%));
  $dark_solid_borders_color:          if($variant == 'light', darken($bg_color, 12%), darken($bg_color, 5%));
  $highlight_color:                   if($variant == 'light', rgba(white, 0.15), rgba(white, 0.1));

  // Gnome-shell background colors
  $dark_bg_color:                     rgba(black, 0.6);
  $alt_dark_bg_color:                 rgba(black, 0.3);

  // for gnome-shell keyboard
  $alt_solid_bg_color:                if($variant == 'light', ${p."05"}, ${
    p."0A"
  });
  $solid_bg_color:                    if($variant == 'light', ${p."03"}, ${
    p."0B"
  });

  @if $colorscheme == 'nord' {
    $solid_bg_color:                  if($variant == 'light', #eaecf0, #464f62);
    $alt_solid_bg_color:              if($variant == 'light', #b6bdca, #1e222a);
  }

  // Link colors
  $link_color:                        if($colorscheme == 'nord', #5e81ac, ${
    p."68"
  });
  $link_visited_color:                if($variant == 'light', lighten($text_color, 10%), darken($text_color, 15%));

  // Theme colors
  $selection_mode_bg:                 lighten($selected_bg_color, 15%);
  $warning_color:                     if($colorscheme == 'nord', $nord_color_orange, $theme_color_orange);
  $error_color:                       if($colorscheme == 'nord', $nord_color_red, $theme_color_red);
  $success_color:                     if($colorscheme == 'nord', $nord_color_green, $theme_color_green);
  $destructive_color:                 if($colorscheme == 'nord', $nord_color_red, $theme_color_red);
  $suggested_color:                   if($colorscheme == 'nord', $nord_color_blue, $theme_color_blue);

  $progress_color:                    $selected_bg_color;
  $drop_target_color:                 if($colorscheme == 'nord', $nord_color_orange, $theme_color_orange);

  //insensitive state derived colors
  $disabled_fg_color:                 if($variant == 'light', transparentize($fg_color, 0.55), transparentize($fg_color, 0.65));
  $alt_disabled_fg_color:             if($variant == 'light', transparentize($alt_fg_color, 0.55), transparentize($alt_fg_color, 0.65));
  $disabled_bg_color:                 if($variant == 'light', mix($bg_color, $base_color, 40%), lighten($bg_color, 2%));

  // Headerbar colors
  $header_bg:                         if($variant == 'light', ${
    p."00"
  }, if($darker == 'true', ${p."0F"}, ${p."0F"}));
  $header_highlight:                  if($variant == 'dark', if($darker == 'true', ${
    p."0E"
  }, ${p."0E"}), ${p."01"}); // For metacity
  $header_fg:                         if($variant == 'light', ${p."09"}, ${
    p."02"
  });

  @if $colorscheme == 'nord' {
    $header_bg:                       if($variant == 'light', #fbfcfd, if($darker == 'true', #191c23, #2e3440));
    $header_highlight:                if($variant == 'dark', if($darker == 'true', #1e222a, #383f4e), #f3f4f7); // For metacity
    $header_fg:                       if($variant == 'light', #57647f, #f8f9fc);
  }

  $dark_header_bg:                    if($trans == 'true', rgba($base_color, 0.96), $base_color);
  $header_bg_backdrop:                if($variant == 'light', darken($header_bg, 0%), darken($header_bg, 0%));
  $header_border:                     if($variant == 'light', mix(black, $header_bg, 12%), mix(black, $header_bg, 75%));

  // Sidebar colors
  $dark_sidebar_bg: white;

  @if $trans=='true' and $variant=='light' {
    $dark_sidebar_bg:                 rgba(if($colorscheme == 'nord', #eeeff2, ${
      p."01"
    }), 0.96);
  }

  @if $trans=='false' and $variant=='light' {
    $dark_sidebar_bg:                 if($colorscheme == 'nord', #eeeff2, ${
      p."01"
    });
  }

  @if $trans=='true' and $variant=='dark' {
    @if $colorscheme == 'nord' {
      $dark_sidebar_bg:               rgba(if($darker == 'true', #22262e, #2b303b), 0.96);
    } @else {
      $dark_sidebar_bg:               rgba(if($darker == 'true', ${p."0D"}, ${
        p."0D"
      }), 0.96);
    }
  }

  @if $trans=='false' and $variant=='dark' {
    @if $colorscheme == 'nord' {
      $dark_sidebar_bg:               if($darker == 'true', #22262e, #2b303b);
    } @else {
      $dark_sidebar_bg:               if($darker == 'true', ${p."0D"}, ${
        p."0D"
      });
    }
  }

  $dark_sidebar_fg:                   $text_color;
  $dark_sidebar_border:               if($variant == 'light', $solid_borders_color, $header_border);
  $sidebar_theme_color:               if($variant == 'light', rgba(black, 0.12), rgba(white, 0.12));

  //OSD colors
  $osd_fg_color:                      if($colorscheme == 'nord', #dadada, ${
    p."03"
  });
  $osd_bg_color:                      if($trans == 'true', rgba(if($darker == 'true', ${
    p."0E"
  }, ${p."0E"}), 0.9), if($darker == 'true', ${p."0E"}, ${p."0E"}));
  @if $colorscheme == 'nord' {
    $osd_bg_color:                    if($trans == 'true', rgba(if($darker == 'true', #16191e, #222730), 0.9), if($darker == 'true', #16191e, #222730));
  }
  $osd_button_bg:                     rgba(lighten($osd_bg_color, 22%), 0.96);
  $osd_button_border:                 $dark_borders_color;
  $osd_entry_bg:                      rgba(lighten($osd_bg_color, 22%), 0.96);
  $osd_entry_border:                  $dark_borders_color;
  $osd_disabled_bg_color:             darken($osd_bg_color, 3%);
  $osd_disabled_fg_color:             rgba($osd_fg_color, 0.35);
  $osd_borders_color:                 $dark_borders_color;

  // Menu colors
  $menu_bg:                           if($variant == 'light', $base_color, $bg_color);
  $menu_bd:                           if($variant == 'light', rgba(black, 0.05), rgba(white, 0.08));

  @if $trans == 'true' {
    $menu_bg:                         if($variant == 'light', rgba($base_color, 0.95), rgba($bg_color, 0.95));
  }

  $dialog_bg_color:                   if($variant == 'light', darken($bg_color, 5%), $base_color);

  @if $trans=='true' {
    $dialog_bg_color:                 if($variant == 'light', rgba($bg_color, 0.95), rgba($base_color, 0.95));
  }

  $submenu_bg_color:                  if($variant == 'light', rgba(white, 1), rgba(white, 0.1));

  @if $trans=='true' {
    $submenu_bg_color:                if($variant == 'light', rgba(white, 0.75), rgba(white, 0.15));
  }

  @if $colorscheme == 'nord' {
    $submenu_bg_color:                  if($variant == 'light', rgba(#fbfcfd, 1), rgba(#fbfcfd, 0.1));

    @if $trans=='true' {
      $submenu_bg_color:                if($variant == 'light', rgba(#fbfcfd, 0.75), rgba(#464f60, 0.75));
    }
  }

  // Panel colors
  $panel_bg:                          if($variant == 'light', ${
    p."01"
  }, if($darker == 'true', ${p."0D"}, ${p."0D"}));

  @if $colorscheme == 'nord' {
    $panel_bg:                        if($variant == 'light', #f0f1f4, if($darker == 'true', #1a1d24, #222730));
  }

  @if $trans == 'true' {
    $panel_bg:                        if($variant == 'light', rgba(white, $panel_opacity/2 + 0.08), rgba(black, $panel_opacity));

    @if $panel_font == 'black' {
      $panel_bg:                      if($variant == 'light', rgba(white, $panel_opacity/2 + 0.08), rgba(black, $panel_opacity/2));
    }

    @if $colorscheme == 'nord' {
      $panel_bg:                      if($variant == 'light', rgba(#9da8be, $panel_opacity/2 + 0.12), rgba(#1a1d23, $panel_opacity + 0.08));
    }
  }

  $panel_text:                        if($variant == 'light', ${p."0A"}, white);

  @if $colorscheme == 'nord' {
    $panel_text:                      if($variant == 'light', #2d333f, #fbfcfd);
  }

  $panel_fg:                          if($trans == 'true' and $panel_font == 'white', white, $panel_text);
  $panel_track:                       if(($trans == 'false' or $panel_font == 'black') and $variant == 'light', rgba(black, 0.15), rgba(white, 0.28));
  $panel_divider:                     if(($trans == 'false' or $panel_font == 'black') and $variant == 'light', rgba(black, 0.08), rgba(white, 0.15));

  $dash_fg:                           if($variant == 'light', black, white);
  $dash_bg:                           if($variant == 'light', rgba(${
    p."03"
  }, $panel_opacity + 0.33), rgba(if($darker == 'true', ${p."0C"}, ${
    p."0C"
  }), $panel_opacity/2 + 0.6));

  @if $trans == 'true' and $panel_font == 'black' {
    $dash_bg:                         if($variant == 'light', rgba(${
      p."03"
    }, $panel_opacity/2 + 0.08), rgba(if($darker == 'true', ${p."0C"}, ${
      p."0C"
    }), $panel_opacity + 0.15));
  }

  @if $colorscheme == 'nord' {
    $dash_bg:                         if($variant == 'light', rgba(#9da8be, $panel_opacity + 0.33), rgba(if($darker == 'true', #1a1d24, #1d2027), $panel_opacity/2 + 0.6));

    @if $trans == 'true' and $panel_font == 'black' {
      $dash_bg:                       if($variant == 'light', rgba(#9da8be, $panel_opacity/2 + 0.28), rgba(if($darker == 'true', #1a1d24, #1d2027), $panel_opacity + 0.15));
    }
  }

  // Entry colors
  $entry_bg:                          if($variant == 'light', rgba(black, 0.05), rgba(white, 0.05));
  $entry_shell_bg:                    if($variant == 'light', rgba(black, 0.1), rgba(white, 0.1));
  $entry_border:                      $borders_color;
  $entry_highlight:                   rgba($selection_mode_bg, 0.75);

  // Button colors
  $button_bg:                         if($variant == 'light', white, ${p."0B"});
  @if $colorscheme == 'nord' {
    $button_bg:                       if($variant == 'light', #fbfcfd, #556075);
  }
  $button_border:                     $borders_color;

  $header_button_bg:                  if($variant == 'dark', lighten($header_bg, 15%), $header_bg);
  $header_button_hover_bg:            if($variant == 'dark', lighten($header_bg, 25%), lighten($header_bg, 15%));
  $header_button_active_bg:           if($variant == 'dark', lighten($header_bg, 35%), lighten($header_bg, 25%));
  $header_button_checked_bg:          if($variant == 'dark', lighten($header_bg, 45%), lighten($header_bg, 20%));

  // Button borders and highlights colors
  $button_highlight:                  if($variant == 'light', white, rgba(white, 0.1));
  $button_borders:                    if($variant == 'light', $button_border, $dark_borders_color);

  // WM colors
  $wm_outline_light:                  0 0 0 2px rgba(black, 0.03), 0 0 0 1px rgba(black, 0.12);
  $wm_outline_dark:                   0 0 0 2px rgba(black, 0.1), 0 0 0 1px rgba(black, 0.75);
  $wm_shadow:                         if($variant=='light', rgba(black, 0.15), rgba(black, 0.35));
  $wm_outline:                        if($variant=='light', $wm_outline_light, $wm_outline_dark);

  // WM Buttons

  // Close
  $wm_button_close_bg:                if($variant == 'light', ${p."16"}, ${
    p."17"
  });
  $wm_button_close_hover_bg:          if($variant == 'light', ${p."17"}, ${
    p."18"
  });
  $wm_button_close_active_bg:         if($variant == 'light', ${p."18"}, ${
    p."19"
  });
  $wm_button_close_border:            if($variant == 'light', ${p."1D"}, ${
    p."1D"
  });
  $wm_icon_close_bg:                  if($variant == 'light', ${p."1D"}, ${
    p."1D"
  });

  // Minimize
  $wm_button_minimize_bg:             if($variant == 'light', ${p."34"}, ${
    p."35"
  });
  $wm_button_minimize_hover_bg:       if($variant == 'light', ${p."35"}, ${
    p."36"
  });
  $wm_button_minimize_active_bg:      if($variant == 'light', ${p."36"}, ${
    p."37"
  });
  $wm_button_minimize_border:         if($variant == 'light', ${p."3D"}, ${
    p."3D"
  });
  $wm_icon_minimize_bg:               if($variant == 'light', ${p."3D"}, ${
    p."3D"
  });

  // Maximize
  $wm_button_maximize_bg:             if($variant == 'light', ${p."46"}, ${
    p."47"
  });
  $wm_button_maximize_hover_bg:       if($variant == 'light', ${p."47"}, ${
    p."48"
  });
  $wm_button_maximize_active_bg:      if($variant == 'light', ${p."48"}, ${
    p."49"
  });
  $wm_button_maximize_border:         if($variant == 'light', ${p."4D"}, ${
    p."4D"
  });
  $wm_icon_maximize_bg:               if($variant == 'light', ${p."4D"}, ${
    p."4D"
  });
''
