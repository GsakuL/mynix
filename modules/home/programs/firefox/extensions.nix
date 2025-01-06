{
  #"*".installation_mode = "blocked"; # blocks all addons except the ones specified below
  "chrome-mask@overengineer.dev" = {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/chrome-mask/latest.xpi";
    installation_mode = "force_installed";
  };
}
