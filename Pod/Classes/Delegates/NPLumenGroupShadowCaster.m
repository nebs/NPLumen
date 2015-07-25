#import "NPLumenGroupShadowCaster.h"
#import <UIKit/UIKit.h>

@implementation NPLumenGroupShadowCaster

#pragma mark - NPLumenGroupDelegate

- (void)lumenGroup:(NPLumenGroup *)lumenGroup didUpdateLightVector:(CGPoint)lightVector forView:(UIView *)view {
    CGFloat offsetScale = 5.0;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(offsetScale * lightVector.x, offsetScale * lightVector.y);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 4.0;
}

@end
