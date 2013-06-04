//
//  Background.h
//  PlayPause
//
//  Created by Swechha Prakash on 04/06/13.
//  Copyright (c) 2013 Rounak. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define ARROW_HEIGHT 8
#define ARROW_WIDTH 12

@interface Background : NSView
{
    NSInteger _arrowX;
}
@property (nonatomic, assign, setter = setArrowX:) NSInteger arrowX;

- (void) setArrowXVal:(NSInteger)arrowX;
@end
