//
//  CFPhage.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@class CFCell;

@interface CFPhage : SKSpriteNode

@property (nonatomic, weak) CFCell *targetCell;
@property (nonatomic) Affiliation affiliation;
@property (nonatomic,strong) CFPhage *next;


-(instancetype)initWithTargetCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation;

@end
