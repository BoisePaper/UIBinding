//
//  UIBoundSwitchTest.m
//  UIBinding
//
//  Created by Joel Sonoda on 1/2/14.
//  Copyright (c) 2014 Peter Davidson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIBoundSwitch.h"

@interface TestModel:NSObject
@property BOOL testProp;
@end

@implementation TestModel
@end

@interface UIBoundSwitchTest : XCTestCase

@end

@implementation UIBoundSwitchTest

- (void)testBindingInitiallyFalse
{
    TestModel* model = [[TestModel alloc] init];
	
	UIBoundSwitch* sw = [[UIBoundSwitch alloc] initWithCoder:nil];
	sw.fieldName = @"testProp";
	model.testProp = NO;
	
	[sw bindToModel:model];
	
	XCTAssertEqual(sw.on, model.testProp, @"The switch value should be the same as the model upon initial binding");
}

- (void)testBindingInitiallyTrue
{
    TestModel* model = [[TestModel alloc] init];
	
	UIBoundSwitch* sw = [[UIBoundSwitch alloc] initWithCoder:nil];
	sw.fieldName = @"self.testProp";
	
	model.testProp = YES;
	
	[sw bindToModel:model];
	XCTAssertEqual(sw.on, model.testProp, @"The switch value should be the same as the model upon initial binding");
}

- (void)testThatChangingModelValueChangesSwitchValue
{
	TestModel* model = [[TestModel alloc] init];
	
	UIBoundSwitch* sw = [[UIBoundSwitch alloc] initWithCoder:nil];
	sw.fieldName = @"testProp";
	
	model.testProp = YES;
	
	[sw bindToModel:model];
	XCTAssertEqual(sw.on, model.testProp, @"The switch value should be the same as the model upon initial binding");
	
	model.testProp = NO;
	XCTAssertEqual(sw.on, model.testProp, @"The switch value should be the same as the model after updating the model");
}

- (void)testThatChangingSwitchValueChangesModelValue
{
	TestModel* model = [[TestModel alloc] init];
	
	UIBoundSwitch* sw = [[UIBoundSwitch alloc] initWithCoder:nil];
	sw.fieldName = @"testProp";
	
	model.testProp = YES;
	
	[sw bindToModel:model];
	XCTAssertEqual(sw.on, model.testProp, @"The switch value should be the same as the model upon initial binding");
	
	[sw setOn:NO];
	NSArray* actions = [sw actionsForTarget:sw forControlEvent:UIControlEventValueChanged];
	
	for(int i=0; i<actions.count; i++) {
		#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
		[sw performSelector:NSSelectorFromString(actions[i]) withObject:sw];
	}
	
	XCTAssertEqual(sw.on, model.testProp, @"The switch value should be the same as the model upon initial binding");
}

@end
