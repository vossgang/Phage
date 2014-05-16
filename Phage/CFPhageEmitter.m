//
//  CFPhage.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPhageEmitter.h"
#import "CFCell.h"

@implementation CFPhageEmitter

+(instancetype)emitterWithCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation
{
    return [[CFPhageEmitter alloc]initWithTargetCell:targetCell affiliation:affiliation];
}

-(instancetype)initWithTargetCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation
{
    self = [super init];
    
    if (self) {
        _targetCell     = targetCell;
        _affiliation    = affiliation;
        _targetCell     = targetCell;
        _affiliation    = affiliation;
        self.size       = PHAGE_EMITTER_SIZE;
        
    }
    if (affiliation == AffiliationNeutral){
        self.hidden = YES;
    }
    return self;
}


@end
