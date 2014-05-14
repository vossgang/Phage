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
@class CFPlayer;

@interface CFPhage : SKSpriteNode

@property (nonatomic, weak) CFCell *targetCell;
@property (nonatomic, weak) CFPlayer *player;
@property (nonatomic,strong) CFPhage *next;

@end
