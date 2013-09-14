//
//  customView.h
//  PlayPause
//
//  Created by Swechha Prakash on 26/07/13.
//  Copyright (c) 2013 Rounak. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface customView : NSControl {
    NSImage *image;
    //id target;
    SEL action, rightAction;
}

@property (retain) NSImage *image;
@property (assign) id target;
@property (assign) SEL action, rightAction;
-(void)changeImage:(NSImage*)passedImage;

@end
