//
//  Jun21AppDelegate.h
//  Jun21
//
//  Created by Michael Grubb on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class View;

@interface Jun21AppDelegate : UIResponder <UIApplicationDelegate> {
    View *view;
    UIWindow *_window;
}
@property (strong, nonatomic) UIWindow *window;

@end
