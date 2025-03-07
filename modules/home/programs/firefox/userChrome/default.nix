{ lib, ... }:
{
  default = lib.strings.concatLines (
    builtins.map builtins.readFile [
      # https://github.com/Aris-t2/CustomCSSforFx/blob/9184c0073424ad515ea3bd2dabe5e6bbcfe501b1/current/css/tabs/tab_close_hidden.css
      ./tab_close_hidden.css

      ./my_tab_mute_hidden.css
      ./my_tab_close_hidden.css
    ]
  );
}
