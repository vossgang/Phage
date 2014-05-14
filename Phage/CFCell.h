//
//  CFCell.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CFPlayer;

typedef enum : NSUInteger {
    CFCellSizeSmall,
    CFCellSizeMedium,
    CFCellSizeLarge,
} CFCellSize;

typedef enum : NSUInteger {
    CFCellTypeFactory,
    CFCellTypeScuttle,
    CFCellTypeNeutral,
} CFCellType;


@interface CFCell : NSObject

@property (nonatomic) NSInteger phageCount;
@property (nonatomic, weak) CFPlayer *owner;

-(instancetype)initWithSize:(CGSize)size type:(CFCellType)type location:(CGPoint)location;

-(NSInteger)productionRateForCellSize:(CFCellSize)cellSize;
-(NSInteger)productionCapacityForCellSize:(CFCellSize)cellSize type:(CFCellType)cellType;
-(NSInteger)numberOfOrganellsForCellSize:(CFCellSize)cellSize;

@end
