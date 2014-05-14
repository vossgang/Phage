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

@property (nonatomic, strong) NSArray *cells;

@end

@implementation CFGameController

+(instancetype)sharedGameController
{
    static CFGameController *sharedGameController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameController = [[CFGameController alloc] init];
    });
    return sharedGameController;
}

- (NSArray *)setupBoard
{
    [self setupArrayOfCells];

    /*
    NSMutableArray *smallCells = [[NSMutableArray alloc] init];
    NSMutableArray *mediumCells = [[NSMutableArray alloc] init];
    NSMutableArray *largeCells = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < DEFAULT_NUMBER_OF_SMALL_CELLS; i++) {
        CFCell *smallCell = [[CFCell alloc] initWithAffiliation:AffiliationNeutral
                                                       cellSize:SizeSmall
                                                           type:TypeNormal
                                                       location:CGPointZero];
        [smallCells addObject:smallCell];
    }
    
    for (int i = 0; i < DEFAULT_NUMBER_OF_MEDIUM_CELLS; i++) {
        CFCell *mediumCell = [[CFCell alloc] initWithAffiliation:AffiliationNeutral
                                                        cellSize:SizeMedium
                                                            type:TypeNormal
                                                        location:CGPointZero];
        [mediumCells addObject:mediumCell];
    }
    
    for (int i = 0; i < DEFAULT_NUMBER_OF_LARGE_CELLS; i++) {
        CFCell *largeCell = [[CFCell alloc] initWithAffiliation:AffiliationNeutral
                                                       cellSize:SizeLarge
                                                           type:TypeNormal
                                                       location:CGPointZero];
        [largeCells addObject:largeCell];
    }

    return @{kSmallCellKey : smallCells,
             kMediumCellKey : mediumCells,
             kLargeCellKey : largeCells};
     
     */
    return _cells;
}

- (NSArray *)setupPlayers
{
    return nil;
}

#pragma mark - Phage Management

-(CFPhage *)setupPhageLinkedListForTargetCell:(CFCell *)cell {


    CFPhage *firstPhage = [[CFPhage alloc] initWithTargetCell:cell affiliation:AffiliationNeutral];
    [self assignPhysicsToPhage:firstPhage];
    firstPhage.position = [self randomPhagePositionRelativeToCell:cell];
    
    cell.phageHead = firstPhage;
    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
        CFPhage *nextPhage  = [[CFPhage alloc] initWithTargetCell:cell affiliation:AffiliationNeutral];
        [self assignPhysicsToPhage:nextPhage];
        nextPhage.position  = [self randomPhagePositionRelativeToCell:cell];
        nextPhage.next      = cell.phageHead;
        cell.phageHead      = nextPhage;
    }
    firstPhage.next = cell.phageHead;
    return firstPhage;
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

#pragma mark - Cell Management

-(void)setupArrayOfCells {
    
    NSMutableArray *tempArrayOfCells = [NSMutableArray new];
    
    for (int section = 0; section < NUMBER_OF_SECTIONS; section++) {
        for (int i = 0; i < (NUMBER_OF_CELLS / NUMBER_OF_SECTIONS); i++) {
            
            CFCell *cell = [self setupCellInSection:section+1];
            [self assignPhysicsToCell:cell];
            cell.phageHead = [self setupPhageLinkedListForTargetCell:cell];
            [tempArrayOfCells addObject:cell];
            
        }
    }
    
    _cells = tempArrayOfCells;
    
}


-(void)assignPhysicsToCell:(CFCell *)cell {
    
    cell.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:cell.size.width / 2];
    
    cell.physicsBody.allowsRotation     = YES;
    cell.physicsBody.affectedByGravity  = NO;
    cell.physicsBody.dynamic            = YES;
    cell.physicsBody.mass               = 1.4;
    
}

-(CFCell *)setupCellInSection:(NSInteger)section {
    //section is equivalant to enum value
    CFCell *cell =  [[CFCell alloc] initWithAffiliation:section cellSize:[self randomSize] type:TypeNormal location:[self randomPosition]];
                     
    return cell;
}

-(CGPoint)randomPosition {
    
    CGFloat x, y;
    x =  arc4random_uniform(1024);
    y = arc4random_uniform(768);
    
    return CGPointMake(x, y);
}


-(NSInteger)randomSize {
    
//    NSInteger diameter;
//    
//GET_NEW_SIZE: diameter = arc4random_uniform(MAXIMUM_CELL_SIZE-50) + 50;
//    if (diameter > (MAXIMUM_CELL_SIZE * .5)) if (arc4random_uniform(2)) goto GET_NEW_SIZE;
    
    return arc4random_uniform(3);
}

@end
