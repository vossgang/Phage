//
//  CFAI.h
//  Phage
//
//  Created by seanmcneil on 5/15/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPlayer.h"

@interface CFAI : CFPlayer

- (double)createRandomizationValue:(double)withValue;
- (double)calculateScoreForDecisionSizeFactor:(NSInteger)withSizeFactor andDistance:(double)withDistance andPhageNeeded:(NSInteger)withPhageNeeded andPhageTotal:(NSInteger)withPhageTotal andSizeRatio:(NSInteger)withSizeRatio;
- (double)calculateDistanceToCellUsingStartPoint:(CGPoint)withStartPoint andEndPoint:(CGPoint)withEndPoint;

@end
