//
//  FirstViewController.m
//  MultiViewControllers
//
//  Created by Francesco Mattia on 25/12/2013.
//  Copyright (c) 2013 Francesco Mattia. All rights reserved.
//

#import "ColoredViewController.h"

@interface ColoredViewController () {
    UIColor *color;
}

@end

@implementation ColoredViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (void)load
{
    NSLog(@"Load");
}

- (id)initWithBackgroundColor:(UIColor*)aColor
{
    if (self = [super init]) {
        color = aColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
