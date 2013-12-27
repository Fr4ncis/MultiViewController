//
//  MultiViewController.h
//  MultiViewControllers
//
//  Created by Francesco Mattia on 25/12/2013.
//  Copyright (c) 2013 Francesco Mattia. All rights reserved.
//

#import <UIKit/UIKit.h>

static const float kScaleFactor = 0.7f;

static const float kInterspace = 30.0f;

@interface MultiViewController : UIViewController {
    int selectedIndex;
}

@property (nonatomic, strong) NSArray *childControllers;

@end
