//
//  View.m
//  Jun21
//
//  Created by Michael Grubb on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "View.h"
#include <stdlib.h>

@implementation View

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void) drawRect: (CGRect) rect {
	// Drawing code
	//Fill the Red Cross.
	CGSize size = self.bounds.size;
	CGFloat min = MIN(size.width, size.height);
    int squaresPerRow=8; // How big is the grid of possible locations?
    CGFloat squareSep=15.0; // How many pixels in between the locations?
	CGFloat squareDim = (min-(squareSep*(squaresPerRow+1)))/squaresPerRow; // Make the shpaes fit evenly in the row
    int pickSetSize =arc4random_uniform(4); 
    int setSize;
    int temp;
    Boolean uniqueFlag=false;
    if (pickSetSize==0) {
        setSize=5;
    } else if (pickSetSize==1) {
        setSize=9;
    } else if (pickSetSize==2) {
        setSize=17;
    } else if (pickSetSize==3) {
        setSize=33;
    }
    NSLog(@"%d",setSize);
    
    NSInteger locations[setSize];
    
    for (NSInteger i = 0; i < setSize; i++) {
        while (uniqueFlag==false) {
            temp = arc4random_uniform(squaresPerRow*squaresPerRow);
            uniqueFlag=true;
            for (NSInteger j = 0; j < setSize; j++) {
                if (locations[j]==temp) {
                    uniqueFlag=false;
                    break;
                }
            } 
        }
        locations[i]=temp;
        uniqueFlag=false;
    }
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextBeginPath(c);
    CGContextRef d = UIGraphicsGetCurrentContext();
	CGContextBeginPath(d);
    int yPos=0;
    int xPos=0;
    int counter=0;
    int target =0;
    NSLog(@"%d",target);
    for (yPos=0; yPos<squaresPerRow; ++yPos) {
        for (xPos=0; xPos<squaresPerRow; ++xPos) {
            for (NSInteger i = 0; i < setSize; i++){
                if (locations[i]==counter) {
                    CGRect square = CGRectMake((xPos*squareDim)+(xPos*squareSep)+squareSep, (yPos*squareDim)+(yPos*squareSep)+squareSep, squareDim, squareDim);
                    if (i==target) {
                        CGContextAddEllipseInRect(d, square);
                        CGContextSetRGBFillColor(d, 0.0, 1.0, 0.0, 1.0);
                        CGContextFillPath(d);
                    }
                    else if (i !=target && i <= ((setSize-1)/2)) {
                        CGContextAddEllipseInRect(c, square);
                        CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
                        CGContextFillPath(c);
                    }  else if (i !=target && i>((setSize-1)/2)) {
                        CGContextAddRect(d,square);
                        CGContextSetRGBFillColor(d, 0.0, 1.0, 0.0, 1.0);
                        CGContextFillPath(d);
                    }
                }
            }
            ++counter;
        }
    }
    [self performSelector:@selector(setNeedsDisplay) withObject:nil  afterDelay:2];
}
@end
