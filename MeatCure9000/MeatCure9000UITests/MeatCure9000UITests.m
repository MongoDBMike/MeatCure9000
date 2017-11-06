//
//  MeatCure9000UITests.m
//  MeatCure9000UITests
//
//  Created by Mike Rioux on 2017-09-11.
//  Copyright © 2017 Mike Rioux. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MeatCure9000UITests : XCTestCase

@end

@implementation MeatCure9000UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
