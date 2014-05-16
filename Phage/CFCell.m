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

@implementation CFCell

-(id)initCellForNeutral
{
    return [self initWithAffiliation:AffiliationNeutral
                            cellSize:[self randomSizeClass]
                                type:TypeNormal
                          spawnPoint:[self randomPosition]
                      effectsEmitter:[CFPhageEmitter emitterWithCell:self affiliation:AffiliationNeutral]
                      sendingEmitter:[CFPhageEmitter emitterWithCell:self affiliation:AffiliationNeutral]];
}

-(id)initCellForAI
{
    return [self initWithAffiliation:AffiliationAI
                            cellSize:SizeLarge
                                type:TypeFactory
                          spawnPoint:STARTING_AI_SPAWN_POINT
                      effectsEmitter:[CFPhageEmitter emitterWithCell:self affiliation:AffiliationAI]
                      sendingEmitter:[CFPhageEmitter emitterWithCell:self affiliation:AffiliationAI]];
}

-(id)initCellForPlayer
{
    return [self initWithAffiliation:AffiliationPlayer
                            cellSize:SizeLarge
                                type:TypeFactory
                          spawnPoint:STARTING_PLAYER_SPAWN_POINT
                      effectsEmitter:[CFPhageEmitter emitterWithCell:self affiliation:AffiliationPlayer]
                      sendingEmitter:[CFPhageEmitter emitterWithCell:self affiliation:AffiliationPlayer]];
}

- (instancetype)initWithAffiliation:(Affiliation)affiliation
                           cellSize:(CellSize)cellSize
                               type:(CellType)type
                         spawnPoint:(CGPoint)spawnPoint
                     effectsEmitter:(CFPhageEmitter *)effectsEmitter
                     sendingEmitter:(CFPhageEmitter *)sendingEmitter

{
    self = [super init];
    if (self) {
        _cellAffiliation    = affiliation;
        _cellSize           = cellSize;
        _cellType           = type;
        _spawnPoint         = spawnPoint;
        _effectsEmitter     = effectsEmitter;
        _sendingEmitteer    = sendingEmitter;

        self.size           = [self sizeForCellSize:cellSize];
        
        [self addChild:effectsEmitter];
        [self addChild:sendingEmitter];
        
        [effectsEmitter setZPosition:-1];
        
        [self assignPhysics];
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

-(CFPhageEmitter *)phageHead
{
    CFPhageEmitter *current = _phageHead;
    _phageHead = current.next;
    return _phageHead;
}


#pragma mark - Setup Helper Methods

-(void)setPositionToSpawnPoint
{
    self.position = _spawnPoint;
}

-(NSInteger)randomSizeClass
{
    return arc4random_uniform(3);
}


-(CGPoint)randomPosition
{
    CGFloat x, y;
    x =  arc4random_uniform(1024);
    y = arc4random_uniform(768);
    
    return CGPointMake(x, y);
}


- (void)phageDensity:(int)density forPhageEmmiter:(CFPhageEmitter *)phageEmmiter
{
    
}

-(void)assignPhysics
{
    self.physicsBody                    = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.allowsRotation     = YES;
    self.physicsBody.affectedByGravity  = NO;
    self.physicsBody.dynamic            = YES;
    self.physicsBody.mass               = 2;
}

//-(void)setCellAffiliation:(Affiliation)cellAffiliation
//{
//    if (_cellAffiliation != cellAffiliation) {
//        _cellAffiliation = cellAffiliation;
//        
//        switch (_cellAffiliation) {
//                
//            case AffiliationNeutral:    [self setTexture:[SKTexture textureWithImageNamed:@"protocell0"]]; break;
//                
//            case AffiliationAI:         [self setTexture:[SKTexture textureWithImageNamed:@"protocell2"]]; break;
//                
//            case AffiliationPlayer:     [self setTexture:[SKTexture textureWithImageNamed:@"protocell1"]]; break;
//                
//        }
//    }
//}

   
@end
