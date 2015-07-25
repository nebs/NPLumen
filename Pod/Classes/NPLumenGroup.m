#import "NPLumenGroup.h"

@interface NPLumenGroup ()

@property (nonatomic) NSMutableArray *sourceViews;
@property (nonatomic) NSMutableArray *views;

@end

@implementation NPLumenGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sourceViews = [NSMutableArray array];
        self.views = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    for (UIView *view in self.sourceViews) {
        [view removeObserver:self forKeyPath:@"frame"];
    }

    for (UIView *view in self.views) {
        [view removeObserver:self forKeyPath:@"frame"];
    }
}

#pragma mark - Public Interface

- (void)update {
    for (UIView *view in self.views) {
        [self.delegate lumenGroup:self didUpdateLightVector:[self lightVectorForView:view] forView:view];
    }
}

- (void)addSourceView:(UIView *)sourceView {
    if ([self.sourceViews containsObject:sourceView]) {
        return;
    }

    [sourceView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld context:nil];
    [self.sourceViews addObject:sourceView];
    [self update];
}

- (void)addView:(UIView *)view {
    if ([self.views containsObject:view]) {
        return;
    }

    [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld context:nil];
    [self.views addObject:view];
    [self update];    
}

- (void)addSourceViews:(NSArray *)sourceViews {
    for (UIView *sourceView in sourceViews) {
        [self addSourceView:sourceView];
    }
}

- (void)addViews:(NSArray *)views {
    for (UIView *view in views) {
        [self addView:view];
    }
}

#pragma mark - Private Helpers

- (CGPoint)lightVectorForView:(UIView *)view {
    UIView *referenceView = view.superview;

    CGPoint viewCenterRelativeToWindow = [referenceView convertPoint:view.center fromView:view];
    CGPoint lightVector = CGPointZero;
    CGFloat largestDistance = 0;

    for (UIView *sourceView in self.sourceViews) {
        CGPoint sourceViewCenterRelativeToWindow = [referenceView convertPoint:sourceView.center fromView:view];
        CGFloat distanceBetweenSourceAndView = [self distanceBetweenPointA:sourceViewCenterRelativeToWindow andPointB:viewCenterRelativeToWindow];
        if (distanceBetweenSourceAndView > largestDistance) {
            largestDistance = distanceBetweenSourceAndView;
        }
    }

    for (UIView *sourceView in self.sourceViews) {
        CGPoint sourceViewCenterRelativeToWindow = [referenceView convertPoint:sourceView.center fromView:view];
        CGFloat normalizationFactor = largestDistance == 0 ? 1.0 : largestDistance;
        CGFloat normalizedX = (viewCenterRelativeToWindow.x - sourceViewCenterRelativeToWindow.x) / normalizationFactor;
        CGFloat normalizedY = (viewCenterRelativeToWindow.y - sourceViewCenterRelativeToWindow.y) / normalizationFactor;
        lightVector.x += normalizedX;
        lightVector.y += normalizedY;
    }

    return lightVector;
}

- (CGFloat)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB {
    CGFloat dx = (pointB.x - pointA.x);
    CGFloat dy = (pointB.y - pointA.y);
    return sqrt(dx * dx + dy * dy);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        [self update];
    }
}

@end
