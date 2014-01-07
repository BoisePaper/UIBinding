//
//  UIBindingManagerTests.m
//  UIBinding
//
//  Created by Joel Sonoda on 1/7/14.
//  Copyright (c) 2014 Peter Davidson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIBoundView.h"
#import "UIBindingManager.h"

@interface UIBindingManagerTestsMockView : UIView<UIBoundView>
@property NSObject* model;
@end

@implementation UIBindingManagerTestsMockView
@synthesize fieldName;
-(void) bindToModel:(NSObject *) model
{
	self.model = model;
}

@end

@interface UIBindingManagerTests : XCTestCase

@end

@implementation UIBindingManagerTests

- (void)testSimpleBinding
{
    UIBindingManagerTestsMockView* view = [[UIBindingManagerTestsMockView alloc] init];
	NSObject* model = [[NSObject alloc] init];
	
	UIBindingManager* instance = [[UIBindingManager alloc] init];
	[instance bindModel:model toView:view];
	
	XCTAssertEqual(model, view.model, @"Model should be bound to view.");
}

@end
