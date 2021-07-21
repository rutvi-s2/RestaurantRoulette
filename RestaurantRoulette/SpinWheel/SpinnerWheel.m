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
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) buildSectorsEven;
- (void) buildSectorsOdd;

@end

static float deltaAngle;

@implementation SpinnerWheel

//basically create getter and setter for variables
@synthesize delegate, container, numberOfWedges, startTransform, sectors, currentSector;

- (id) initWithFrame:(CGRect)frame andDelegate:(nonnull id)del withWedges:(int)wedgesNumber{
    if((self = [super initWithFrame:frame])){
        self.currentSector = 0;
        self.numberOfWedges = wedgesNumber;
        self.delegate = del;
        [self drawWheel];
//        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(rotate) userInfo:nil repeats:YES];
        [self rotate];
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
        specificWedge.backgroundColor = [UIColor lightGrayColor];
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
    sectors = [NSMutableArray arrayWithCapacity:numberOfWedges];
    if(numberOfWedges % 2 == 1){
        [self buildSectorsOdd];
    }else{
        [self buildSectorsEven];
    }
    [self.delegate wheelValueChanged:[NSString stringWithFormat:@"value is %i", currentSector]];
}

- (void) rotate{
    CGFloat radianToRotate = (2 * M_PI) / numberOfWedges;
    [UIView animateWithDuration:(1 + arc4random_uniform(5)) animations:^{
        CGAffineTransform t = CGAffineTransformRotate(container.transform, radianToRotate);
        container.transform = t;
    }];
    [self rotateHelper];
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    //get position of user touch
    CGPoint touchPosition = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPosition];
    if(dist < 40 || dist > 100){
        //ignore tap
        return NO;
    }
    //calculate distance of touch from center
    float deltaX = touchPosition.x - container.center.x;
    float deltaY = touchPosition.y - container.center.y;
    //calculate arctangent - did this in robot lab in fri when needed to calculate how much to turn robot based on the camera's view
    deltaAngle = atan2(deltaY, deltaX);
    //save transformation
    startTransform = container.transform;
    return YES;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPosition = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPosition];
    if(dist < 40 || dist > 100){
        //ignore tap
        return NO;
    }
    [self rotate];
    return YES;
}

- (void) rotateHelper{
    CGFloat rad = atan2f(container.transform.b, container.transform.a);
    CGFloat newValue = 0.0;
    if (numberOfWedges % 2 == 1){
        for (SpinnerSector *sect in sectors){
            if(rad > sect.minVal && rad < sect.maxVal){
                newValue = rad - sect.midVal;
                currentSector = sect.sector;
                break;
            }
        }
    }else{
        for (SpinnerSector *sect in sectors){
            if(sect.minVal > 0 && sect.maxVal < 0){
                if(sect.maxVal > rad || sect.minVal < rad){
                    if(rad > 0){
                        newValue = rad - M_PI;
                    }else{
                        newValue = M_PI + rad;
                    }
                    currentSector = sect.sector;
                }
            }else if(rad > sect.minVal && rad < sect.maxVal){
                newValue = rad - sect.midVal;
                currentSector = sect.sector;
            }
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform t = CGAffineTransformRotate(container.transform, -newValue);
        container.transform = t;
    }];
    [self.delegate wheelValueChanged:[NSString stringWithFormat:@"value is %i", currentSector]];
}
- (float) calculateDistanceFromCenter:(CGPoint)point{
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float deltaX = point.x - center.x;
    float deltaY = point.y - center.y;
    return sqrt ((deltaX * deltaX) + (deltaY * deltaY));
}

- (void) buildSectorsOdd{
    CGFloat fanWidth = 2 * M_PI / numberOfWedges;
    CGFloat mid = 0;
    for (int i = 0; i < numberOfWedges; i++){
        SpinnerSector *sector = [[SpinnerSector alloc] init];
        sector.midVal = mid;
        sector.minVal = mid - (fanWidth/2);
        sector.maxVal = mid + (fanWidth/2);
        sector.sector = i;
        mid -= fanWidth;
        if(sector.minVal < - M_PI){
            mid = -mid;
            mid -= fanWidth;
        }
        NSLog(@"cl is %@", sector);
        //add sector to array
        [sectors addObject:sector];
    }
}

- (void) buildSectorsEven{
    CGFloat fanWidth = 2 * M_PI / numberOfWedges;
    CGFloat mid = 0;
    for (int i = 0; i < numberOfWedges; i++){
        SpinnerSector *sector = [[SpinnerSector alloc] init];
        sector.midVal = mid;
        sector.minVal = mid - (fanWidth/2);
        sector.maxVal = mid + (fanWidth/2);
        sector.sector = i;
        if(sector.maxVal - fanWidth < -M_PI){
            mid = M_PI;
            sector.midVal = mid;
            sector.minVal = fabsf(sector.maxVal);
        }
        mid -= fanWidth;
        NSLog(@"cl is %@", sector);
        //add sector to array
        [sectors addObject:sector];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
