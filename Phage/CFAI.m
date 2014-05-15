//
//  CFAI.m
//  Phage
//
//  Created by Anton Rivera on 5/15/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFAI.h"

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

@end
