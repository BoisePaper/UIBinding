//
//  UIBoundSegmentedControlTests.m
//  UIBinding
//
//  Created by Joel Sonoda on 1/3/14.
//  Copyright (c) 2014 Peter Davidson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIBoundSegmentedControl.h"
#import "UIBinding.h"

@interface UIBoundSegmentedControlTestsModel : NSObject
@property NSString* testProp;
@end

@implementation UIBoundSegmentedControlTestsModel
@end

@interface UIBoundSegmentedControlTests : XCTestCase
@property NSArray* codes;
@end

@implementation UIBoundSegmentedControlTests

/**
 * Verify that the self.codes and the titles of the segments in the UIBoundSegmentedControl
 */
- (void) setUp
{
	[super setUp];
	self.codes = @[@"ONE",@"TWO",@"THREE",@"FOUR"];
}

- (void)testSettingInitialValueTwo
{
	NSInteger index = 1;
    UIBoundSegmentedControlTestsModel* model = [[UIBoundSegmentedControlTestsModel alloc] init];
	model.testProp = self.codes[index];
	UIView* container = [self getContainerInstance];
	UIBoundSegmentedControl* instance = [self findSegmentedControlIn:container];
	instance.fieldName = @"testProp";
	
	[UIBindingManager bindModel:model toView:instance];
	
	XCTAssertEqual(index, instance.selectedSegmentIndex, @"The selected segment index should be the same as the corresponding codes index");
	XCTAssertEqualObjects(self.codes[index], [instance titleForSegmentAtIndex:instance.selectedSegmentIndex], @"The label at the selected index should match the code at that index.");
}

- (void)testThatChangingTheModelChangesTheView
{
	NSInteger index = 1;
    UIBoundSegmentedControlTestsModel* model = [[UIBoundSegmentedControlTestsModel alloc] init];
	model.testProp = self.codes[index];
	UIView* container = [self getContainerInstance];
	UIBoundSegmentedControl* instance = [self findSegmentedControlIn:container];
	instance.fieldName = @"testProp";
	
	[UIBindingManager bindModel:model toView:instance];
	
	XCTAssertEqual(index, instance.selectedSegmentIndex, @"The selected segment index should be the same as the corresponding codes index");
	XCTAssertEqualObjects(self.codes[index], [instance titleForSegmentAtIndex:instance.selectedSegmentIndex], @"The label at the selected index should match the code at that index.");
	
	index=3;
	model.testProp = self.codes[index];
	
	XCTAssertEqual(index, instance.selectedSegmentIndex, @"The selected segment index should be the same as the corresponding codes index");
	XCTAssertEqualObjects(self.codes[index], [instance titleForSegmentAtIndex:instance.selectedSegmentIndex], @"The label at the selected index should match the code at that index.");
}

- (void)testThatChangingTheViewChangesTheModel
{
	NSInteger index = 1;
    UIBoundSegmentedControlTestsModel* model = [[UIBoundSegmentedControlTestsModel alloc] init];
	model.testProp = self.codes[index];
	UIView* container = [self getContainerInstance];
	UIBoundSegmentedControl* instance = [self findSegmentedControlIn:container];
	instance.fieldName = @"testProp";
	
	[UIBindingManager bindModel:model toView:instance];
	
	XCTAssertEqual(index, instance.selectedSegmentIndex, @"The selected segment index should be the same as the corresponding codes index");
	XCTAssertEqualObjects(self.codes[index], [instance titleForSegmentAtIndex:instance.selectedSegmentIndex], @"The label at the selected index should match the code at that index.");
	
	index=3;
	[instance setSelectedSegmentIndex:index];
	
	XCTAssertEqual(index, instance.selectedSegmentIndex, @"The selected segment index should be the same as the corresponding codes index");
	XCTAssertEqualObjects(self.codes[index], [instance titleForSegmentAtIndex:instance.selectedSegmentIndex], @"The label at the selected index should match the code at that index.");
}

- (UIView*)getContainerInstance
{
	NSBundle* bundle = [NSBundle bundleForClass:[self class]];
	NSArray* nib = [bundle loadNibNamed:@"SegmentedControlTesting" owner:self options:nil];
	
	for(NSObject* obj in nib) {
		if([obj isKindOfClass:[UIView class]]) {
			return (UIView*) obj;
		}
	}
	
	return nil;
}

- (UIBoundSegmentedControl*)findSegmentedControlIn:(UIView*)view
{
	if([view isKindOfClass:[UIBoundSegmentedControl class]]) {
		return (UIBoundSegmentedControl*) view;
	} else {
		for(UIView* subview in view.subviews) {
			UIBoundSegmentedControl* segCtrl = [self findSegmentedControlIn:subview];
			if(segCtrl != nil) {
				return segCtrl;
			}
		}
		return nil;
	}
}

@end
