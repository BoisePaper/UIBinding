//
//  UIBoundLabelTests.m
//  UIBinding
//
//  Created by Peter Davidson on 12/31/13.
//  Copyright (c) 2013 Peter Davidson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "UIBoundLabel.h"


@interface MyNestedClass : NSObject
@property NSString * foo;
@end



@interface MyTopLevelClass : NSObject
@property MyNestedClass *nested;
@property NSString * bar;
@end

@implementation MyTopLevelClass
@end

@implementation MyNestedClass
@end

@interface UIBoundLabelTests : XCTestCase
@property UIBoundLabel * label;
@end

@implementation UIBoundLabelTests

- (void)setUp
{
    [super setUp];
	
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testNestedBinding
{
	MyNestedClass * nested = [[MyNestedClass alloc]init];
	nested.foo = @"Foo";
	
	MyTopLevelClass * topLevel = [[MyTopLevelClass alloc] init];
	topLevel.nested = nested;
	topLevel.bar = @"Bar";

	self.label = [[UIBoundLabel alloc]init];
	self.label.fieldName = @"nested.foo";
	[self.label bindToModel:topLevel];
	
	XCTAssertEqualObjects(nested.foo, self.label.text);

	
	self.label = [[UIBoundLabel alloc]init];
	self.label.fieldName = @"bar";
	[self.label bindToModel:topLevel];
	
	XCTAssertEqualObjects(topLevel.bar, self.label.text);


	

}

@end
