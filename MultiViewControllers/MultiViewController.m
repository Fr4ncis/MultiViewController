//
//  MultiViewController.m
//  MultiViewControllers
//
//  Created by Francesco Mattia on 25/12/2013.
//  Copyright (c) 2013 Francesco Mattia. All rights reserved.
//

#import "MultiViewController.h"
#import "UIView+Additions.h"

@interface MultiViewController () {
    UIScrollView *scrollView;
    CGRect        originalFrame;
}

@end

@implementation MultiViewController

- (void)setUp
{
    scrollView = [[UIScrollView alloc] init];

}

- (id)init
{
    if (self = [super init])
    {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.frame = self.view.frame;
    [self.view addSubview:scrollView];

    int numVC = [self.childControllers count];
    float contentWidth = (self.view.frameWidth*(1-kScaleFactor))+(self.view.frameWidth*kScaleFactor+kInterspace)*numVC-kInterspace;
    scrollView.contentSize = CGSizeMake(contentWidth, self.view.frameHeight);
    for (int i = 0; i < numVC; i++)
    {
        UIViewController *vc = self.childControllers[i];
        vc.view.transform = CGAffineTransformMakeScale(kScaleFactor, kScaleFactor);
        vc.view.center = CGPointMake(self.view.frameWidth/2.0+(i*(vc.view.bounds.size.width*kScaleFactor+kInterspace)), self.view.frameHeight/2.0);
        [self addTapGestureRecognizerToViewController:vc];
        [scrollView addSubview:vc.view];
    }
}

- (void)didLongTapOnViewController:(UILongPressGestureRecognizer *)sender
{
    UIViewController *selectedVC = self.childControllers[selectedIndex];
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self removeGestureRecognizerOfClass:[UILongPressGestureRecognizer class] fromViewController:selectedVC];
        scrollView.scrollEnabled = YES;
        if (self.presentedViewController == selectedVC)
        {
            [self dismissViewControllerAnimated:NO completion:^{
                selectedVC.view.frame = scrollView.bounds;
                [scrollView addSubview:selectedVC.view];
            }];
        }
        [UIView animateWithDuration:0.3f animations:^{
            selectedVC.view.frame = originalFrame;
        } completion:^(BOOL finished) {
            [self addTapGestureRecognizerToViewController:selectedVC];
        }];
    }
}

- (void)removeGestureRecognizerOfClass:(Class)class fromViewController:(UIViewController *)viewController
{
    [viewController.view.gestureRecognizers enumerateObjectsUsingBlock:^(UIGestureRecognizer *gestureRecognizer, NSUInteger idx, BOOL *stop) {
        if ([gestureRecognizer class] == class)
        {
            [viewController.view removeGestureRecognizer:gestureRecognizer];
        }
    }];
}

- (void)addTapGestureRecognizerToViewController:(UIViewController*)viewController
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnViewController:)];
    [viewController.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)findSelectedViewControllerWithView:(UIView*)view
{
    selectedIndex = NSNotFound;
    [self.childControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        if (vc.view == view)
        {
            selectedIndex = idx;
        }
    }];
}

- (void)didTapOnViewController:(UITapGestureRecognizer *)sender
{
    [self findSelectedViewControllerWithView:sender.view];
    UIViewController *selectedVC = self.childControllers[selectedIndex];
    originalFrame = selectedVC.view.frame;
    //scrollView.scrollEnabled = NO;
    [scrollView bringSubviewToFront:selectedVC.view];
    [self removeGestureRecognizerOfClass:[UITapGestureRecognizer class] fromViewController:selectedVC];
    [UIView animateWithDuration:0.3f animations:^{
        selectedVC.view.frame = scrollView.bounds;
    } completion:^(BOOL finished) {
        [self presentViewController:selectedVC animated:NO completion:nil];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongTapOnViewController:)];
        [selectedVC.view addGestureRecognizer:longPressGestureRecognizer];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
