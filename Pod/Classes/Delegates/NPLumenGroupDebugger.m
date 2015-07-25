#import "NPLumenGroupDebugger.h"
#import <UIKit/UIKit.h>

@interface NPLumenGroupDebugger ()

@property (nonatomic) NSMutableDictionary *vectorViews;

@end

@implementation NPLumenGroupDebugger

#pragma mark - NPLumenGroupDelegate

- (void)lumenGroup:(NPLumenGroup *)lumenGroup didUpdateLightVector:(CGPoint)lightVector forView:(UIView *)view {

}

@end
