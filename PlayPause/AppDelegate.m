//
//  AppDelegate.m
//  PlayPause
//
//  Created by Rounak on 08/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate
@synthesize menuBarController = _menuBarController;
@synthesize panelController = _panelController;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initiayize your application
    self.menuBarController = [[MenuBarController alloc] init];
    
}

- (PanelController*)panelController
{
    //NSLog(@"Called panelControler accessor");
    if (_panelController == nil) {
        //NSLog(@"Allocing panelcontrolelr");
        _panelController = [[PanelController alloc] init];
    }
    return _panelController;
}

- (IBAction)togglePanel:(id)sender
{
    NSLog(@"Toggle");
    self.menuBarController.visible = !self.menuBarController.visible;
    self.panelController.hasActivePanel = !self.panelController.hasActivePanel;
}

@end
