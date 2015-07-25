#import "NPViewController.h"
#import <NPLumen/NPLumenGroup.h>
#import <NPLumen/NPLumenGroupDebugger.h>

@interface NPViewController ()

@property (nonatomic) NPLumenGroupDebugger *lumenGroupDebugger;
@property (nonatomic) NPLumenGroup *lumenGroup;
@property (nonatomic) UIView *sunView;
@property (nonatomic) UIView *view1;
@property (nonatomic) UIView *view2;

@end

@implementation NPViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.4 green:0.5 blue:1.0 alpha:1.0];

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

@end
