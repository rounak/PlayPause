//
//  AppDelegate.h
//  PlayPause
//
//  Created by Rounak on 08/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MenuBarController.h"
#import "PanelController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>
@property MenuBarController *menuBarController;
@property (readonly) PanelController *panelController;
- (IBAction)togglePanel:(id)sender;

@end
