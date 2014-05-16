//
//  CFEnemyAI.h
//  Phage
//
//  Created by Matthew Voss on 5/16/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPlayer.h"
#import "CFCell.h"

@interface CFEnemyAI : CFPlayer

-(CGFloat)distanceBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell;
-(BOOL)isScuttle:(CFCell *)scuttle inPathBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell;
- (double)createRandomizationValue:(double)withValue;
- (double)calculateScoreForDecisionSizeFactor:(NSInteger)withSizeFactor andDistance:(double)withDistance andPhageNeeded:(NSInteger)withPhageNeeded andPhageTotal:(NSInteger)withPhageTotal andSizeRatio:(NSInteger)withSizeRatio;
- (double)calculateDistanceToCellUsingStartPoint:(CGPoint)withStartPoint andEndPoint:(CGPoint)withEndPoint;

@end
