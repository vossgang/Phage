//
//  CFAI.m
//  Phage
//
//  Created by Anton Rivera on 5/15/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFAI.h"
#import "CFMyScene.h"
#import "CFCell.h"

#define k_RANDOMIZATION_VALUE 10

int coordMapNeutral[20][20];
int coordMapPlayer[20][20];

@implementation CFAI

-(CGFloat)distanceBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell
{
    CGFloat xDist = (location.position.x - destinationCell.position.x);
    CGFloat yDist = (location.position.y - destinationCell.position.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    
    return distance;
}

- (double)calculateScoreForDecisionSizeFactor:(NSInteger)withSizeFactor andDistance:(double)withDistance andPhageNeeded:(NSInteger)withPhageNeeded andPhageTotal:(NSInteger)withPhageTotal andSizeRatio:(NSInteger)withSizeRatio {
    // Calculate score using randomized parameters to hinder the AI from making perfect decisions
    return withSizeFactor + (2 * [self createRandomizationValue:withDistance]) +
    ([self createRandomizationValue:withPhageNeeded] - [self createRandomizationValue:withPhageTotal])
    / withSizeRatio;
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

- (double)createRandomizationValue:(double)withValue
{
    // Generate a random value between -10% and 10%, then modify the incomming value by the random value
    // and return it to the AI method calling this
    return withValue + (withValue * ((1.0f * ((float)arc4random() / (float)RAND_MAX) - 1.0f) * k_RANDOMIZATION_VALUE / 100));
}

- (double)calculateDistanceToCellUsingStartPoint:(CGPoint)withStartPoint andEndPoint:(CGPoint)withEndPoint {
    // Calculate the hypotenuse of the triangle created by the start and end points
    // Formula is x end - x start, then take absolute value (for positive numbers to get length between the two)
    // then take the positive value and then calculate its value to the power of 2.
    // This gives you the values for the x and y axis. Finally, take the square root of the sum of these values
    // to find the distance between the start and end points.
    double xAxis = pow(fabs(withEndPoint.x - withStartPoint.x),2);
    double yAxis = pow(fabs(withEndPoint.y - withStartPoint.y),2);
    return sqrt(xAxis + yAxis);
}

- (void)locateCellsAndDetermineStatus {
    CFMyScene *myScene = [CFMyScene new];
    NSArray *arrayOfCells = [myScene returnCellInfoToAI];
    for (CFCell *cell in arrayOfCells) {
        switch (cell.cellAffiliation) {
            case AffiliationAI: {
                // Calculate the distance to each object away from AI controlled units
                for (CFCell *targetCell in arrayOfCells) {
                    switch (cell.cellAffiliation) {
                        case AffiliationNeutral: {
                            // Neutral cells
                            double distanceToCell =
                            [self calculateDistanceToCellUsingStartPoint:cell.location andEndPoint:targetCell.location];
                            break;
                        }
                        case AffiliationPlayer: {
                            // Player cells
                            double distanceToCell =
                            [self calculateDistanceToCellUsingStartPoint:cell.location andEndPoint:targetCell.location];
                            break;
                        }
                        default:
                            break;
                    }
                }
                break;
            }
                
            default:
                break;
        }
    }
}

@end
