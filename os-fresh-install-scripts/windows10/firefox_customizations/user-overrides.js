// Turns on DRM content
user_pref("media.eme.enabled", true); // 2022

// Allows sessions to restore
user_pref("browser.startup.page", 3); // 0102

// Stops the clearing of history on shutdown
user_pref("privacy.clearOnShutdown.history", false); // 2811
user_pref("privacy.clearOnShutdown.openWindows", false);

// 
user_pref("browser.safebrowsing.downloads.remote.enabled", true);

// Turns on searching from the search bar
user_pref("keyword.enabled", true); // 0801
user_pref("browser.search.suggest.enabled", true); //0804
user_pref("browser.urlbar.suggest.searches", true); //0804