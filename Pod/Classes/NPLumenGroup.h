#import <Foundation/Foundation.h>

@protocol NPLumenGroupDelegate;

@interface NPLumenGroup : NSObject

@property (weak, nonatomic) id<NPLumenGroupDelegate> delegate;

- (void)update;
- (void)addSourceView:(UIView *)sourceView;
- (void)addView:(UIView *)view;
- (void)addSourceViews:(NSArray *)sourceViews;
- (void)addViews:(NSArray *)views;

@end

@protocol NPLumenGroupDelegate <NSObject>

- (void)lumenGroup:(NPLumenGroup *)lumenGroup didUpdateLightVector:(CGPoint)lightVector forView:(UIView *)view;

@end
