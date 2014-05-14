//
//  CFMyScene.m
//  Phage
//
//  Created by Matthew Voss on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFMyScene.h"
#import "CFCell.h"

#define NUMBER_OF_CELLS 45
#define NUMBER_OF_SECTIONS 2
#define MAXIMUM_CELL_SIZE 120


@interface CFMyScene()

@property (nonatomic, strong) NSArray *cells;
@property (nonatomic) NSInteger smallCellCap, mediumCellCap, largeCellCap;


@end

@implementation CFMyScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [UIColor darkGrayColor];
        [self layoutBoard];
    }
    return self;
}

-(void)setupArrayOfCells {
    
    NSMutableArray *tempArrayOfCells = [NSMutableArray new];
    
    for (int section = 0; section < NUMBER_OF_SECTIONS; section++) {
        for (int i = 0; i < (NUMBER_OF_CELLS / NUMBER_OF_SECTIONS); i++) {
         
            [tempArrayOfCells addObject:[self setupCellInSection:section+1]];
            [self assignPhysicsToCell:tempArrayOfCells[i]];
            
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
    CFCell *cell =  [[CFCell alloc] initWithImageNamed:[NSString stringWithFormat:@"protocell%d", section]];//alloc, init with custom initializer
    cell.position = [self randomPosition];
    cell.size = [self randomSize];
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
    
    NSInteger size;
    
    GET_NEW_SIZE:
    size = arc4random_uniform(MAXIMUM_CELL_SIZE-50) + 50;
    if (size > (MAXIMUM_CELL_SIZE * .5)) if (arc4random_uniform(3)) goto GET_NEW_SIZE;
    
    return CGSizeMake(size, size);
}


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




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    

}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}


@end
