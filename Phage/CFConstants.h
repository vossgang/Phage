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

#define MAXIMUM_CELL_SIZE 120
#define NUMBER_OF_CELLS 30
#define NUMBER_OF_SECTIONS 2
#define NUMBER_OF_PHAGES_PER_CELL 5

#define PHAGE_SIZE CGSizeMake(10, 20)
#define PHAGE_DIAMETER 10

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
} Affiliation;

