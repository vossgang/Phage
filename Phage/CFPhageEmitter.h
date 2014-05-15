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

@interface CFPhageEmitter : SKSpriteNode

@property (nonatomic, weak) CFCell *targetCell;
@property (nonatomic) Affiliation affiliation;
@property (nonatomic, weak) CFPhageEmitter *next;

+(instancetype)emitterWithCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation;
-(instancetype)initWithTargetCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation;

@end
