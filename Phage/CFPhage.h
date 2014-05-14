//
//  CFPhage.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CFCell;
@class CFPlayer;

@interface CFPhage : NSObject

@property (nonatomic, weak) CFCell *targetCell;
@property (nonatomic, weak) CFPlayer *player;

@end
