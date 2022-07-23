{ my, ... }:
let p = my.palette;
in ''
  //apps rely on some named colors to be exported

  // Sass thinks we're using the colors in the variables as strings and may shoot
  // warning, it's innocuous and can be defeated by using "" + $var

  $theme_text: currentColor;

  @define-color theme_fg_color #{"" + $fg_color};
  @define-color theme_text_color #{"" + $theme_text};
  @define-color theme_bg_color #{"" + $bg_color};
  @define-color theme_base_color #{"" + $base_color};
  @define-color theme_selected_bg_color #{"" + $selected_bg_color};
  @define-color theme_selected_fg_color #{"" + $selected_fg_color};
  @define-color fg_color #{"" + $fg_color};
  @define-color text_color #{"" + $theme_text};
  @define-color bg_color #{"" + $bg_color};
  @define-color base_color #{"" + $base_color};
  @define-color selected_bg_color #{"" + $selected_bg_color};
  @define-color selected_fg_color #{"" + $selected_fg_color};
  @define-color insensitive_bg_color #{"" + mix($bg_color, $base_color, 60%)};
  @define-color insensitive_fg_color #{"" + $disabled_fg_color};
  @define-color insensitive_base_color #{"" + $base_color};
  @define-color theme_unfocused_fg_color #{"" + $fg_color};
  @define-color theme_unfocused_text_color #{"" + $theme_text};
  @define-color theme_unfocused_bg_color #{"" + $bg_color};
  @define-color theme_unfocused_base_color #{"" + $base_color};
  @define-color unfocused_insensitive_color #{"" + mix($fg_color, $bg_color, 35%)};
  @define-color borders #{"" + $borders_color};
  @define-color unfocused_borders #{"" + $borders_color};

  @define-color warning_color #{"" + $warning_color};
  @define-color error_color #{"" + $error_color};
  @define-color success_color #{"" + $success_color};
  @define-color placeholder_text_color #{${p."03"}};
  @define-color link_color #{"" + $link_color};
  @define-color content_view_bg #{"" + $base_color};

  @define-color solid_bg_color #{"" + $solid_bg_color};
  @define-color alt_solid_bg_color #{"" + $alt_solid_bg_color};

  /* Very contrasty background for text views (@theme_text_color foreground) */
  @define-color text_view_bg #{"" + if($variant == 'light', $base_color, darken($base_color, 6%))};

  //WM

  $wm_borders_focused: if($variant == 'light', darken($header_bg, 15%), darken($header_bg, 20%));
  $wm_borders_unfocused: if($variant == 'light', darken($header_bg, 10%), darken($header_bg, 15%));

  @define-color wm_title alpha(#{"" + opacify($header_fg, 1)}, 0.8);
  @define-color wm_unfocused_title alpha(#{"" + opacify($header_fg, 1)}, 0.5);

  @define-color wm_bg #{"" + opacify($header_bg, 1)};
  @define-color wm_bg_unfocused #{"" + opacify($header_bg_backdrop, 1)};

  @define-color wm_border_focused #{"" + $wm_borders_focused};
  @define-color wm_border_unfocused #{"" + $wm_borders_unfocused};

  @define-color wm_highlight alpha(#{white}, 0.12);
  @define-color wm_shadow alpha(#{black}, 0.75);

  //WM Buttons

  // Close
  @define-color wm_button_close_bg #{"" + $wm_button_close_bg};
  @define-color wm_button_close_hover_bg #{"" + $wm_button_close_hover_bg};
  @define-color wm_button_close_active_bg #{"" + $wm_button_close_active_bg};

  @define-color wm_icon_close_bg #{"" + $wm_icon_close_bg};

  // Minimize, Maximize
  @define-color wm_button_hover_bg #{"" + $bg_color};
  @define-color wm_button_active_bg #{"" + $bg_color};

  @define-color wm_button_hover_border #{"" + $solid_borders_color};

  @define-color wm_icon_bg #{"" + $alt_fg_color};
  @define-color wm_icon_unfocused_bg #{"" + $alt_disabled_fg_color};
  @define-color wm_icon_hover_bg #{"" + $fg_color};
  @define-color wm_icon_active_bg #{"" + $fg_color};

  // Titlebar
  @define-color titlebar_gradient_a #{"" + $header_bg};
  @define-color titlebar_gradient_b #{"" + $header_bg};

  //
  // Budgie-desktop specific indicator colours
  //

  // unfocused window 'dot(s)'
  @define-color budgie_tasklist_indicator_color #{"" + $fg_color};
  // focused window 'line'
  @define-color budgie_tasklist_indicator_color_active #{"" + $selected_bg_color};
  // group-ed and unfocused window 'line(s)'
  @define-color budgie_tasklist_indicator_color_active_window #{"" + mix($selected_bg_color, opacify($header_bg, 1), 35%)};
  // attention 'dot'
  // FIXME: we can't fill whole widget backgrounds with our suggestion colour
  //        because of lacking specific style-class on 'needs_attention' state,
  //        so use warning orange dot instead.
  @define-color budgie_tasklist_indicator_color_attention #{"" + $warning_color};

  //
  // Color Palette Definitions for compatibility with Granite.
  //

  //* Strawberry *
  @define-color STRAWBERRY_100 #{${p."24"}};
  @define-color STRAWBERRY_300 #{${p."25"}};
  @define-color STRAWBERRY_500 #{${p."26"}};
  @define-color STRAWBERRY_700 #{${p."18"}};
  @define-color STRAWBERRY_900 #{${p."1B"}};
  //* Orange *
  @define-color ORANGE_100 #{${p."22"}};
  @define-color ORANGE_300 #{${p."23"}};
  @define-color ORANGE_500 #{${p."25"}};
  @define-color ORANGE_700 #{${p."26"}};
  @define-color ORANGE_900 #{${p."28"}};
  //* Banana *
  @define-color BANANA_100 #{${p."31"}};
  @define-color BANANA_300 #{${p."32"}};
  @define-color BANANA_500 #{${p."34"}};
  @define-color BANANA_700 #{${p."35"}};
  @define-color BANANA_900 #{${p."38"}};
  //* Lime *
  @define-color LIME_100 #{${p."41"}};
  @define-color LIME_300 #{${p."43"}};
  @define-color LIME_500 #{${p."45"}};
  @define-color LIME_700 #{${p."48"}};
  @define-color LIME_900 #{${p."4B"}};
  //* Blueberry *
  @define-color BLUEBERRY_100 #{${p."75"}};
  @define-color BLUEBERRY_300 #{${p."77"}};
  @define-color BLUEBERRY_500 #{${p."7A"}};
  @define-color BLUEBERRY_700 #{${p."7C"}};
  @define-color BLUEBERRY_900 #{${p."7E"}};
  //* Grape *
  @define-color GRAPE_100 #{${p."76"}};
  @define-color GRAPE_300 #{${p."77"}};
  @define-color GRAPE_500 #{${p."79"}};
  @define-color GRAPE_700 #{${p."7B"}};
  @define-color GRAPE_900 #{${p."7C"}};
  //* Cocoa *
  @define-color COCOA_100 #{${p."06"}};
  @define-color COCOA_300 #{${p."08"}};
  @define-color COCOA_500 #{${p."3B"}};
  @define-color COCOA_700 #{${p."3C"}};
  @define-color COCOA_900 #{${p."3E"}};
  //* Silver *
  @define-color SILVER_100 #{${p."03"}};
  @define-color SILVER_300 #{${p."04"}};
  @define-color SILVER_500 #{${p."05"}};
  @define-color SILVER_700 #{${p."07"}};
  @define-color SILVER_900 #{${p."08"}};
  //* Slate *
  @define-color SLATE_100 #{${p."07"}};
  @define-color SLATE_300 #{${p."08"}};
  @define-color SLATE_500 #{${p."0A"}};
  @define-color SLATE_700 #{${p."0B"}};
  @define-color SLATE_900 #{${p."0D"}};
  //* Black *
  @define-color BLACK_100 #{${p."0B"}};
  @define-color BLACK_300 #{${p."0C"}};
  @define-color BLACK_500 #{${p."0D"}};
  @define-color BLACK_700 #{${p."0E"}};
  @define-color BLACK_900 #{${p."0F"}};
''
