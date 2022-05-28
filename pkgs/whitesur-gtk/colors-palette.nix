{ my, ... }:
let p = my.palette;
in ''
  //
  // Normal colors
  //

  $theme_color_default: ${p."68"};
  $theme_color_blue:    ${p."67"};
  $theme_color_purple:  ${p."77"};
  $theme_color_pink:    ${p."76"};
  $theme_color_red:     ${p."17"};
  $theme_color_orange:  ${p."26"};
  $theme_color_yellow:  ${p."34"};
  $theme_color_green:   ${p."46"};
  $theme_color_grey:    ${p."08"};

  //
  // Nord colors
  //

  $nord_color_default:  #5271ad;
  $nord_color_blue:     #4c7bd9;
  $nord_color_purple:   #b57daa;
  $nord_color_pink:     #cd7092;
  $nord_color_red:      #c35b65;
  $nord_color_orange:   #d0846c;
  $nord_color_yellow:   #e4b558;
  $nord_color_green:    #82ac5d;
  $nord_color_grey:     #8999a9;
''
