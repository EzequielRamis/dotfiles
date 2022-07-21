{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ eww ];
  xdg.configFile."eww/eww.yuck".source = ./eww.yuck;
  xdg.configFile."eww/eww.css".source = ./eww.css;

  xdg.configFile."eww/scripts/workspace".source = ./scripts/workspace;
  xdg.configFile."eww/scripts/workspace".executable = true;

  xdg.configFile."eww/scripts/spotify".source = ./scripts/spotify;
  xdg.configFile."eww/scripts/spotify".executable = true;

  xdg.configFile."eww/assets/corner-light.svg".text = ''
    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path fill="black" d="M0 16C0.272467 7.67099 7.33615 1 16 1V0H0V16Z"/>
      <path fill="red" d="M16 0L0 10.9088C2.25569 4.82595 8.08573 0.418111
                          15 0.0281273L16 0ZM16 1C7.33614 1 0.280634 7.67099
                          0.00816727 16L0 10.9088L16 0V1Z"
      />
    </svg>
  '';
}
