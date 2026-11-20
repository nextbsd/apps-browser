#import "BrowserWindowController.h"

@implementation BrowserWindowController

- (id)init
{
  NSRect frame = NSMakeRect(0, 0, 1024, 768);
  NSUInteger style = NSTitledWindowMask | NSClosableWindowMask
      | NSMiniaturizableWindowMask | NSResizableWindowMask;
  NSWindow *win = [[NSWindow alloc] initWithContentRect:frame
                                              styleMask:style
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
  [win setTitle:@"Browser"];
  [win center];

  self = [super initWithWindow:win];
  [win release];
  if (self == nil)
    return nil;

  [self _buildChrome];
  return self;
}

- (void)_buildChrome
{
  NSView *content = [[self window] contentView];
  NSRect bounds = [content bounds];

  /* Toolbar row */
  CGFloat toolH = 36;
  NSRect toolRect = NSMakeRect(0, NSMaxY(bounds) - toolH, NSWidth(bounds), toolH);
  NSView *toolbar = [[NSView alloc] initWithFrame:toolRect];
  [toolbar setAutoresizingMask:NSViewWidthSizable | NSViewMinYMargin];

  _backButton = [self _buttonWithTitle:@"‹" frame:NSMakeRect(4, 4, 28, 28)];
  _forwardButton = [self _buttonWithTitle:@"›" frame:NSMakeRect(36, 4, 28, 28)];
  _reloadButton = [self _buttonWithTitle:@"↺" frame:NSMakeRect(68, 4, 28, 28)];

  _urlBar = [[NSTextField alloc] initWithFrame:NSMakeRect(100, 6, NSWidth(bounds) - 108, 24)];
  [_urlBar setAutoresizingMask:NSViewWidthSizable];
  [_urlBar setPlaceholderString:@"Search or enter URL"];
  [_urlBar setTarget:self];
  [_urlBar setAction:@selector(_urlBarActivated:)];

  [toolbar addSubview:_backButton];
  [toolbar addSubview:_forwardButton];
  [toolbar addSubview:_reloadButton];
  [toolbar addSubview:_urlBar];
  [content addSubview:toolbar];
  [toolbar release];

  /* Placeholder content area — replaced by WKWebView once available */
  NSRect webRect = NSMakeRect(0, 0, NSWidth(bounds), NSHeight(bounds) - toolH);
  NSView *placeholder = [[NSView alloc] initWithFrame:webRect];
  [placeholder setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
  [content addSubview:placeholder];
  [placeholder release];
}

- (NSButton *)_buttonWithTitle:(NSString *)title frame:(NSRect)frame
{
  NSButton *b = [[NSButton alloc] initWithFrame:frame];
  [b setTitle:title];
  [b setButtonType:NSMomentaryLightButton];
  [b setBordered:NO];
  return [b autorelease];
}

- (void)_urlBarActivated:(id)sender
{
  [self loadURLString:[_urlBar stringValue]];
}

- (void)loadURLString:(NSString *)urlString
{
  /* Will call [_webView loadRequest:] once WKWebView is wired in. */
  [[self window] setTitle:urlString];
}

- (void)dealloc
{
  [_urlBar release];
  [_backButton release];
  [_forwardButton release];
  [_reloadButton release];
  [super dealloc];
}

@end
