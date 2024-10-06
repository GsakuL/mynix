rec {
  validateScriptArguments =
    num:
    let
      n = builtins.toString num;
    in
    ''
      if [[ $# -ne ${n} ]]; then
          echo "Illegal number of parameters. Expected ${n} but got $#" >&2;
          exit 2;
      fi;
    '';
  scriptWithNArgs = num: text: (validateScriptArguments num) + text;
}
