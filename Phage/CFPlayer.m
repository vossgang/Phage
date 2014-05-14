//
//  CFPlayer.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPlayer.h"

@implementation CFPlayer

-(instancetype)initWithColor:(UIColor *)color name:(NSString *)name playerCells:(NSArray *)playerCells
{
    self = [super init];
    if (self) {
        _color          = color;
        _name           = name;
        _playerCells    = playerCells;
    }
    return self;
}

@end
