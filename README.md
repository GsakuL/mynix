# Manual things:
- SponsorBlock
  - Settings JSON
  - API Key
- set "x11 legacy"/"keylogging" in Plasma to "when one of those is modifier key"

## Flatpaks:
- [StreamController](https://flathub.org/apps/com.core447.StreamController)


# TODO
- (ungoogled-)chromium vs firefox: media controls
  - start firefox with video, and pause/stop
  - start chromium with video: no controls for chrome
  - stop pause/chrome video
  - ???
  - start video in firefox
  - chrome hass controls

- citrix only works when starting from browser
  - glib-networking
```sh
crudini \
  --set "$ICAInstDir/config/module.ini" ClientAudio AudioRedirectionV4 FALSE
```