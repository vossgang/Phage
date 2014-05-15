//
//  CFAI.m
//  Phage
//
//  Created by Anton Rivera on 5/15/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFAI.h"
#import "CFMyScene.h"

#define k_RANDOMIZATION_VALUE 10

@implementation CFAI

-(CGFloat)distanceBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell
{
    CGFloat xDist = (location.position.x - destinationCell.position.x);
    CGFloat yDist = (location.position.y - destinationCell.position.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    
    return distance;
}

-(BOOL)isScuttle:(CFCell *)scuttle inPathBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell
{
    CGFloat crossProduct = ((scuttle.position.y - location.position.y) * (destinationCell.position.x - location.position.x)) - ((scuttle.position.x - location.position.x) * (destinationCell.position.y - location.position.y));
    if (crossProduct != 0) {
        return NO;
    }
    CGFloat dotProduct = ((scuttle.position.x - location.position.x) * (destinationCell.position.x - location.position.x)) + ((scuttle.position.y - location.position.y) * (destinationCell.position.y - location.position.y));
    if (dotProduct < 0) {
        return NO;
    }
    CGFloat squaredLengthDestLoc = ((destinationCell.position.x - location.position.x) * (destinationCell.position.x - location.position.x)) + ((destinationCell.position.y - location.position.y) * (destinationCell.position.y - location.position.y));
    if (dotProduct > squaredLengthDestLoc) {
        return NO;
    }
    
    return YES;
}

- (double)createRandomizationValue:(double)withValue {
    // Generate a random value between -10% and 10%, then modify the incomming value by the random value
    // and return it to the AI method calling this
    return withValue + (withValue * ((1.0f * ((float)arc4random() / (float)RAND_MAX) - 1.0f) * k_RANDOMIZATION_VALUE / 100));
}

- (void)obtainCellInformation {
    CFMyScene *myScene = [CFMyScene new];
    [myScene returnCellInfoToAI];
    
}


@end
