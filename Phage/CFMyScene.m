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
@property (nonatomic, strong) SKEmitterNode *cellBackground;


@end

@implementation CFMyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.physicsBody        = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.backgroundColor    = [SKColor colorWithRed:0.08 green:0.0 blue:0.0 alpha:1.0];
        
        //Adding Background assets for the game screen - sks and pngs in Supporting Files
        NSString *cellBackgroundPath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"sks"];
        _cellBackground = [NSKeyedUnarchiver unarchiveObjectWithFile:cellBackgroundPath];
        _cellBackground.position = CGPointMake(0, 0);
        [_cellBackground advanceSimulationTime:500];
        [self addChild:_cellBackground];
        
        SKSpriteNode *murky = [SKSpriteNode spriteNodeWithImageNamed:@"murky"];
        murky.position = CGPointMake((self.size.width / 2) ,(self.size.height / 2));
        murky.size = CGSizeMake(2000, 2000);
        murky.alpha = 0.3;
        [self addChild:murky];
        
        SKAction *rotation = [SKAction rotateByAngle:M_PI/4.0 duration:8];
        [murky runAction:[SKAction repeatActionForever:rotation]];
        
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
    
    [self addChild:_gameController.enemyCells[0]];
    CFCell *enemyCell = _gameController.enemyCells[0];
    [enemyCell setPositionToSpawnPoint];

}// end method


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
//    CGPoint position = [_originCell position];
    
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
