{
  #"*".installation_mode = "blocked"; # blocks all addons except the ones specified below
  "chrome-mask@overengineer.dev" = {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/chrome-mask/latest.xpi";
    installation_mode = "normal_installed";
  };
  "magnolia@12.34" = {
    install_url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-latest.xpi";
    installation_mode = "normal_installed";
  };
}
