//
//  CFCell.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFCell.h"
#import "CFConstants.h"

@interface CFCell()

@property (nonatomic,readwrite) CGPoint spawnPoint;

@end

@implementation CFCell {
}

- (instancetype)initWithAffiliation:(Affiliation)affiliation
                           cellSize:(CellSize)cellSize
                               type:(CellType)type
                           spawnPoint:(CGPoint)spawnPoint
{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"protocell%lu", type]];
    if (self) {
        _cellAffiliation    = affiliation;
        _cellSize           = cellSize;
        _cellType           = type;
        _spawnPoint         = spawnPoint;
        self.size           = [self sizeForCellSize:cellSize];
    }
    return self;
}

- (CGSize)sizeForCellSize:(CellSize)cellSize
{
    NSInteger size = arc4random_uniform(11);
    
    switch (cellSize) {
        case SizeSmall:
            return CGSizeMake(size +30, size +30);
            break;
        case SizeMedium:
            return CGSizeMake(size +60, size +60);
            break;
        default:
            return CGSizeMake(size +90, size +90);
            break;
    }
}

-(CFPhage *)phageHead  {
    CFPhage *current = _phageHead;
    _phageHead = current.next;
    
    return _phageHead;
}


#pragma mark - Setup Helper Methods

-(void)setPositionToSpawnPoint {
    self.position = _spawnPoint;
}
   
@end
