//
//  CFPlayer.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFPlayer : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) NSArray *playerCells;

-(instancetype)initWithColor:(UIColor *)color
                        name:(NSString *)name
                 playerCells:(NSArray *)playerCells;

@end
