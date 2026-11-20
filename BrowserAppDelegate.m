#import "BrowserAppDelegate.h"
#import "BrowserWindowController.h"

@implementation BrowserAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)note
{
  _window = [[BrowserWindowController alloc] init];
  [_window showWindow:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app
{
  return YES;
}

- (void)dealloc
{
  [_window release];
  [super dealloc];
}

@end
