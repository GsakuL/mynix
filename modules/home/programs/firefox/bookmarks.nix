let
  /*
    https://gist.github.com/JamesDBartlett3/9820db1be59b38431fee8cf138127e49
    Credit: Mike Dombrowski (https://mikedombrowski.com/2019/03/fix-youtube-mono-one-ear-audio/)

    https://gist.github.com/meta-ks/d09d3d44959fdf4561f12f22edc7065c
  */
  withAudioContextFunc =
    action:
    let
      # random name to avoid potential collision (?)
      globalAudioContext = "(globalThis || window).myAudioContext_s14d4sd485sa4d44a4d45a4d54a";
    in
    ''
      (function(){
        var ctx = ${globalAudioContext};
        if (!ctx)
        {
          var video = document.querySelector('video');
          var audio = new (window.AudioContext || window.webkitAudioContext)();

          var gain = audio.createGain();
          var elementSource = audio.createMediaElementSource(video);

          elementSource.connect(gain);
          gain.connect(audio.destination);

          ${globalAudioContext} = ctx = { audio: audio, gain: gain };
        }
        ;${action};
      })()
    '';
  volumeBoost = (
    op: mult:
    let
      m = builtins.toString mult;
    in
    {
      name = "Volume ${op}${m}";
      url = "javascript:${withAudioContextFunc "ctx.gain.gain.value ${op}= ${m}"}";
    }
  );
in
[
  {
    name = "Nix Toolbar Bookmarks";
    toolbar = true;
    bookmarks = [
      {
        name = "🔊 Audio";
        bookmarks = [
          {
            name = "Mono Audio";
            url = "javascript:${withAudioContextFunc "ctx.audio.destination.channelCount = 1"}";
          }
          (volumeBoost "/" 2)
          (volumeBoost "*" 3)
          (volumeBoost "*" 10)
        ];
      }
      {
        name = "Old Reddit";
        url = ''
          javascript:(function()
          {
            ['https://www.reddit.com', 'https://reddit.com'].some(function(p)
            {
              if (window.location.href.startsWith(p))
              { window.location.href = 'https://old.reddit.com' + window.location.href.slice(p.length); return true }
            })
          })()'';
      }
      {
        name = "YT detatch playlist";
        url = ''
          javascript:(function()
          {
            ['https://www.youtube.com', 'https://youtube.com'].some(function(p)
            {
              if (window.location.href.startsWith(p))
              {
                let u = new URL(window.location.href);
                ["list", "index", "start_radio"].forEach(x => u.searchParams.delete(x));
                window.location.href = u.toString();
                return true;
              }
            })
          })()'';
      }
    ];
  }

  # Bookmarks Menu
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
  {
    name = "3D Print";
    bookmarks = [
      {
        name = "Thingiverse";
        url = "https://www.thingiverse.com";
      }
      {
        name = "Printables";
        url = "https://www.printables.com";
      }
    ];
  }
]
