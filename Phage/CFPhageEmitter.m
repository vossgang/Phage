//
//  CFPhage.m
//  Phage
//
//  Created by Cole Bratcher on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPhageEmitter.h"

@implementation CFPhageEmitter

-(instancetype)initWithTargetCell:(CFCell *)targetCell affiliation:(Affiliation)affiliation
{
    self = [super initWithImageNamed:@"protoPhage"];
    if (self) {
        _targetCell = targetCell;
        _affiliation = affiliation;
        _targetCell = targetCell;
        _affiliation = affiliation;
        self.size = PHAGE_CLOUD_SIZE;
        
    }
    return self;
}

//-(CFPhage *)next
//{
//    CFPhage *first = _next;
//    _next = first.next;
//    return first;
//}

@end
