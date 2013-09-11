//
//  AppDelegate.m
//  PlayPause
//
//  Created by Rounak on 08/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import "AppDelegate.h"
#import "customView.h"

@implementation AppDelegate
@synthesize panelController = _panelController;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initiayize your application
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:24.0];
    //self.statusItem.action = @selector(togglePanel:);
    //self.statusItem.image = [NSImage imageNamed:@"Status"];
    
    //new code
    customView *view = [[customView alloc] init];
    view.image = [NSImage imageNamed:@"statusItem"];
    [self.statusItem setView:view];

    //    view.target = self;
    //    view.action = @selector(togglePanel:);
    //    view.rightAction = @selector(displayMenu:);
}

- (PanelController*)panelController
{
    if (_panelController == nil) {
        _panelController = [[PanelController alloc] init];
    }
    return _panelController;
}

- (IBAction)togglePanel:(id)sender
{
//    NSLog(@"Toggle");
    self.panelController.hasActivePanel = !self.panelController.hasActivePanel;
}

-(IBAction)exitApp:(id)sender
{
    [NSApp terminate:self];
}

@end
