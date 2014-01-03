//
//  EABoundSegmentedControl.m
//  EstimateAssistant
//
//  Created by Joel Sonoda on 12/31/13.
//  Copyright (c) 2013 Boise Inc. All rights reserved.
//

#import "UIBoundSegmentedControl.h"

@interface UIBoundSegmentedControl()
@property NSObject* currentModel;
@property NSMutableDictionary* indexByCode;
@property NSMutableArray* codeByIndex;
@end

@implementation UIBoundSegmentedControl
@synthesize fieldName;
@synthesize currentModel;
@synthesize indexByCode;
@synthesize codeByIndex;


- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self) {
		currentModel = nil;
		indexByCode = [[NSMutableDictionary alloc] init];
		codeByIndex = [[NSMutableArray alloc] init];
		[self addTarget:self action:@selector(handleValueChange:) forControlEvents:UIControlEventValueChanged];
		for(int i=0; i<self.numberOfSegments; i++) {
			NSString* code = [self titleForSegmentAtIndex:i];
			indexByCode[code] = [NSNumber numberWithInt:i];
			codeByIndex[i] = code;
			NSString* stringRef = NSLocalizedString(code, @"Value from a segmented control");
			[self setTitle:stringRef forSegmentAtIndex:i];
		}
	}
	return self;
}

-(void)bindToModel:(NSObject *)model
{
	NSString* code = [model valueForKey:self.fieldName];
	NSNumber* index = indexByCode[code];
	if(index == nil) {
		index = @-1;
	}
	[self setSelectedSegmentIndex:[index integerValue]];
	
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
	
	self.currentModel = model;
	[model addObserver:self forKeyPath:self.fieldName options:NSKeyValueObservingOptionNew context:NULL];
	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:self.fieldName]) {
		NSString* newCode = change[NSKeyValueChangeNewKey];
		NSNumber* index = indexByCode[newCode];
		if(index.integerValue != self.selectedSegmentIndex) {
			[self setSelectedSegmentIndex:index.integerValue];
		}
	}
}

-(void)handleValueChange:(id)sender {
	if(self.currentModel != nil) {
		[self.currentModel setValue:codeByIndex[self.selectedSegmentIndex] forKey:self.fieldName];
	}
}

-(void)dealloc
{
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
}

@end
