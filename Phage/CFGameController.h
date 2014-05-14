//
//  CFGameController.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CFPlayer;

@interface CFGameController : NSObject

+ (instancetype) sharedGameController;
- (NSArray *)setupGameCells;
- (NSArray *)setupPlayers;

@property (nonatomic, strong) CFPlayer *winningPlayer;

@end
