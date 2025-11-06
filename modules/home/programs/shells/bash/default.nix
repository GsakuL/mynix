{
  ...
}:
{
  programs.bash = {
    bashrcExtra = builtins.readFile ./bashrcExtra.sh;
  };
}
