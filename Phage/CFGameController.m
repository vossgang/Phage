//
//  CFGameController.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFGameController.h"
#import "CFCell.h"
#import "CFPhage.h"

@interface CFGameController ()

@end

@implementation CFGameController

//initialize cell with new array of cells
- (instancetype)initNewGame
{
    self = [super init];
    if (self) {
        [self setupArrayOfUnaffiliatedCells];
        [self setupArrayOfPlayerCells];
        [self setupArrayOfEnemyCells];
        
    }
    return self;
}

//setup singleton
+(instancetype)sharedGameController
{
    static CFGameController *sharedGameController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameController = [[CFGameController alloc] initNewGame];
    });
    
    return sharedGameController;
}

#pragma mark - Cell Management

-(void)setupArrayOfPlayerCells {
    
#warning - needs CGPoint
    CGPoint startingPosition = CGPointMake(500, 500);
    
    CFCell *cell = [[CFCell alloc] initWithAffiliation:AffiliationPlayer cellSize:MAXIMUM_CELL_SIZE type:TypeFactory spawnPoint:startingPosition];
    [self assignPhysicsToCell:cell];
    cell.texture = [SKTexture textureWithImageNamed:@"protocell1"];
    [self setupPhageLinkedListForTargetCell:cell];
    _playerCells = @[cell];
}

-(void)setupArrayOfEnemyCells {
    
#warning - needs CGPoint
    CGPoint startingPosition = CGPointMake(1, 1);

    CFCell *cell = [[CFCell alloc] initWithAffiliation:AffiliationAI cellSize:MAXIMUM_CELL_SIZE type:TypeFactory spawnPoint:startingPosition];
    cell.texture = [SKTexture textureWithImageNamed:@"protocell2"];
    [self assignPhysicsToCell:cell];
    [self setupPhageLinkedListForTargetCell:cell];
    _enemyCells = @[cell];
}

-(void)setupArrayOfUnaffiliatedCells {
    
    //temporary array of cells
    NSMutableArray *unaffiliatedCells = [NSMutableArray new];
    
    //divide screen into sections; assign random x,y coordinates of cells
    for (int i = 0; i < NUMBER_OF_CELLS; i++) {
        CFCell *cell = [[CFCell alloc] initWithAffiliation:AffiliationNeutral cellSize:[self randomSizeClass] type:TypeNormal spawnPoint:[self randomPosition]];
        
        [self assignPhysicsToCell:cell];
        
        cell.texture = [SKTexture textureWithImageNamed:@"protocell0"];

        [unaffiliatedCells addObject:cell];
    }
    
    _unaffiliatedCells = unaffiliatedCells;
    
}


-(void)assignPhysicsToCell:(CFCell *)cell {
    
    cell.physicsBody                    = [SKPhysicsBody bodyWithCircleOfRadius:cell.size.width / 2];
    cell.physicsBody.allowsRotation     = YES;
    cell.physicsBody.affectedByGravity  = NO;
    cell.physicsBody.dynamic            = YES;
    cell.physicsBody.mass               = 1.4;
    
}


#pragma mark - Phage Management

-(void)setupPhageLinkedListForTargetCell:(CFCell *)cell {
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
        CFPhage *phage  = [[CFPhage alloc] initWithTargetCell:cell affiliation:AffiliationNeutral];
        [self assignPhysicsToPhage:phage];
        phage.position = [self randomPhagePositionRelativeToCell:cell];
        [array insertObject:phage atIndex:0];
        if (array.count > 1) {
            phage.next = array[1];
        }
    }
    
    CFPhage *last = [array lastObject];
    last.next = [array firstObject];
    cell.phageHead = [array firstObject];
    
//    
//    cell.phageHead = [[CFPhage alloc] initWithTargetCell:cell affiliation:AffiliationNeutral];
//    [self assignPhysicsToPhage:cell.phageHead];
//    cell.phageHead.position = [self randomPhagePositionRelativeToCell:cell];
//    
//    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
//        CFPhage *nextPhage  = [[CFPhage alloc] initWithTargetCell:cell affiliation:AffiliationNeutral];
//        [self assignPhysicsToPhage:nextPhage];
//        nextPhage.position  = [self randomPhagePositionRelativeToCell:cell];
//        nextPhage.next      = cell.phageHead;
//        cell.phageHead      = nextPhage;
//    }

}

-(CFPhage *)phageForCell:(CFCell *)cell {
    cell.phageHead = cell.phageHead.next;
    return cell.phageHead;
}

-(void)assignPhysicsToPhage:(CFPhage *)phage {
    phage.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:phage.size.width / 2];
    
    phage.physicsBody.allowsRotation     = YES;
    phage.physicsBody.affectedByGravity  = NO;
    phage.physicsBody.dynamic            = YES;
    phage.physicsBody.mass               = .2;
}

-(CGPoint)randomPhagePositionRelativeToCell:(CFCell *)cell {
    
    int x,y;
    
    if (arc4random_uniform(2))  x = cell.position.x + arc4random_uniform(5);
    else x = cell.position.x - arc4random_uniform(5);
    
    if (arc4random_uniform(2))  x = cell.position.y + arc4random_uniform(5);
    else x = cell.position.y - arc4random_uniform(5);
    
    return CGPointMake(x, y);
}


#pragma mark - Helper Methods

-(CGPoint)randomPosition {
    
    CGFloat x, y;
    x =  arc4random_uniform(1024);
    y = arc4random_uniform(768);
    
    return CGPointMake(x, y);
}


-(NSInteger)randomSizeClass {
    return arc4random_uniform(3);
}

@end
