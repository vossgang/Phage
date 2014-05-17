//
//  CFPhage.m
//  Phage
//
//  Created by Ryo Tulman on 5/16/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPhage.h"

@implementation CFPhage

#define TOTAL_TRAVEL_POINTS_PER_UPDATE 10

- (instancetype)initWithCell:(CFCell *)cell
{
    if (self = [super init]) {
        self.targetCell = cell;
        self.position = CGPointMake(_targetCell.position.x, _targetCell.position.y);
        self.size = CGSizeMake(3, 3);
        self.color = cell.color;
    }
    return self;
}

-(void)updatePhage
{
    if (_targetCell) {
        CGFloat targetCellX = _targetCell.position.x; // 40
        CGFloat targetCellY = _targetCell.position.y; // 50
        CGFloat xDiff = abs(abs(targetCellX) - abs(self.position.x)); // 20
        CGFloat yDiff = abs(abs(targetCellY) - abs(self.position.y)); // 25
        
        CGFloat totalDistance = xDiff + yDiff;
        
        //handle orbit
        if (totalDistance < 65) {
            if (_targetCell.owner != self.owner) {
                [self attackCell];
            } else {
                //ORBIT
                NSInteger xRandomImpulse = arc4random_uniform(TOTAL_TRAVEL_POINTS_PER_UPDATE);
                NSInteger yRandomImpulse = TOTAL_TRAVEL_POINTS_PER_UPDATE - xRandomImpulse;
                NSInteger xDirectionPositive = arc4random() % 2 ? 1 : -1;
                NSInteger yDirectionPositive = arc4random() % 2 ? 1 : -1;
                xRandomImpulse = xDirectionPositive * xRandomImpulse;
                yRandomImpulse = yDirectionPositive * yRandomImpulse;
                self.position = CGPointMake(self.position.x + xRandomImpulse, self.position.y + yRandomImpulse);
                return;
            }
            
        }
        
        CGFloat distanceRatioForX = xDiff/totalDistance;
        CGFloat distanceRatioForY = yDiff/totalDistance;
        
        CGFloat xAbsoluteAmountToMove = distanceRatioForX * TOTAL_TRAVEL_POINTS_PER_UPDATE;
        CGFloat yAbsoluteAmountToMove = distanceRatioForY * TOTAL_TRAVEL_POINTS_PER_UPDATE;
        
        CGFloat xToMove, yToMove;
        //RESTORE NEGATIVE MOVEMENT IF THE DIFFERENCE IS NEGATIVE
        if (targetCellX - self.position.x < 0) {
            xToMove = -xAbsoluteAmountToMove;
        } else {
            xToMove = xAbsoluteAmountToMove;
        }
        if (targetCellY - self.position.y < 0) {
            yToMove = -yAbsoluteAmountToMove;
        } else {
            yToMove = yAbsoluteAmountToMove;
        }
        
        CGPoint newPosition = CGPointMake(self.position.x + xToMove, self.position.y + yToMove);
        
        self.position = newPosition;
    }
}

-(void)attackCell
{
    /**
     *  ATTACK ANIMATION, RECYCLE PHAGE INTO SCENE'S PHAGE CACHE POOL
     */
}

@end
