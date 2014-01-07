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
@property NSNumber * number;
@property NSDate * date;
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


- (void) testNumberFormatting
{
	MyTopLevelClass * model = [[MyTopLevelClass alloc]init];
	
	self.label = [[UIBoundLabel alloc] init];
	self.label.fieldName = @"number";
	self.label.format = @"###,##0.00";
	
	model.number = [NSNumber numberWithDouble:110000.01];
	[self.label bindToModel:model];
	XCTAssertEqualObjects(@"110,000.01", self.label.text);
	
	model = [[MyTopLevelClass alloc]init];
	model.number = [NSNumber numberWithFloat:-100.0];
	[self.label bindToModel:model];
	XCTAssertEqualObjects(@"-100.00", self.label.text);
	
	self.label.negativeFormat = @"(###,000.00)";
	[self.label bindToModel:model];
	XCTAssertEqualObjects(@"(100.00)", self.label.text);
	
}


- (void) testDateFormatting
{
	MyTopLevelClass * model = [[MyTopLevelClass alloc]init];
	self.label = [[UIBoundLabel alloc] init];
	self.label.fieldName = @"date";
	self.label.format = @"yyyy-dd-MM";
	
	NSDateFormatter * df = [[NSDateFormatter alloc]init];
	df.dateFormat = @"MM/dd/yyyy";
	
	model.date = [df dateFromString:@"12/31/2013"];
	[self.label bindToModel:model];
	
	XCTAssertEqualObjects(@"2013-31-12", self.label.text);
	
	
}



@end
