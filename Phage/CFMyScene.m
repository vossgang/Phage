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
@property (nonatomic, weak) CFCell *originCell;
@property (nonatomic, weak) CFCell *destinationCell;

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
    
    [self addChild:_gameController.playerCells[0]];
    CFCell *playerCell = _gameController.playerCells[0];
    [playerCell setPositionToSpawnPoint];
    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
        CFPhageEmitter *phage = playerCell.phageHead;
        phage.position = [self randomPhagePositionRelativeToCell:playerCell];
        SKAction *moveToTarget  = [SKAction moveTo:phage.targetCell.position duration:1];
        [phage runAction:[SKAction repeatActionForever:moveToTarget]];

        [self addChild:phage];
    }
    
    [self addChild:_gameController.enemyCells[0]];
    CFCell *enemyCell = _gameController.enemyCells[0];
    [enemyCell setPositionToSpawnPoint];
    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
        CFPhageEmitter *phage = enemyCell.phageHead;
        phage.position = [self randomPhagePositionRelativeToCell:enemyCell];
        [self addChild:phage];
        
    }

}// end method

-(CGPoint)randomPhagePositionRelativeToCell:(CFCell *)cell {
    
    int x,y;
    
    if (arc4random_uniform(2)) {
        x = cell.position.x - arc4random_uniform(cell.size.height / 3);
    } else {
        x = cell.position.x + arc4random_uniform(cell.size.height / 3);
    }
    
    if (arc4random_uniform(2)) {
        y = cell.position.y + arc4random_uniform(cell.size.height / 3);
    } else {
        y = cell.position.y - arc4random_uniform(cell.size.height / 3);
    }
    
    return CGPointMake(x, y);
}


#pragma mark - User Interaction

// Adds a pan gesture recognizer to the scene's view
- (void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

// Handles the pan
- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [self convertPointFromView:touchLocation];
    
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        [self selectCellForTouch:touchLocation];
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self drawArrowAtLocation:touchLocation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (_destinationCell) {
            
            // open circle timer thing that tracks how many phages should be sent
            // add tap recognizer on the cell that lets user select phages to send
        }
        
        else {
            // Remove all animations
        }
    }
}

// Selects player's own cells
- (void)selectCellForTouch:(CGPoint)touchLocation {

    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    // Check that the touched node is a cell
    if ([touchedNode isKindOfClass:[CFCell class]]) {
        
        CFCell *touchedCell = (CFCell *)touchedNode;
        
        // Check that the touched cell is owned by Player
        if (touchedCell.cellAffiliation == AffiliationPlayer) {
            
            _originCell = touchedCell;
            
            // Recommend adding animation of some kind here to indicate selection
        }
    }
}

- (void)drawArrowAtLocation:(CGPoint)newPosition
{
    CGPoint position = [_originCell position];
    
    // draw arrow from position to new position
    
    SKSpriteNode *destinationNode = (SKSpriteNode *)[self nodeAtPoint:newPosition];
    if ([destinationNode isKindOfClass:[CFCell class]]) {
        CFCell *destinationCell = (CFCell *)destinationNode;
        if (![destinationCell isEqual:_originCell]) {
            _destinationCell = destinationCell;
            
            // show animation around destination cell
        }
        else {
            _destinationCell = nil;
            
            // hide all animations around not-origin cells
        }
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    
    

}

-(void)update:(CFTimeInterval)currentTime
{
    
//    
//    for (CFPhage *phage in [self children]) {
//        
//        
//        
//    }

}


@end
