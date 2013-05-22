//
//  AppDelegate.h
//  PlayPause
//
//  Created by Rounak on 08/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PanelController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>
@property NSStatusItem *statusItem;
@property (readonly) PanelController *panelController;
- (IBAction)togglePanel:(id)sender;

@end
