//
//  PanelController.m
//  MenuReminders
//
//  Created by Rounak on 29/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import "PanelController.h"
#import "iTunes.h"

@interface PanelController ()
@property iTunesApplication *iTunesApp;
@end

@implementation PanelController
@synthesize hasActivePanel = _hasActivePanel;
@synthesize iTunesApp = _iTunesApp;
@synthesize songLabel = _songLabel;
@synthesize albumArt = _albumArt;
- (id)init
{
    self = [super initWithWindowNibName:@"Panel"];
    if (self) {
        // Initialization code here.
        _hasActivePanel = NO;
        
        _iTunesApp = (iTunesApplication*)[[SBApplication alloc] initWithBundleIdentifier:@"com.apple.iTunes"];
        if (!_iTunesApp.isRunning) {
            [_iTunesApp run];
        }
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
  
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib
{
    NSLog(@"Awakre form nib called");
    
}

-(IBAction)playToggle:(id)sender
{
    [self.iTunesApp playpause];
}
-(IBAction)previousTrack:(id)sender
{
    [self.iTunesApp previousTrack];
}
-(IBAction)nextTrack:(id)sender
{
    [self.iTunesApp nextTrack];
}

-(BOOL)hasActivePanel
{
    return _hasActivePanel;
}
-(void)updateSongInfo
{
    //NSLog(@"This %@",[self.iTunesApp currentTrack].name);
    [self.songLabel setStringValue:[self.iTunesApp currentTrack].name];
    [self.artistLabel setStringValue:[self.iTunesApp currentTrack].artist];
    NSLog(@"%@",[[self.iTunesApp currentTrack].artworks objectAtIndex:0]);
    iTunesArtwork *currentArtwork = [[self.iTunesApp currentTrack].artworks objectAtIndex:0];
    if (currentArtwork) {
        [self.albumArt setImage:currentArtwork.data];
    }
    else
    {
        [self.albumArt setImage:[NSImage imageNamed:@"Status.png"]];
    }
    //[self.albumArt setImage:[NSImage imageNamed:@"Status.png"]];
    
}

-(void)setActivePanel:(BOOL)passedValue
{
    //NSLog(@"In setActivePanel");
    if (passedValue!=_hasActivePanel)
    {
        if (passedValue) {          //active
            if (self.window == nil) {
                //[NSBundle loadNibNamed:@"PanelController" owner:self];
                
                NSLog(@"NILLLLLL");
            }
//            NSLog(@"%@",NSStringFromRect([[[NSApp currentEvent] window] frame]));
            NSRect locationOfStatusItem = [[[NSApp currentEvent] window] frame];
            NSRect panelRect = [self.window frame];
            //panelRect.size.width = 280.0;
            panelRect.origin.x = locationOfStatusItem.origin.x - (panelRect.size.width/2) + 10.0;
            panelRect.origin.y = locationOfStatusItem.origin.y - panelRect.size.height - 10.0;
            [self.window setFrame:panelRect display:YES];
            [self.window makeKeyAndOrderFront:self];
            [self.window setLevel:NSPopUpMenuWindowLevel];
//            [self.window orderFront:<#(id)#>]
            
            //NSLog(@"No of screens: %ld",[NSScreen screens].count);
        }
        else                        //inactive
        {
            [self.window orderOut:nil];
        }
        _hasActivePanel = passedValue;
        [self updateSongInfo];
    }
}

@end
