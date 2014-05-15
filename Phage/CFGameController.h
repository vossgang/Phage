//
//  CFGameController.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@class CFPlayer;

@interface CFGameController : SKScene

+ (instancetype) sharedGameController;
- (instancetype)initNewGame;

@property (nonatomic, strong) CFPlayer *winningPlayer;
@property (nonatomic, strong) NSDictionary *gameState;
@property (nonatomic, strong) NSArray *unaffiliatedCells, *playerCells, *enemyCells;

@end
