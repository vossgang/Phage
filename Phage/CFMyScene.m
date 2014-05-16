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

#define PERCENT_TO_SHRINK_SELECTED_CELL 0.9

@interface CFMyScene()

@property (nonatomic, strong)   CFGameController    *gameController;
@property (nonatomic, weak)     CFCell              *originCell;
@property (nonatomic, weak)     CFCell              *destinationCell;
@property (nonatomic, strong)   SKEmitterNode       *cellBackground;

@end

@implementation CFMyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.physicsBody        = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.backgroundColor    = [SKColor colorWithRed:0.08 green:0.0 blue:0.0 alpha:1.0];
        
        //creating the scene
        
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
        [self animateCellsInScene];

    }
    return self;
}

#pragma mark - Cell Management

-(void)animateCellsInScene {

    [[NSOperationQueue new]addOperationWithBlock:^{
        for (CFCell *cell in [self children]) {
            [cell runAction:[SKAction moveByX:[self randomCellPosition] y:[self randomCellPosition] duration:10]];
        }
        sleep(10);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self animateCellsInScene];
        }];
    }];

}

-(NSInteger)randomCellPosition {
    switch (arc4random_uniform(2)) {
        case TRUE:  return arc4random_uniform(50);
        case FALSE: return -arc4random_uniform(50);
    }
    return 1;
}

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
//    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
//        CFPhageEmitter *phage = playerCell.phageHead;
////        phage.position = [self randomPhagePositionRelativeToCell:playerCell];
//        SKAction *moveToTarget  = [SKAction moveTo:phage.targetCell.position duration:1];
//        [phage runAction:[SKAction repeatActionForever:moveToTarget]];
//
//        [self addChild:phage];
//    }
    
    [self addChild:_gameController.enemyCells[0]];
    CFCell *enemyCell = _gameController.enemyCells[0];
    [enemyCell setPositionToSpawnPoint];
//    for (int i = 0; i < NUMBER_OF_PHAGES_PER_CELL; i++) {
//        CFPhageEmitter *phage = enemyCell.phageHead;
////        phage.position = [self randomPhagePositionRelativeToCell:enemyCell];
//        [self addChild:phage];
//        
//    }
    
}// end method


#pragma mark - User Interaction

// Adds a pan gesture recognizer to the scene's view
- (void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

// Handles the pan
- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [self convertPointFromView:touchLocation];
    
    // At start of pan, select the cell as the origin point
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        [self selectOriginCellForTouch:touchLocation];
        [self createShapeLayer];
    }
    
    // In the middle of pan, draw arrow and find any destination cells in the path
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if (_originCell) {
            
            [self selectDestinationCellForTouch:touchLocation];
            [self drawArrowAtLocation:touchLocation];
        }
        
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
    
    // At the end of the pan, if there's a destination cell, give user some options
    else {
        
//        if (_originCell) {
//            [self growCell:_originCell];
//        }
        
        if (_destinationCell) {
            
            [self growCell:_destinationCell];
//            [self drawArrowAtLocation:_destinationCell.position];
            // open circle timer thing that tracks how many phages should be sent
            // add tap recognizer on the cell that lets user select phages to send
            
            // release line for now
            [_shapeLayer removeFromSuperlayer];
            _originCell = nil;
            _destinationCell = nil;

        }
        else {
            [_shapeLayer removeFromSuperlayer];
            _originCell = nil;
            _destinationCell = nil;
        }
    }
}

// Selects the origin cell
- (void)selectOriginCellForTouch:(CGPoint)touchLocation {

    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    // Check that the touched node is a cell
    if ([touchedNode isKindOfClass:[CFCell class]]) {
        CFCell *touchedCell = (CFCell *)touchedNode;
        
        // Check that the touched cell is owned by Player (Neutral for testing)
        if (touchedCell.cellAffiliation == AffiliationNeutral) {
            
            _originCell = touchedCell;
            
        }
        else {
            _originCell = nil;
        }
    }
    else {
        _originCell = nil;
    }
}

// Selects a destination cell upon encountering a foreign cell
- (void)selectDestinationCellForTouch:(CGPoint)touchLocation
{
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    // Check that the touched node is a cell
    if ([touchedNode isKindOfClass:[CFCell class]]) {
        
        CFCell *touchedCell = (CFCell *)touchedNode;
        
        // Check that the touched cell is not the origin cell or equal to the current destination cell
        if (![touchedCell isEqual:_originCell] && ![touchedCell isEqual:_destinationCell]) {
            
            _destinationCell = touchedCell;
            [self shrinkCell:_destinationCell];
        }
    }
    
    else
    {
        if (_destinationCell) {
            [self growCell:_destinationCell];
            _destinationCell = nil;
        }
    }

}

- (void)createShapeLayer
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    _shapeLayer.lineWidth = 3.0;
    _shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.view.layer addSublayer:_shapeLayer];
}

- (void)drawArrowAtLocation:(CGPoint)newPosition
{
    CGPoint position = _originCell.position;
    position = [self convertPointFromView:position];
    newPosition = [self convertPointFromView:newPosition];
    
    _arrow = [UIBezierPath bezierPath];
    
    [_arrow moveToPoint:position];
    [_arrow addLineToPoint:newPosition];
    _shapeLayer.path = [_arrow CGPath];

}

- (void)shrinkCell:(CFCell *)cell
{
    cell.size = CGSizeMake(cell.size.width * PERCENT_TO_SHRINK_SELECTED_CELL, cell.size.height * PERCENT_TO_SHRINK_SELECTED_CELL);
}

- (void)growCell:(CFCell *)cell
{
    cell.size = CGSizeMake(cell.size.width / PERCENT_TO_SHRINK_SELECTED_CELL, cell.size.height / PERCENT_TO_SHRINK_SELECTED_CELL);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:position];
    
    
    // Check that the touched node is a cell
    if ([touchedNode isKindOfClass:[CFCell class]]) {
        
        _selectedCell = (CFCell *)touchedNode;
        [self shrinkCell:_selectedCell];

    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_selectedCell) {
        [self growCell:_selectedCell];
        _selectedCell = nil;
    }
}

-(void)update:(CFTimeInterval)currentTime
{

}


#pragma mark - Pull cell information for AI to read

- (NSArray *)returnCellInfoToAI
{
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
