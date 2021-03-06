#import "NPViewController.h"
#import <NPLumen/NPLumenGroup.h>
#import <NPLumen/NPLumenGroupDebugger.h>
#import <NPLumen/NPLumenGroupShadowCaster.h>

CGFloat const kNPViewControllerSunTimerInterval = 1.0;
NSUInteger const kNPViewControllerLumenGroupViewMaxCount = 6;
NSUInteger const kNPViewControllerLumenGroupSourceViewMaxCount = 1;

@interface NPViewController ()

@property (nonatomic) NPLumenGroupDebugger *lumenGroupDebugger;
@property (nonatomic) NPLumenGroupShadowCaster *lumenGroupShadowCaster;
@property (nonatomic) NPLumenGroup *lumenGroup;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSArray *sourceViews;
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation NPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.7 green:0.8 blue:1.0 alpha:1.0];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    [self resetSimulation];
}

- (void)dealloc {
    [self.timer invalidate];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Private Helpers

- (void)resetSimulation {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }

    NSUInteger viewCount = (arc4random() % kNPViewControllerLumenGroupViewMaxCount) + 1;
    NSUInteger sourceViewCount = (arc4random() % kNPViewControllerLumenGroupSourceViewMaxCount) + 1;

    NSMutableArray *sourceViews = [NSMutableArray arrayWithCapacity:sourceViewCount];
    for (int i=0; i<sourceViewCount; i++) {
        NSInteger minSize = 30.0;
        NSInteger maxSize = 80.0;
        CGFloat w = (arc4random() % (maxSize - minSize)) + minSize;
        CGFloat h = w;
        NSInteger minX = 0;
        NSInteger maxX = (NSInteger)CGRectGetWidth(self.view.frame) - (NSInteger)w;
        NSInteger minY = 0;
        NSInteger maxY = (NSInteger)CGRectGetHeight(self.view.frame) - (NSInteger)h;
        CGFloat x = (arc4random() % (maxX - minX)) + minX;
        CGFloat y = (arc4random() % (maxY - minY)) + minY;

        UIView *sourceView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        sourceView.userInteractionEnabled = NO;
        sourceView.backgroundColor = [UIColor yellowColor];
        sourceView.layer.cornerRadius = w / 2.0;
        [self.view addSubview:sourceView];
        [sourceViews addObject:sourceView];
    }

    NSMutableArray *views = [NSMutableArray arrayWithCapacity:viewCount];
    for (int i=0; i<viewCount; i++) {
        NSInteger minSize = 40.0;
        NSInteger maxSize = 100.0;
        CGFloat w = (arc4random() % (maxSize - minSize)) + minSize;
        CGFloat h = (arc4random() % (maxSize - minSize)) + minSize;
        NSInteger minX = 0;
        NSInteger maxX = (NSInteger)CGRectGetWidth(self.view.frame) - (NSInteger)w;
        NSInteger minY = 0;
        NSInteger maxY = (NSInteger)CGRectGetHeight(self.view.frame) - (NSInteger)h;
        CGFloat x = (arc4random() % (maxX - minX)) + minX;
        CGFloat y = (arc4random() % (maxY - minY)) + minY;

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        view.userInteractionEnabled = NO;
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [views addObject:view];
    }

    self.sourceViews = [sourceViews copy];

    self.lumenGroupDebugger = [[NPLumenGroupDebugger alloc] init];
    self.lumenGroupShadowCaster = [[NPLumenGroupShadowCaster alloc] init];

    self.lumenGroup = [[NPLumenGroup alloc] init];
//    self.lumenGroup.delegate = self.lumenGroupDebugger;
    self.lumenGroup.delegate = self.lumenGroupShadowCaster;
    [self.lumenGroup addSourceViews:[sourceViews copy]];
    [self.lumenGroup addViews:[views copy]];

    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kNPViewControllerSunTimerInterval target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
}

#pragma mark - Timer

- (void)timerTick {
    for (UIView *sourceView in self.sourceViews) {
        CGRect frame = sourceView.frame;
        NSInteger minX = 0;
        NSInteger maxX = (NSInteger)CGRectGetWidth(self.view.frame) - (NSInteger)CGRectGetWidth(sourceView.frame);
        NSInteger minY = 0;
        NSInteger maxY = (NSInteger)CGRectGetHeight(self.view.frame) - (NSInteger)CGRectGetHeight(sourceView.frame);
        frame.origin.x = (arc4random() % (maxX - minX)) + minX;
        frame.origin.y = (arc4random() % (maxY - minY)) + minY;
        [UIView animateWithDuration:kNPViewControllerSunTimerInterval/2.0 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:0 animations:^{
            sourceView.frame = frame;
        } completion:nil];
    }
}

#pragma mark - Gesture Recognizer

- (void)didTapView {
    [self resetSimulation];
}

@end
