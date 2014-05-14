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

#define NUMBER_OF_CELLS 30
#define NUMBER_OF_SECTIONS 2
#define MAXIMUM_CELL_SIZE 120
#define NUMBER_OF_PHAGES_PER_CELL 5
#define PHAGE_DIAMETER 10

@interface CFMyScene()

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic) NSInteger smallCellCap, mediumCellCap, largeCellCap;
@property (nonatomic, strong) CFPhage *phage;


@end

@implementation CFMyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.backgroundColor = [UIColor darkGrayColor];
        [self layoutBoard];
    }
    return self;
}

#pragma mark - Phage Management

-(void)distributePhages {
    [self setupPhageList];
    for (CFCell *cell in self.children) {
        
    #warning - finish implementation
    }
    
}

-(void)setupPhageList {
    
    CFPhage *firstPhage = [[CFPhage alloc] initWithImageNamed:@"protoPhage"];
    _phage = firstPhage;
    
    for (int i = 0; i < NUMBER_OF_CELLS * NUMBER_OF_PHAGES_PER_CELL; i++) {
        
        //allocate and initialize phage node with image
        CFPhage *nextPhage = [[CFPhage alloc] initWithImageNamed:@"protoPhage"];

        //add phage to view & hide it
        [self addChild:nextPhage];
        nextPhage.hidden = YES;
        
        //assign physics characeristics to phage
        [self assignPhysicsToPhage:nextPhage];
        
        //advance the linked list focalpoint
        nextPhage.next = _phage;
        _phage = nextPhage;
    }
    
    firstPhage.next = _phage;
}

//phage property 'getter' overide
-(CFPhage *)phage {
    _phage = _phage.next;
    return _phage;
}

-(void)assignPhysicsToPhage:(CFPhage *)phage {
    phage.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:phage.size.width / 2];
    
    phage.physicsBody.allowsRotation     = YES;
    phage.physicsBody.affectedByGravity  = NO;
    phage.physicsBody.dynamic            = YES;
    phage.physicsBody.mass               = .2;
}

-(void)addPhageToCell:(CFCell *)cell {
    CFPhage *phage  = self.phage;
    
    phage.size      = CGSizeMake(PHAGE_DIAMETER, PHAGE_DIAMETER);
    phage.position  = [self randomPositionRelativeToCell:cell];

}


-(CGPoint)randomPositionRelativeToCell:(CFCell *)cell {
    
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
         
            [tempArrayOfCells addObject:[self setupCellInSection:section+1]];
            [self assignPhysicsToCell:tempArrayOfCells[i]];
            
            for (int j = 0; j < NUMBER_OF_PHAGES_PER_CELL; j++) {
                [self addPhageToCell:tempArrayOfCells[i]];
            }
            
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
    CFCell *cell    =  [[CFCell alloc] initWithImageNamed:[NSString stringWithFormat:@"protocell%d", section]];//alloc, init with custom initializer
    cell.position   = [self randomPosition];
    cell.size       = [self randomSize];
    return cell;
}

-(void)setCellCaps {
    _smallCellCap   = (NUMBER_OF_CELLS / 3) + 1;
    _mediumCellCap  = (NUMBER_OF_CELLS / 3) + 1;
    _largeCellCap   = (NUMBER_OF_CELLS / 3) + 1;
    
}

-(CGPoint)randomPosition {
    
    CGFloat x, y;
    x =  arc4random_uniform(self.frame.size.width);
    y = arc4random_uniform(self.frame.size.height);
    
    return CGPointMake(x, y);
}


-(CGSize)randomSize {
    
    NSInteger diameter;
    
    GET_NEW_SIZE: diameter = arc4random_uniform(MAXIMUM_CELL_SIZE-50) + 50;
    if (diameter > (MAXIMUM_CELL_SIZE * .5)) if (arc4random_uniform(2)) goto GET_NEW_SIZE;
    
    return CGSizeMake(diameter, diameter);
}

#pragma mark - Board Composition

-(void)layoutBoard
{
    
    for (int i = 0; i < NUMBER_OF_CELLS; i++) {
        CFCell *cell    = [[CFCell alloc] initWithImageNamed:@"protocell0"];
        cell.size       = [self randomSize];
        cell.position   = [self randomPosition];
        [self assignPhysicsToCell:cell];
        
        [self addChild:cell];
        
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
