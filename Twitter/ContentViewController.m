//
//  ContentViewController.m
//  Twitter
//
//  Created by Chinmay Kini on 2/16/15.
//  Copyright (c) 2015 Chinmay Kini. All rights reserved.
//

#import "ContentViewController.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) TweetsViewController *tweetsViewController;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) UINavigationController *navigationController;
@property( nonatomic, assign) BOOL canSwipeLeft;


@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canSwipeLeft = FALSE;
    // Do any additional setup after loading the view from its nib.
    
    self.tweetsViewController = [[TweetsViewController alloc] init];
    self.menuViewController = [[MenuViewController alloc] init];
    
    self.navigationController      = [[UINavigationController alloc] initWithRootViewController:self.tweetsViewController];

    [self addChildViewController:self.navigationController];
    
    self.navigationController.view.frame = self.contentView.frame;
    self.menuViewController.view.frame = self.contentView.frame;

    [self.contentView addSubview:self.menuViewController.view];
    [self.contentView addSubview:self.navigationController.view];

    [self.navigationController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    
   
    
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity    = [sender velocityInView:self.view];
    
    CGRect frame = self.navigationController.view.frame;
    frame.origin.x = translation.x;
        
//     NSLog(@"Velocity x %f", velocity.x);
//     NSLog(@"translation x %f", translation.x)
    
    if(translation.x>0 || (self.canSwipeLeft && translation.x<0)){
        
    
        self.navigationController.view.frame = frame;
        
        if (sender.state == UIGestureRecognizerStateBegan) {
            //        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
        } else if (sender.state == UIGestureRecognizerStateChanged) {
            //        NSLog(@"Gesture changed: %@", NSStringFromCGPoint(point));
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            //        NSLog(@"Gesture ended: %@", NSStringFromCGPoint(point));
            if(velocity.x>0){
                CGRect frame = self.navigationController.view.frame;
                frame.origin.x = 310;
                
                [UIView animateWithDuration:1 animations:^{
                    self.navigationController.view.frame = frame;
                    
                }];
                self.canSwipeLeft = TRUE;
                
//                [self.contentView addSubview:self.menuViewController.view];
//                [self.navigationController willMoveToParentViewController:nil];
//                [self.navigationController didMoveToParentViewController:nil];
//                [self.menuViewController willMoveToParentViewController:self];
//                [self addChildViewController:self.menuViewController];
//                [self.menuViewController didMoveToParentViewController:self];
//                [self addChildViewController:self.menuViewController];
        
                
            } else{
                CGRect frame = self.navigationController.view.frame;
                frame.origin.x = 0;
                [UIView animateWithDuration:1 animations:^{
                    self.navigationController.view.frame = frame;
                }];
                self.canSwipeLeft = FALSE;
                
            }
        }
    }
    
}

@end
