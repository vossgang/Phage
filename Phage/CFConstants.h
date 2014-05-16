//
//  CFConstants.h
//  Phage
//
//  Created by Cole Bratcher on 5/14/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#define DEFAULT_NUMBER_OF_SMALL_CELLS 10
#define DEFAULT_NUMBER_OF_MEDIUM_CELLS 5
#define DEFAULT_NUMBER_OF_LARGE_CELLS 3
#define CELL_DRIFT_DISTANCE 10

#define MAXIMUM_CELL_SIZE 120
#define MAXIMUM_NUMBER_OF_PHAGES 120

#define NUMBER_OF_CELLS 40
#define NUMBER_OF_SECTIONS 2
#define NUMBER_OF_PHAGES_PER_CELL 100

#define PHAGE_EMITTER_SIZE CGSizeMake(10, 20)
#define PHAGE_DIAMETER 10

#define STARTING_PLAYER_SPAWN_POINT CGPointMake(200, 200)
#define STARTING_AI_SPAWN_POINT     CGPointMake(824, 568)

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
    AffiliationNeutral,
    AffiliationPlayer,
    AffiliationAI,
} Affiliation;

typedef enum : NSUInteger {
    EmitterTypeEffects,
    EmitterTypeAction,
} EmitterType;

