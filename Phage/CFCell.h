//
//  CFCell.h
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "CFPhageEmitter.h"

static NSString * const kSmallCellKey   = @"smallCell";
static NSString * const kMediumCellKey  = @"mediumCell";
static NSString * const kLargeCellKey   = @"largeCell";

@class CFPlayer;
//@class CFPhage;

@interface CFCell : SKSpriteNode

@property (nonatomic) CellType cellType;
@property (nonatomic) CellSize cellSize;
@property (nonatomic) Affiliation cellAffiliation;

@property (nonatomic) NSInteger phageCount;
@property (nonatomic, strong) CFPhageEmitter *phageHead;
@property (nonatomic, weak) CFPlayer *owner;
@property (nonatomic) CGPoint location;
@property (nonatomic, readwrite) NSInteger inertiaX, inertiaY;

@property (nonatomic, strong) CFPhageEmitter *effectsEmitter;
@property (nonatomic, strong) CFPhageEmitter *sendingEmitteer;



-(id)initCellForNeutral;
-(id)initCellForAI;
-(id)initCellForPlayer;

- (instancetype)initWithAffiliation:(Affiliation)affiliation
                           cellSize:(CellSize)cellSize
                               type:(CellType)type
                         spawnPoint:(CGPoint)spawnPoint
                     effectsEmitter:(CFPhageEmitter *)effectsEmitter
                     sendingEmitter:(CFPhageEmitter *)sendingEmitter;


- (CGSize)sizeForCellSize:(CellSize)cellSize;
- (void)setPositionToSpawnPoint;

- (void)phageDensity:(int)density forPhageEmmiter:(CFPhageEmitter *)phageEmmiter;

@end
