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
        [self.delegate lumenGroup:self didUpdateLightVector:CGPointMake(-0.35, 0.65) forView:view];
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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        [self update];
    }
}

@end
