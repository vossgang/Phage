//
//  PhageTests.m
//  PhageTests
//
//  Created by Matthew Voss on 5/13/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CFAI.h"
#import "CFCell.h"


@interface PhageTests : XCTestCase

@end

@implementation PhageTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRandomValueGeneration {
    CFAI *ai = [CFAI new];
    for (int i = 0; i < 200; i++) {
        double result = [ai createRandomizationValue:1];
        XCTAssert(result > .9 && result < 1.1, @"The result value of %f is out of range",result);
    }
}

- (void)testCallingAIScoringMethod {
    CFAI *ai = [CFAI new];
    //sizeFactor: L = 0, M = 50, S = 100 (play around with this number)
    //sizeRatio: L = 1, M = 2, S = 3 (approximately correct)
    for (int i = 0; i < 200; i++) {
        double score = [ai calculateScoreForDecisionSizeFactor:50 andDistance:2000 andPhageNeeded:50 andPhageTotal:50 andSizeRatio:2];
        XCTAssert(score > 45 || score < 65, @"Score of %f is outside of range",score);
        NSLog(@"Score: %f",score);
    }
}

- (void)testCalculateDistanceToCell {
    CFAI *ai = [CFAI new];
    CGPoint start = CGPointMake(3, 3);
    CGPoint end = CGPointMake(6, 7);
    double result = [ai calculateDistanceToCellUsingStartPoint:start andEndPoint:end];
    XCTAssertEqual(result, 5, @"The distance of %f is not correct",result);
}

- (void)testIdentifyCellBasedOnMemoryAddress {
    CFCell *cell = [CFCell new];
    int isValid = [[[NSString stringWithFormat:@"%p",cell] substringToIndex:2] isEqualToString:@"0x"];
    XCTAssertEqual(isValid, 1, @"Not a valid memory address");
}

@end
