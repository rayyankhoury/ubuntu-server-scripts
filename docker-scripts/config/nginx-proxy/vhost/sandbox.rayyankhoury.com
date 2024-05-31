set $main_domain "office.rayyankhoury.com";
set $sandbox_domain "sandbox.rayyankhoury.com";

set $api_domain $main_domain;
set $files_domain $main_domain;

# Opt out of Google's FLoC Network
add_header Permissions-Policy interest-cohort=();

# Enable SharedArrayBuffer in Firefox (for .xlsx export)
add_header Cross-Origin-Resource-Policy cross-origin;
add_header Cross-Origin-Embedder-Policy require-corp;



# CSS can be dynamically set inline, loaded from the same domain, or from $main_domain
set $styleSrc   "'unsafe-inline' 'self' https://${main_domain}";

# connect-src restricts URLs which can be loaded using script interfaces
# if you have configured your instance to use a dedicated $files_domain or $api_domain
# you will need to add them below as: https://${files_domain} and https://${api_domain}
set $connectSrc "'self' https://${main_domain} blob: wss://${api_domain} https://${sandbox_domain}";

# fonts can be loaded from data-URLs or the main domain
set $fontSrc    "'self' data: https://${main_domain}";

# images can be loaded from anywhere, though we'd like to deprecate this as it allows the use of images for tracking
set $imgSrc     "'self' data: blob: https://${main_domain}";

# frame-src specifies valid sources for nested browsing contexts.
# this prevents loading any iframes from anywhere other than the sandbox domain
set $frameSrc   "'self' https://${sandbox_domain} blob:";

# specifies valid sources for loading media using video or audio
set $mediaSrc   "blob:";

# defines valid sources for webworkers and nested browser contexts
# deprecated in favour of worker-src and frame-src
set $childSrc   "https://${main_domain}";

# specifies valid sources for Worker, SharedWorker, or ServiceWorker scripts.
# supercedes child-src but is unfortunately not yet universally supported.
set $workerSrc  "'self'";

# script-src specifies valid sources for javascript, including inline handlers
set $scriptSrc  "'self' resource: https://${main_domain}";

# frame-ancestors specifies which origins can embed your CryptPad instance
# this must include 'self' and your main domain (over HTTPS) in order for CryptPad to work
# if you have enabled remote embedding via the admin panel then this must be more permissive.
# note: cryptpad.fr permits web pages served via https: and vector: (element desktop app)
set $frameAncestors "'self' https://${main_domain}";
# set $frameAncestors "'self' https: vector:";

set $unsafe 0;
# the following assets are loaded via the sandbox domain
# they unfortunately still require exceptions to the sandboxing to work correctly.
if ($uri ~ ^\/(sheet|doc|presentation)\/inner.html.*$) { set $unsafe 1; }
if ($uri ~ ^\/common\/onlyoffice\/.*\/.*\.html.*$) { set $unsafe 1; }

# everything except the sandbox domain is a privileged scope, as they might be used to handle keys
if ($host != $sandbox_domain) { set $unsafe 0; }
# this iframe is an exception. Office file formats are converted outside of the sandboxed scope
# because of bugs in Chromium-based browsers that incorrectly ignore headers that are supposed to enable
# the use of some modern APIs that we require when javascript is run in a cross-origin context.
# We've applied other sandboxing techniques to mitigate the risk of running WebAssembly in this privileged scope
if ($uri ~ ^\/unsafeiframe\/inner\.html.*$) { set $unsafe 1; }

# privileged contexts allow a few more rights than unprivileged contexts, though limits are still applied
if ($unsafe) {
    set $scriptSrc "'self' 'unsafe-eval' 'unsafe-inline' resource: https://${main_domain}";
}

# Finally, set all the rules you composed above.
add_header Content-Security-Policy "default-src 'none'; child-src $childSrc; worker-src $workerSrc; media-src $mediaSrc; style-src $styleSrc; script-src $scriptSrc; connect-src $connectSrc; font-src $fontSrc; img-src $imgSrc; frame-src $frameSrc; frame-ancestors $frameAncestors";
