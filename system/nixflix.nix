{
  lib,
  pkgs,
  ...
}:
{
  nixflix = {
    enable = true;
    mediaDir = "/ssd/media";
    stateDir = "/ssd/.media_state";

    # Reverse proxy: choose one
    nginx.enable = true;
    # caddy.enable = true;

    postgres.enable = true;

    torrentClients.qbittorrent = {
      enable = true;
      webuiPort = 8080;
      extraArgs = [ "--confirm-legal-notice" ];
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences = {
          WebUI = {
            LocalHostAuth = false;
            Username = "admin";
            Password_PBKDF2 = "@ByteArray(ARQ77eY1NUZaQsuDHbIMCA==:0WMRkYTUWVT9wVvdDtHAjU9b3b7uB8NR1Gur2hmQCvCDpm39Q+PsJRJPaCU51dEiz+dTzh8qbPsL8WkFljQYFQ==)";
          };
        };
        BitTorrent.Session = {
          GlobalMaxRatio = 0;
          GlobalMaxRatioAction = 0;
        };
      };
    };

    sonarr = {
      enable = true;
      config = {
        apiKey._secret = pkgs.writeText "sonarr-apikey" "37eaae82f364ed5baa820360050de348";
        hostConfig = {
          username = "admin";
          password = "admin";
        };
      };
    };

    radarr = {
      enable = true;
      config = {
        apiKey._secret = pkgs.writeText "radarr-apikey" "14a2f78dd70413d22b115daeea19eb4d";
        hostConfig = {
          username = "admin";
          password = "admin";
        };
      };
    };

    prowlarr = {
      enable = true;
      config = {
        apiKey._secret = pkgs.writeText "prowlarr-apikey" "ce959f39113c50090991492eb89e7996";
        hostConfig = {
          username = "admin";
          password = "admin";
        };
        indexers = [
          # {
          #   name = "The Pirate Bay";
          # }
          # {
          #   name = "LimeTorrents";
          # }

          # Cloudflare protection
          # {
          #   name = "TorrentGalaxyClone";
          # }
          # {
          #   name = "EZTV";
          # }
          # {
          #   name = "1337x";
          #   tags = [ "flaresolverr" ];
          # }
        ];
      };
    };

    jellyfin = {
      enable = true;
      apiKey._secret = pkgs.writeText "jellyfin-apikey" "120c534aeed0e4782db9140e2ca408be";
      users.admin = {
        policy.isAdministrator = true;
        password = "admin";
      };
    };
  };
}
