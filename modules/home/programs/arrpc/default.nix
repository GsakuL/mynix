{
  system-config,
  pkgs,
  lib,
  pkgs-alt,
  ...
}:
{

  services.arrpc = {
    enable = true; # vesktop
    package = (
      pkgs.buildNpmPackage rec {
        pname = "arrpc";
        version = "3.5.0";

        src = pkgs.fetchFromGitHub {
          owner = "OpenAsar";
          repo = "arrpc";
          rev = version;
          hash = "sha256-3xkqWcLhmSIH6Al2SvM9qBpdcLzEqUmUCgwYBPAgVpo=";
        };
        preBuild = ''
          # https://discord.com/api/v9/applications/detectable
          cp ${./.}/detectable.json src/process/detectable.json
        '';
        npmDepsHash = "sha256-lw6pngFC2Pnk+I8818TOTwN4r+8IsjvdMYIyTsTi49g=";

        dontNpmBuild = true;

        meta = {
          mainProgram = "arrpc";
        };
      }
    );
  };
}
