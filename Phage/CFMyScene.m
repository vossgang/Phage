//
//  CFMyScene.m
//  Phage
//
//  Created by Matthew Voss on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFMyScene.h"
#import "CFCell.h"
#import "CFPhageEmitter.h"
#import "CFGameController.h"

@interface CFMyScene()

@property (nonatomic, strong) CFGameController *gameController;

@end

@implementation CFMyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.physicsBody        = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.backgroundColor    = [UIColor darkGrayColor];
        [self layoutBoard];
    }
    return self;
}



#pragma mark - Cell Management

#pragma mark - Board Composition

-(void)layoutBoard
{
    _gameController = [[CFGameController alloc] initNewGame];
    
    for (CFCell *cell in _gameController.unaffiliatedCells) {
        [cell setPositionToSpawnPoint];
        [self addChild:cell];
    }
//    
//    [self addChild:_gameController.playerCells[0]];
//    CFCell *playerCell = _gameController.playerCells[0];
//    [playerCell setPositionToSpawnPoint];
//    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
//        CFPhageEmitter *phage = playerCell.phageHead;
////        phage.position = [self randomPhagePositionRelativeToCell:playerCell];
//        SKAction *moveToTarget  = [SKAction moveTo:phage.targetCell.position duration:1];
//        [phage runAction:[SKAction repeatActionForever:moveToTarget]];
//
//        [self addChild:phage];
//    }
//    
//    [self addChild:_gameController.enemyCells[0]];
//    CFCell *enemyCell = _gameController.enemyCells[0];
//    [enemyCell setPositionToSpawnPoint];
//    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
//        CFPhageEmitter *phage = enemyCell.phageHead;
////        phage.position = [self randomPhagePositionRelativeToCell:enemyCell];
//        [self addChild:phage];
//        
//    }

}// end method

//-(CGPoint)randomPhagePositionRelativeToCell:(CFCell *)cell {
//    
//    int x,y;
//    
//    if (arc4random_uniform(2)) {
//        x = cell.position.x - arc4random_uniform(cell.size.height / 3);
//    } else {
//        x = cell.position.x + arc4random_uniform(cell.size.height / 3);
//    }
//    
//    if (arc4random_uniform(2)) {
//        y = cell.position.y + arc4random_uniform(cell.size.height / 3);
//    } else {
//        y = cell.position.y - arc4random_uniform(cell.size.height / 3);
//    }
//    
//    return CGPointMake(x, y);
//}


#pragma mark - User Interaction

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    

}

-(void)update:(CFTimeInterval)currentTime
{
    


}


#pragma mark - Pull cell information for AI to read
- (NSArray *)returnCellInfoToAI {
    // Method will query all cells managed by current object, then return their information back to AI controller
    NSMutableArray *arrayOfCellLocations;
    // Iterate through all children to get cells
    for (CFCell *cell in [self children]) {
        [arrayOfCellLocations addObject:cell];
    }
    // Return array of cells back to AI
    return arrayOfCellLocations;
}

@end
