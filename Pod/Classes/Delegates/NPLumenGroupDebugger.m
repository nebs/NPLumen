#import "NPLumenGroupDebugger.h"
#import <UIKit/UIKit.h>

@interface NPLumenGroupDebugger ()

@property (nonatomic) NSMutableDictionary *vectorViews;

@end

@implementation NPLumenGroupDebugger

#pragma mark - Private Helpers

- (UIView *)vectorViewForView:(UIView *)view {
    NSValue *key = [NSValue valueWithNonretainedObject:view];
    UIView *vectorView = self.vectorViews[key];
    if (!vectorView) {
        vectorView = [[UIView alloc] initWithFrame:view.bounds];
        vectorView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        [view addSubview:vectorView];
        self.vectorViews[key] = vectorView;
    }
    return vectorView;
}

- (void)updateVectorView:(UIView *)vectorView withLightVector:(CGPoint)lightVector {
    CGFloat viewWidth = CGRectGetWidth(vectorView.frame);
    CGFloat viewHeight = CGRectGetHeight(vectorView.frame);
    CGFloat viewCenterX = CGRectGetMidX(vectorView.bounds);
    CGFloat viewCenterY = CGRectGetMidY(vectorView.bounds);
    CGFloat vectorRadius = MIN(viewWidth, viewHeight) / 2.0;

    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(viewCenterX, viewCenterY)];
    [bezierPath addLineToPoint:CGPointMake(viewCenterX + (vectorRadius  * lightVector.x), viewCenterY + (vectorRadius * lightVector.y))];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 3.0;

    for (CALayer *layer in vectorView.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    [vectorView.layer addSublayer:shapeLayer];
}

#pragma mark - NPLumenGroupDelegate

- (void)lumenGroup:(NPLumenGroup *)lumenGroup didUpdateLightVector:(CGPoint)lightVector forView:(UIView *)view {
    UIView *vectorView = [self vectorViewForView:view];
    [self updateVectorView:vectorView withLightVector:lightVector];
}

@end
