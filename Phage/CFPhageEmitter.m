//
//  CFPhage.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPhageEmitter.h"

@implementation CFPhageEmitter

+(instancetype)emitterWithCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation
{
    return [[CFPhageEmitter alloc]initWithTargetCell:targetCell affiliation:affiliation];
}

-(instancetype)initWithTargetCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation
{
    
    SKTextureAtlas *phageAtlas      = [SKTextureAtlas atlasNamed:@"phageX"];
    NSString *textureName           = [NSString stringWithFormat:@"phage%d", (int)affiliation];
    SKTexture *texture              = [phageAtlas textureNamed:textureName];
    
    self = [super initWithTexture:texture];
    
    if (self) {
        _targetCell     = targetCell;
        _affiliation    = affiliation;
        _targetCell     = targetCell;
        _affiliation    = affiliation;
        self.size       = PHAGE_EMITTER_SIZE;
        
    }
    return self;
}


@end
