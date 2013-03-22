//
//  MenuBarController.h
//  MenuReminders
//
//  Created by Rounak on 29/11/12.
//  Copyright (c) 2012 Rounak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuBarController : NSObject

@property NSStatusItem *statusItem;
@property (getter = isVisible, setter = setBool:) BOOL visible;
@end
