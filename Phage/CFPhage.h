//
//  CFPhage.h
//  Phage
//
//  Created by Ryo Tulman on 5/16/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CFPlayer.h"
#import "CFCell.h"

@interface CFPhage : SKSpriteNode

@property (nonatomic, weak) CFPlayer *owner;
@property (nonatomic, weak) CFCell *targetCell;

-(instancetype)initWithCell:(CFCell *)cell;
-(void)updatePhage;

@end
