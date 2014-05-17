//
//  CFGamePlayViewController.m
//  Phage
//
//  Created by Anton Rivera on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFGamePlayViewController.h"
#import "CFMyScene.h"

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
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES; //need to see as we test
    
    // Create and configure the scene.
    SKScene * scene = [CFMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

@end
