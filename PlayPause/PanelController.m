//
//  PanelController.m
//  MenuReminders
//
//  Created by Rounak on 29/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import "PanelController.h"
#import "iTunes.h"
#import "Background.h"
#import <QuartzCore/QuartzCore.h>
#define BORDER_WIDTH 8

@interface PanelController ()
{
    NSTrackingArea *trackingArea;
    int controlBool;
    int songInfoBool;
}
@property iTunesApplication *iTunesApp;
@end

@implementation PanelController
@synthesize hasActivePanel = _hasActivePanel;
@synthesize iTunesApp = _iTunesApp;
@synthesize songLabel = _songLabel;
@synthesize albumArt = _albumArt;
@synthesize nextImage = _nextImage;
@synthesize previousImage = _previousImage;
@synthesize playImage = _playImage;
@synthesize pauseImage = _pauseImage;
@synthesize nextButton = _nextButton;
@synthesize prevButton = _prevButton;
@synthesize playPauseButton = _playPauseButton;
@synthesize background = _background;

- (id)init
{

    self = [super initWithWindowNibName:@"Panel"];
    [NSBundle loadNibNamed:@"Controls" owner:self];
    [NSBundle loadNibNamed:@"SongInfo" owner:self];
    if (self) {
        // Initialization code here.
        _hasActivePanel = NO;
        _iTunesApp = (iTunesApplication*)[[SBApplication alloc] initWithBundleIdentifier:@"com.apple.iTunes"];
        if (!_iTunesApp.isRunning) {
            [_iTunesApp run];
            songInfoBool = 0;
            controlBool = 0;
        }
    }
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(updateSongInfo)
                                                            name:@"com.apple.iTunes.playerInfo"
                                                          object:@"com.apple.iTunes.player"];
    return self;
}

- (void)windowDidLoad
{
    NSLog(@"In window did load");
    NSView *contentView = self.window.contentView;
    
    _albumArt = [[NSImageView alloc] initWithFrame:CGRectMake(contentView.frame.origin.x + BORDER_WIDTH, contentView.frame.origin.y + BORDER_WIDTH, contentView.frame.size.width - (2*BORDER_WIDTH), contentView.frame.size.height - ARROW_HEIGHT - (2*BORDER_WIDTH))];
    [self.window.contentView addSubview:_albumArt];
    
    NSPanel *panel = (id)self.window;
    [panel setAcceptsMouseMovedEvents:NO];
    [panel setLevel:NSPopUpMenuWindowLevel];
    [panel setOpaque:NO];
    [panel setBackgroundColor:[NSColor clearColor]];
    
    [self updatePanelPosition];
    [super windowDidLoad];
    self.window.delegate = self;
    
    [self updateSongInfo];
    
    trackingArea = [[NSTrackingArea alloc] initWithRect:contentView.bounds options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp) owner:self userInfo:nil];
    [contentView addTrackingArea:trackingArea];
}

- (void)showHover
{
    [self.controlsView setFrameOrigin:NSPointFromCGPoint(CGPointMake(0.0, 0.0))];
    [self.songInfoView setFrameOrigin:NSPointFromCGPoint(CGPointMake(0.0, self.window.frame.size.height - self.songInfoView.frame.size.height - ARROW_HEIGHT))];
    [self.window.contentView addSubview:self.controlsView];
    [self.window.contentView addSubview:self.songInfoView];
}
- (void)hideHover
{
    [self.songInfoView removeFromSuperview];
    [self.controlsView removeFromSuperview];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self showHover];
}
- (void)mouseExited:(NSEvent *)theEvent {
    [self hideHover];
}
-(void)awakeFromNib
{
//    NSLog(@"Awake form nib called");
    [super awakeFromNib];
    
    
    if (self.controlsView && controlBool == 0) {
        controlBool = 1;
        self.nextImage = [NSImage imageNamed:@"next.png"];
        self.previousImage = [NSImage imageNamed:@"prev"];
        self.playImage = [NSImage imageNamed:@"play.png"];
        self.pauseImage = [NSImage imageNamed:@"pause.png"];
        self.controlsView.layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.31);
        
        [self updatePlayPauseIcon];
        [_nextButton setImage:_nextImage];
        [_prevButton setImage:_previousImage];
    }
    if (self.songInfoView && songInfoBool == 0) {
        songInfoBool = 1;
        self.songLabel.textColor = [NSColor whiteColor];
        self.artistLabel.textColor = [NSColor whiteColor];
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.5);
        [self.songInfoView setWantsLayer:YES];
        self.songInfoView.layer = layer;
    }
}

-(void)updatePlayPauseIcon
{
    if([self.iTunesApp playerState] == iTunesEPlSPlaying)
    {
        [_playPauseButton setImage:_pauseImage];
    }
    else
    {
        [_playPauseButton setImage:_playImage];
    }
}

-(void)updatePanelPosition
{
    NSRect locationOfStatusItem = [[[NSApp currentEvent] window] frame];
    NSRect panelRect = [self.window frame];
    panelRect.origin.x = locationOfStatusItem.origin.x - (panelRect.size.width/2) + 10;
    panelRect.origin.y = locationOfStatusItem.origin.y - panelRect.size.height;
    [self.background setArrowXVal:(int)round(locationOfStatusItem.origin.x -panelRect.origin.x + 12)];
    [self.window setFrame:panelRect display:YES];
}

-(IBAction)playToggle:(id)sender
{
    [self.iTunesApp playpause];
    [self updatePlayPauseIcon];
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
    //Bring window to the front each time it is activated
    [self.songLabel setStringValue:[self.iTunesApp currentTrack].name];
    [self.artistLabel setStringValue:[self.iTunesApp currentTrack].artist];
    iTunesArtwork *currentArtwork = [[self.iTunesApp currentTrack].artworks objectAtIndex:0];
    if (currentArtwork) {
        self.albumArt.image = nil;
        [self.albumArt setImage:currentArtwork.data];
    }
    else
    {
        self.albumArt.image = nil;
        [self.albumArt setImage:[NSImage imageNamed:@"Status"]];
    }
    [self updatePlayPauseIcon];
    
}

-(void)setActivePanel:(BOOL)passedValue
{
    if (passedValue!=_hasActivePanel)
    {
        if (passedValue) {
            [self updateSongInfo];
            [self updatePanelPosition];
            
            //new code
            NSApplication *thisApp = [NSApplication sharedApplication];
            [thisApp activateIgnoringOtherApps:YES];
            [self.window makeKeyAndOrderFront:nil];
            NSLog(@"Value is %d", [self.window canBecomeKeyWindow]);
        }
        else
        {
            [self.window orderOut:nil];
        }
        _hasActivePanel = passedValue;
    }
    NSLog(@"Is window main?:%@",[self.window isMainWindow] ? @"YES":@"NO");
    NSLog(@"Is window key?:%@",[self.window isKeyWindow] ? @"YES":@"NO");
}


#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification
{
    self.hasActivePanel = NO;
    NSLog(@"In here window will close");
}

- (void)windowDidResignKey:(NSNotification *)notification;
{
    if ([[self window] isVisible])
    {
        self.hasActivePanel = NO;
    }
    NSLog(@"Window resigned key");
}

- (void)windowDidBecomeKey:(NSNotification *)notification
{
    NSLog(@"Window became key");
}


- (void)windowDidBecomeMain:(NSNotification *)notification
{
    NSLog(@"The impossible happened, window became main");
}



@end
