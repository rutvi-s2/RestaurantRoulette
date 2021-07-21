//
//  SpinnerWheel.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import "SpinnerWheel.h"
#import <QuartzCore/QuartzCore.h>

@interface SpinnerWheel()

- (void) drawWheel;

@end

@implementation SpinnerWheel

//basically create getter and setter for variables
@synthesize delegate, container, numberOfWedges;

- (id) initWithFrame:(CGRect)frame andDelegate:(nonnull id)del withWedges:(int)wedgesNumber{
    if((self = [super initWithFrame:frame])){
        self.numberOfWedges = wedgesNumber;
        self.delegate = del;
        [self drawWheel];
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(rotate) userInfo:nil repeats:YES];
    }
    return self;
}

- (void) drawWheel{
    //create a view that holds everything
    container = [[UIView alloc] initWithFrame:self.frame];
    //2*pi radians in circle so divide total radians by # of wedges for angle size
    CGFloat angleSize = 2 * (M_PI/numberOfWedges);
    //create label for each wedge and set anchor point to middle of wheel
    for(int i = 0; i < numberOfWedges; i++){
        //set position to center of the container view (0,0)
        UILabel *specificWedge = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        specificWedge.backgroundColor = [UIColor blueColor];
        specificWedge.text = [NSString stringWithFormat:@"%i", i];
        specificWedge.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        //insert label to container view
        specificWedge.layer.position = CGPointMake(container.bounds.size.width/2.0, container.bounds.size.height/2.0);
        //to rotate the label - multiply amount to rotate by number of section
        specificWedge.transform = CGAffineTransformMakeRotation(angleSize * i);
        specificWedge.tag = i;
        
        [container addSubview:specificWedge];
    }
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    
}

- (void) rotate{
    //TODO: update CGFloat value - 2*pi / numberofWedges
    CGFloat radianToRotate = -0.78;
    CGAffineTransform t = CGAffineTransformRotate(container.transform, radianToRotate);
    container.transform = t;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
