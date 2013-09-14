//
//  AppDelegate.h
//  PlayPause
//
//  Created by Rounak on 08/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PanelController.h"
#import "customView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property NSStatusItem *statusItem;
@property (readonly) PanelController *panelController;
@property customView *rightClickView;
- (IBAction)togglePanel:(id)sender;
- (IBAction)exitApp:(id)sender;

@end
