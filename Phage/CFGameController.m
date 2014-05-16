//
//  CFGameController.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFGameController.h"
#import "CFCell.h"
#import "CFPhageEmitter.h"

@interface CFGameController ()

@end

@implementation CFGameController

//initialize cell with new array of cells
- (instancetype)initNewGame
{
    self = [super init];
    if (self) {
        [self setupArrayOfUnaffiliatedCells];
        [self setupArrayOfPlayerCells];
        [self setupArrayOfEnemyCells];
//        [self setupPhageEmittersForActiveCells];
        
    }
    return self;
}

/*
//setup singleton
+(instancetype)sharedGameController
{
    static CFGameController *sharedGameController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameController = [[CFGameController alloc] initNewGame];
    });
    
    return sharedGameController;
}

*/

#pragma mark - Cell Management

-(void)setupArrayOfPlayerCells
{
    SKTextureAtlas *phageAtlas      = [SKTextureAtlas atlasNamed:@"cell"];
    NSString *textureName           = [NSString stringWithFormat:@"cell"];
    SKTexture *texture              = [phageAtlas textureNamed:textureName];

    CFCell *cell = [[CFCell alloc] initCellForPlayer];
    cell.colorBlendFactor = .9;
    cell.color = [UIColor blueColor];

    cell.texture = texture;
    _playerCells = @[cell];
}

-(void)setupArrayOfEnemyCells
{
    
    CFCell *cell = [[CFCell alloc] initCellForAI];
    SKTextureAtlas *phageAtlas      = [SKTextureAtlas atlasNamed:@"cell"];
    NSString *textureName           = [NSString stringWithFormat:@"cell"];
    SKTexture *texture              = [phageAtlas textureNamed:textureName];
    cell.colorBlendFactor = .9;
    cell.color = [UIColor yellowColor];

    cell.texture = texture;
    _enemyCells = @[cell];
}

-(void)setupArrayOfUnaffiliatedCells
{
    SKTextureAtlas *phageAtlas      = [SKTextureAtlas atlasNamed:@"cell"];
    NSString *textureName           = [NSString stringWithFormat:@"cell"];
    SKTexture *texture              = [phageAtlas textureNamed:textureName];
    

    
    //temporary array of cells
    NSMutableArray *unaffiliatedCells = [NSMutableArray new];
    
    //divide screen into sections; assign random x,y coordinates of cells
    for (int i = 0; i < NUMBER_OF_CELLS; i++) {
        CFCell *cell = [[CFCell alloc] initCellForNeutral];
        cell.texture = texture;
        cell.colorBlendFactor = .9;
        cell.color = [UIColor purpleColor];

        [unaffiliatedCells addObject:cell];
    }
    
    _unaffiliatedCells = unaffiliatedCells;
    
}

-(void)setupPhageEmittersForActiveCells
{
//    for (CFCell *cell in self.playerCells) {
//        NSString *effectsPhageEmitterPath = [[NSBundle mainBundle] pathForResource:@"Phage" ofType:@"sks"];
//        SKEmitterNode *effectsParticleEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:effectsPhageEmitterPath];
//
//        effectsParticleEmitter.position = (CGPointMake(0, 0));
////        effectsParticleEmitter.particleLifetimeRange = cell.size.width - 1000;
//        
//        [cell.effectsEmitter addChild:effectsParticleEmitter];
//    }
//    
//    for (CFCell *cell in self.enemyCells) {
//        NSString *effectsPhageEmitterPath = [[NSBundle mainBundle] pathForResource:@"Phage" ofType:@"sks"];
//        SKEmitterNode *effectsParticleEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:effectsPhageEmitterPath];
//        
//        effectsParticleEmitter.position = (CGPointMake(0, 0));
//        //effectsParticleEmitter.particleLifetimeRange = cell.size.width - 100;
//        
//        [cell.effectsEmitter addChild:effectsParticleEmitter];
//    }
    

    // Test For Loop
    for (CFCell *cell in self.unaffiliatedCells) {
        NSString *effectsPhageEmitterPath = [[NSBundle mainBundle] pathForResource:@"Phage" ofType:@"sks"];
        SKEmitterNode *effectsParticleEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:effectsPhageEmitterPath];
        
        effectsParticleEmitter.position = (CGPointMake(0, 0));
        // NSLog(@"%f", cell.size.width);
        effectsParticleEmitter.particleLifetimeRange = cell.size.width / 10.0;
        
        [cell.effectsEmitter addChild:effectsParticleEmitter];
    }
}

@end
