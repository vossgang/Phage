//
//  CFCell.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

static NSString * const kSmallCellKey = @"smallCell";
static NSString * const kMediumCellKey = @"mediumCell";
static NSString * const kLargeCellKey = @"largeCell";

@class CFPlayer;
@class CFPhage;

typedef enum : NSUInteger {
    SizeSmall,
    SizeMedium,
    SizeLarge,
} CellSize;

typedef enum : NSUInteger {
    TypeFactory,
    TypeScuttle,
    TypeNormal,
} CellType;

typedef enum :NSUInteger {
    AffiliationPlayer,
    AffiliationAI,
    AffiliationNeutral,
} CellAffiliation;

@interface CFCell : SKSpriteNode

@property (nonatomic) CellType cellType;
@property (nonatomic) CellSize cellSize;
@property (nonatomic) CellAffiliation cellAffiliation;

@property (nonatomic) NSInteger phageCount;
@property (nonatomic, strong) CFPhage *phageHead;
@property (nonatomic, weak) CFPlayer *owner;
@property (nonatomic) CGPoint location;

- (instancetype)initWithAffiliation:(CellAffiliation)affiliation
                           cellSize:(CellSize)cellSize
                               type:(CellType)type
                           location:(CGPoint)location;

- (CGSize)sizeForCellSize:(CellSize)cellSize;

@end
