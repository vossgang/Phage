//
//  CFGamePlayViewController.m
//  Phage
//
//  Created by Anton Rivera on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFGamePlayViewController.h"

@interface CFGamePlayViewController ()

@end

@implementation CFGamePlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
