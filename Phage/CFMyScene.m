//
//  CFMyScene.m
//  Phage
//
//  Created by Matthew Voss on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFMyScene.h"
#import "CFCell.h"
#import "CFPhage.h"
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
        NSLog(@"%f", cell.position.x);
        [self addChild:cell];
    }
    
    [self addChild:_gameController.playerCells[0]];
    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
        CFCell *cell    = _gameController.playerCells[0];
        [cell setPositionToSpawnPoint];
        CFPhage *phage  = cell.phageHead;
        [self addChild:phage];
    }
    
    [self addChild:_gameController.enemyCells[0]];
    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
        CFCell *cell    = _gameController.enemyCells[0];
        [cell setPositionToSpawnPoint];
        CFPhage *phage  = cell.phageHead;
        [self addChild:phage];
    }

}// end method


#pragma mark - User Interaction

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    

}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}


@end
