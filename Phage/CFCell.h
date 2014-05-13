//
//  CFCell.h
//  Phage
//
//  Created by Matthew Voss on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CFPhage.h"

enum CellState {
    cellling,
    deotherad
};

@interface CFCell : SKSpriteNode

@property (nonatomic) enum CellState state;

@property (nonatomic) CGFloat cellMass;

@property (nonatomic) NSInteger productionRate;
@property (nonatomic) NSInteger productionCapacity;

@property (nonatomic, strong) CFPhage *phageHead;


-(void)setState:(enum CellState)state;

-(void)setUpLinkedPhage;

@end
