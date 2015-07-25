#import "NPViewController.h"
#import <NPLumen/NPLumenGroup.h>
#import <NPLumen/NPLumenGroupDebugger.h>

CGFloat const kNPViewControllerSunTimerInterval = 1.0;

@interface NPViewController ()

@property (nonatomic) NPLumenGroupDebugger *lumenGroupDebugger;
@property (nonatomic) NPLumenGroup *lumenGroup;
@property (nonatomic) UIView *sunView;
@property (nonatomic) UIView *view1;
@property (nonatomic) UIView *view2;
@property (nonatomic) NSTimer *timer;

@end

@implementation NPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.7 green:0.8 blue:1.0 alpha:1.0];

    self.sunView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    self.sunView.backgroundColor = [UIColor yellowColor];
    self.sunView.layer.cornerRadius = 50;
    [self.view addSubview:self.sunView];

    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.view1];

    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(200, 300, 60, 60)];
    self.view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.view2];

    self.lumenGroupDebugger = [[NPLumenGroupDebugger alloc] init];

    self.lumenGroup = [[NPLumenGroup alloc] init];
    self.lumenGroup.delegate = self.lumenGroupDebugger;
    [self.lumenGroup addSourceView:self.sunView];
    [self.lumenGroup addViews:@[self.view1, self.view2]];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:kNPViewControllerSunTimerInterval target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
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

@end
