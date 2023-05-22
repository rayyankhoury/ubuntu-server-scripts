#########################################################

## ADDING LOGITECH MICE TO QUBES
## In template VM of sys-usb 
sudo dnf install solaar
## Stops from autolaunching
sudo rm /etc/xdg/autostart/solaar.desktop
## Launch app
solaar
## Edit settings which will persis: I use 50 for scroll ratchet

## IN DOM0, NAVITAGE TO SETTINGS -> STARTUP AND SESSIONS
qvm-run -q -a --service -- sys-usb qubes.StartApp+solaar

#########################################################

## EDITING DISPOSABLE VMS
## In dom0
qvm-run -a xxxxx-xxxxx-dvm gnome-terminal

## open app using terminal and edit, close vm


#########################################################

## Firefox modifications

## The following can entirely be done through:
## https://ffprofile.com

## Optimal Firefox addons for security (core)
## uBlock
## HTTPS Everywhere
## Decentraleyes
## ClearURLs

## Disable WebRTC in Firefox
## Enter about:config in browser
media.peerconnection.enabled = false
media.peerconnection.use_document_iceservers = false
media.peerconnection.turn.disable = true
media.peerconnection.video.enabled = false
media.peerconnection.identity.timeout = 1

## Extra Security firefox settings
privacy.firstparty.isolate = true
privacy.resistFingerprinting = true
privacy.trackingprotection.fingerprinting.enabled = true
privacy.trackingprotection.cryptomining.enabled = true
privacy.trackingprotection.enabled = true
browser.send_pings = false
browser.urlbar.speculativeConnect.enabled = false
dom.event.clipboardevents.enabled = false
media.eme.enabled = false
media.gmp-widevinecdm.enabled = false
media.navigator.enabled = false
network.cookie.cookieBehaviour = 1
network.http.referer.XOriginPolicy = 2
network.http.referer.XOriginTrimmingPolicy = 2
webgl.disabled = true
browser.sessionstore.privacy_level = 2
beacon.enabled = false
browser.safebrowsing.downloads.remote.enabled = false
network.dns.disablePrefetch = true
network.dns.disablePrefetchFromHTTPS = true
network.predictor.enabled = false
network.predictor.enable-prefetch = false
network.prefect-next = false
network.IDN_show_punycode = true

## Extended browser addons for personalized browsers 
## xBrowserSync

############################################################
