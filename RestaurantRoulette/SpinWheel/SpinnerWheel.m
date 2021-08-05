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
@synthesize delegate, container, numberOfWedges, startTransform, sectors, currentSector, spinnerItems;

- (id) initWithFrame:(CGRect)frame andDelegate:(nonnull id)del withWedges:(int)wedgesNumber withItems:(nonnull NSMutableArray<YLPBusiness *> *)spinnerItems{
    if((self = [super initWithFrame:frame])){
        self.currentSector = 0;
        self.numberOfWedges = wedgesNumber;
        self.delegate = del;
        self.spinnerItems = spinnerItems;
        [self drawWheel];
        //        [self rotate];
    }
    return self;
}

- (void) drawWheel{
    //create a view that holds everything
    container = [[UIView alloc] initWithFrame:self.frame];
    //2*pi radians in circle so divide total radians by # of wedges for angle size
    CGFloat const angleSize = 2 * (M_PI/numberOfWedges);
    //create label for each wedge and set anchor point to middle of wheel
    for(int i = 0; i < numberOfWedges; i++){
        //set position to center of the container view (0,0)
        UILabel *wedgeOutline = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 60)];
        wedgeOutline.backgroundColor = [UIColor lightGrayColor];
        wedgeOutline.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        wedgeOutline.layer.position = CGPointMake(container.bounds.size.width/2.0, container.bounds.size.height/2.0);
        wedgeOutline.transform = CGAffineTransformMakeRotation(angleSize * i);
        wedgeOutline.tag = i;
        
        UILabel *specificWedge = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 60)];
        specificWedge.text = [spinnerItems objectAtIndex:i].name;
        specificWedge.numberOfLines = 0; //will wrap text in new line
        specificWedge.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        //insert label to container view
        specificWedge.layer.position = CGPointMake(container.bounds.size.width/2.0, container.bounds.size.height/2.0);
        //to rotate the label - multiply amount to rotate by number of section
        specificWedge.transform = CGAffineTransformMakeRotation(angleSize * i);
        specificWedge.tag = i;
        
        [container addSubview:wedgeOutline];
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
}

- (void) rotate{
    CGFloat radianToRotate = (2 * M_PI) / numberOfWedges;
    [UIView animateWithDuration:(2 + arc4random_uniform(3)) animations:^{
        CGAffineTransform t = CGAffineTransformRotate(self->container.transform, radianToRotate);
        self->container.transform = t;
    }completion:^(BOOL success) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self rotateHelper];
        });
    }];
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    //get position of user touch
    CGPoint touchPosition = [touch locationInView:self];
    float const dist = [self calculateDistanceFromCenter:touchPosition];
    if(dist < 40 || dist > 180){
        return NO;
    }
    //calculate distance of touch from center
    float const deltaX = touchPosition.x - container.center.x;
    float const deltaY = touchPosition.y - container.center.y;
    deltaAngle = atan2(deltaY, deltaX);
    startTransform = container.transform;
    return YES;
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchPosition = [touch locationInView:self];
    float const dist = [self calculateDistanceFromCenter:touchPosition];
    if(dist < 40 || dist > 180){
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
    [UIView animateWithDuration:0.1 animations:^{
        CGAffineTransform t = CGAffineTransformRotate(self->container.transform, -newValue);
        self->container.transform = t;
    }completion:^(BOOL success) {
        [self->delegate alertBusiness:[self->spinnerItems objectAtIndex:self->currentSector]];
    }];
}

- (float) calculateDistanceFromCenter:(CGPoint)point{
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float const deltaX = point.x - center.x;
    float const deltaY = point.y - center.y;
    return sqrt ((deltaX * deltaX) + (deltaY * deltaY));
}

- (void) buildSectorsOdd{
    CGFloat const fanWidth = 2 * M_PI / numberOfWedges;
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
    CGFloat const fanWidth = 2 * M_PI / numberOfWedges;
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
