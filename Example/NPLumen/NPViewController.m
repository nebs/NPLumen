#import "NPViewController.h"
#import <NPLumen/NPLumenGroup.h>
#import <NPLumen/NPLumenGroupDebugger.h>

CGFloat const kNPViewControllerSunTimerInterval = 1.0;
NSUInteger const kNPViewControllerLumenGroupViewCount = 4;
NSUInteger const kNPViewControllerLumenGroupSourceViewCount = 1;

@interface NPViewController ()

@property (nonatomic) NPLumenGroupDebugger *lumenGroupDebugger;
@property (nonatomic) NPLumenGroup *lumenGroup;
@property (nonatomic) UIView *sunView;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation NPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

- (void)lumenGroup:(NPLumenGroup *)lumenGroup didUpdateLightVector:(CGPoint)lightVector forView:(UIView *)view {
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(2.0, 4.0);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 3.0;
}

#pragma mark - Private Helpers

- (void)resetSimulation {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }

    self.view.backgroundColor = [UIColor colorWithRed:0.7 green:0.8 blue:1.0 alpha:1.0];

    self.sunView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    self.sunView.backgroundColor = [UIColor yellowColor];
    self.sunView.layer.cornerRadius = 50;
    [self.view addSubview:self.sunView];

    NSMutableArray *views = [NSMutableArray arrayWithCapacity:kNPViewControllerLumenGroupViewCount];
    for (int i=0; i<kNPViewControllerLumenGroupViewCount; i++) {
        NSInteger minSize = 10.0;
        NSInteger maxSize = 200.0;
        CGFloat w = (arc4random() % (maxSize - minSize)) + minSize;
        CGFloat h = (arc4random() % (maxSize - minSize)) + minSize;
        NSInteger minX = 0;
        NSInteger maxX = (NSInteger)CGRectGetWidth(self.view.frame) - (NSInteger)w;
        NSInteger minY = 0;
        NSInteger maxY = (NSInteger)CGRectGetHeight(self.view.frame) - (NSInteger)h;
        CGFloat x = (arc4random() % (maxX - minX)) + minX;
        CGFloat y = (arc4random() % (maxY - minY)) + minY;

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [views addObject:view];
    }

    self.lumenGroupDebugger = [[NPLumenGroupDebugger alloc] init];
    self.lumenGroup = [[NPLumenGroup alloc] init];
    self.lumenGroup.delegate = self.lumenGroupDebugger;
    [self.lumenGroup addSourceView:self.sunView];
    [self.lumenGroup addViews:[views copy]];

    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kNPViewControllerSunTimerInterval target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
}

#pragma mark - Timer

- (void)timerTick {
    CGRect newSunFrame = self.sunView.frame;
    NSInteger minX = 0;
    NSInteger maxX = (NSInteger)CGRectGetWidth(self.view.frame) - (NSInteger)CGRectGetWidth(self.sunView.frame);
    NSInteger minY = 0;
    NSInteger maxY = (NSInteger)CGRectGetHeight(self.view.frame) - (NSInteger)CGRectGetHeight(self.sunView.frame);
    newSunFrame.origin.x = (arc4random() % (maxX - minX)) + minX;
    newSunFrame.origin.y = (arc4random() % (maxY - minY)) + minY;

    [UIView animateWithDuration:kNPViewControllerSunTimerInterval/2.0 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:0 animations:^{
        self.sunView.frame = newSunFrame;
    } completion:nil];
}

#pragma mark - Gesture Recognizer

- (void)didTapView {
    [self resetSimulation];
}

@end
