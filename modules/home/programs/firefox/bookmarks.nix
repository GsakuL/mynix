[
  {
    name = "Quant";
    url = "https://www.qwant.com/?theme=1&hc=0&hti=0&vt=1&b=1&s=0&ch=none&l=en&locale=de_DE&home=daily&si=1&c=blue&eco_suggest=1&client=opensearch&q=%s";
    keyword = "q";
  }
  {
    name = "Leo DE <=> ENG";
    url = "https://dict.leo.org/englisch-deutsch/%s?side=both";
    keyword = "leo";
  }
  {
    name = "Games";
    bookmarks = [
      {
        name = "ProtonDB";
        url = "https://www.protondb.com/search?q=%s";
        keyword = "protondb";
      }
    ];
  }
  {
    name = "NixOS";
    bookmarks = [
      {
        name = "NixOS";
        url = "https://nixos.org";
      }
      {
        name = "NixOS Wiki";
        url = "https://nixos.wiki/index.php?go=Go&search=%s";
        tags = [
          "wiki"
          "nix"
        ];
        keyword = "nixwiki";
      }
      {
        name = "MyNixOS";
        url = "https://mynixos.com/search?q=%s";
        keyword = "mynix";
      }
    ];
  }
]
