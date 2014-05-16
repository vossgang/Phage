//
//  CFAI.h
//  Phage
//
//  Created by Anton Rivera on 5/15/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFPlayer.h"
#import "CFCell.h"

@interface CFAI : CFPlayer

-(CGFloat)distanceBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell;
-(BOOL)isScuttle:(CFCell *)scuttle inPathBetweenCellLocation:(CFCell *)location andDestinationCell:(CFCell *)destinationCell;
- (double)createRandomizationValue:(double)withValue;




@end
