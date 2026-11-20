#import <AppKit/AppKit.h>

/*
 * BrowserWindowController manages a single browser window: a URL bar,
 * back/forward/reload controls, and a WKWebView content area.
 *
 * WKWebView is provided by WebKit.framework once the nextbsd/WebKit
 * GNUstep port is built and installed to /System/Library/Frameworks.
 * Until then this file acts as the structural placeholder.
 */

@interface BrowserWindowController : NSWindowController
{
  NSTextField  *_urlBar;
  NSButton     *_backButton;
  NSButton     *_forwardButton;
  NSButton     *_reloadButton;
  /* WKWebView *_webView; — added when WebKit.framework is available */
}

- (void)loadURLString:(NSString *)urlString;

@end
