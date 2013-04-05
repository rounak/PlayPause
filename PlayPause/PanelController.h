//
//  PanelController.h
//  MenuReminders
//
//  Created by Rounak on 29/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PanelController : NSWindowController


@property (getter = hasActivePanel, setter = setActivePanel:) BOOL hasActivePanel;
@property IBOutlet NSTextField *songLabel;
@property IBOutlet NSTextField *artistLabel;
@property IBOutlet NSImageView *albumArt;
@property IBOutlet NSView *controlsView;
@property IBOutlet NSView *songInfoView;
@property IBOutlet NSImage *next;
@property IBOutlet NSImage *previous;
@property IBOutlet NSImage *play;
@property IBOutlet NSImage *pause;
@property IBOutlet NSButton *nextButton;
@property IBOutlet NSButton *prevButton;
@property IBOutlet NSButton *playPauseButton;

-(IBAction)nextTrack:(id)sender;
-(IBAction)previousTrack:(id)sender;
-(IBAction)playToggle:(id)sender;

@end

