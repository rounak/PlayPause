//
//  MenuBarController.m
//  MenuReminders
//
//  Created by Rounak on 29/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import "MenuBarController.h"

@implementation MenuBarController
@synthesize statusItem = _statusItem;
@synthesize visible = _visible;

-(id)init
{
    self = [super init];
    if (self) {
        self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:24.0];
        self.statusItem.action = @selector(togglePanel:);
        self.statusItem.image = [NSImage imageNamed:@"Status"];
        _visible = NO;
    }
    return self;
}

-(void)setBool:(BOOL)passedValue
{
    if (passedValue!=_visible)
    {
        if (passedValue) {
            self.statusItem.image = [NSImage imageNamed:@"StatusHighlighted"];
        }
        else
        {
            self.statusItem.image = [NSImage imageNamed:@"Status"];
        }
        _visible = passedValue;
    }
}
-(BOOL)isVisible
{
    return _visible;
}
@end
