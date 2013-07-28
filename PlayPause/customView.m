//
//  customView.m
//  PlayPause
//
//  Created by Swechha Prakash on 26/07/13.
//  Copyright (c) 2013 Rounak. All rights reserved.
//

#import "customView.h"
#import "AppDelegate.h"

@implementation customView

@synthesize image;
@synthesize target;
@synthesize action;
@synthesize rightAction;

- (void)mouseUp:(NSEvent *)event
{
    
    
    AppDelegate *delegate = [NSApp delegate];
    [delegate togglePanel:self];
    
//    [NSApp sendAction:self.action to:self.target from:self];

}
- (void)rightMouseUp:(NSEvent *)event
{
    
    NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
    [theMenu insertItemWithTitle:@"Exit" action:@selector(exitApp:) keyEquivalent:@"" atIndex:0];
    
    [NSMenu popUpContextMenu:theMenu withEvent:event forView:self];
}
- (void)dealloc
{
    self.image = nil;
}
- (void)drawRect:(NSRect)rect
{
    [self.image drawInRect:self.bounds fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
}
@end
