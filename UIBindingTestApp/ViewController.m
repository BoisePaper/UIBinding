//
//  ViewController.m
//  UIBindingTestApp
//
//  Created by Peter Davidson on 1/2/14.
//  Copyright (c) 2014 Peter Davidson. All rights reserved.
//

#import "ViewController.h"
#import "ParentModel.h"
#import "ChildModel.h"
#import "UIBindingManager.h"

@interface ViewController ()

@end

@implementation ViewController{
	ParentModel * parentModel;
	ChildModel * childModel;
	UIBindingManager * binder;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupModels];
	[self setupBinding];
	
	
	
}

- (void) setupBinding
{
	binder = [[UIBindingManager alloc] initWithView:self.view model:parentModel];
	
}

- (void)setupModels
{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	dateFormat.dateFormat = @"MM/dd/yyyy";
	
	parentModel = [[ParentModel alloc] init];
	parentModel.boolean = NO;
	parentModel.string = @"Parent String";
	parentModel.number = [NSNumber numberWithDouble:-50.0];
	parentModel.date = [dateFormat dateFromString:@"08/06/1979"];

	
	childModel = [[ChildModel alloc] init];
	parentModel.child = childModel;
	childModel.childBoolean = YES;
	childModel.childNumber = [NSNumber numberWithInt:123015];
	childModel.childString = @"Child String";
	
	childModel.childDate = [dateFormat dateFromString:@"07/19/2008"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
