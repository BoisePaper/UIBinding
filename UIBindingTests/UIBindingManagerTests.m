//
//  UIBindingManagerTests.m
//  UIBinding
//
//  Created by Joel Sonoda on 1/7/14.
//  Copyright (c) 2014 Peter Davidson. All rights reserved.
//

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import <XCTest/XCTest.h>
#import "UIBoundView.h"
#import "UIBindingManager.h"



@interface UIBindingManagerTests : XCTestCase

@end

@implementation UIBindingManagerTests

- (void)testSimpleBinding
{
    UIView<UIBoundView>* view = mockObjectAndProtocol([UIView class], @protocol(UIBoundView));
	NSObject* model = mock([NSObject class]);
	
	UIBindingManager* instance = [[UIBindingManager alloc] init];
	[instance bindModel:model toView:view];
	
	[verify(view) bindToModel:model];
}

- (void)testTableViewBinding
{
	UIView<UIBoundView>* view = mockObjectAndProtocol([UIView class], @protocol(UIBoundView));
	NSObject* model = mock([NSObject class]);
	UITableViewCell* cell = mock([UITableViewCell class]);
	[given([cell subviews]) willReturn:@[view]];
	
	UITableView* tableView = mock([UITableView class]);
	NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
	[given([tableView numberOfSections]) willReturnUnsignedInteger:1];
	[given([tableView numberOfRowsInSection:0]) willReturnUnsignedInteger:1];
	[given([tableView cellForRowAtIndexPath:equalTo(path)]) willReturn:cell];
	
	UIBindingManager* instance = [[UIBindingManager alloc] init];
	[instance bindModel:model toView:tableView];
	
	[verify(view) bindToModel:model];
}

@end
