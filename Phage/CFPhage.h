//
//  CFPhage.h
//  Phage
//
//  Created by Matthew Voss on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

enum PhageStates{
    living,
    dead
    
};

@interface CFPhage : SKSpriteNode

@property (nonatomic, strong) SKColor *color; //color of team
@property (nonatomic, strong) id cell; //points to parent cell

@property (nonatomic) enum PhageStates state;

@property (nonatomic) CGVector *bias; //where its going trajectory

@property (nonatomic, strong) id pointOfInterest; //cell to where it is going
@property (nonatomic, strong) CFPhage *next;

//animation sequence

-(void)setState:(enum PhageStates)state;


@end








