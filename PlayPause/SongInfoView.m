//
//  SongInfoView.m
//  PlayPause
//
//  Created by Swechha Prakash on 15/08/13.
//  Copyright (c) 2013 Rounak. All rights reserved.
//

#import "SongInfoView.h"

#define FILL_OPACITY 0.9f
#define STROKE_OPACITY 1.0f

#define LINE_THICKNESS 1.0f
#define CORNER_RADIUS 8.0f

#define SEARCH_INSET 10.0f

@implementation SongInfoView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    
    NSRect contentRect = NSInsetRect([self bounds], LINE_THICKNESS, LINE_THICKNESS);
    NSBezierPath *path = [NSBezierPath bezierPath];
    //    NSLog(@"arrowX value is %li", _arrowX);
    
    
    [path moveToPoint:NSMakePoint(NSMaxX(contentRect) - CORNER_RADIUS, NSMaxY(contentRect))];
    
    NSPoint topRightCorner = NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect));
    [path curveToPoint:NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect) - CORNER_RADIUS) controlPoint1:topRightCorner controlPoint2:topRightCorner];
    
    [path lineToPoint:NSMakePoint(NSMaxX(contentRect), NSMinY(contentRect) + CORNER_RADIUS)];
    
    NSPoint bottomRightCorner = NSMakePoint(NSMaxX(contentRect), NSMinY(contentRect));
    
    [path curveToPoint:NSMakePoint(NSMaxX(contentRect)-CORNER_RADIUS, NSMinY(contentRect)) controlPoint1:bottomRightCorner controlPoint2:bottomRightCorner];
    
    [path lineToPoint:NSMakePoint(NSMinX(contentRect)+CORNER_RADIUS, NSMinY(contentRect))];
    
    NSPoint bottomLeftCorner = NSMakePoint(NSMinX(contentRect), NSMinY(contentRect));
    [path curveToPoint:NSMakePoint(NSMinX(contentRect), NSMinY(contentRect)+CORNER_RADIUS) controlPoint1:bottomLeftCorner controlPoint2:bottomLeftCorner];
    
    [path lineToPoint:NSMakePoint(NSMinX(contentRect), NSMaxY(contentRect) - CORNER_RADIUS)];
    
    NSPoint topLeftCorner = NSMakePoint(NSMinX(contentRect), NSMaxY(contentRect));
    [path curveToPoint:NSMakePoint(NSMinX(contentRect)+CORNER_RADIUS, NSMaxY(contentRect)) controlPoint1:topLeftCorner controlPoint2:topLeftCorner];
    
    [path lineToPoint:NSMakePoint(NSMaxX(contentRect), NSMaxY(contentRect))];
    [path closePath];
    
    [[NSColor colorWithDeviceWhite:1 alpha:FILL_OPACITY] setFill];
    [path fill];
    
    [NSGraphicsContext saveGraphicsState];
    
    NSBezierPath *clip = [NSBezierPath bezierPathWithRect:[self bounds]];
    [clip appendBezierPath:path];
    [clip addClip];
    
    [path setLineWidth:LINE_THICKNESS * 2];
    [[NSColor whiteColor] setStroke];
    [path stroke];
    
    [NSGraphicsContext restoreGraphicsState];
}

@end

