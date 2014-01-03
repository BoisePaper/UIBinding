//
//  UIBoundDatePicker.m
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import "UIBoundDatePicker.h"

@interface UIBoundDatePicker()
@property NSObject* currentModel;
@end

@implementation UIBoundDatePicker
@synthesize fieldName;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.currentModel = nil;
		[self addTarget:self action:@selector(handleDateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)bindToModel:(NSObject *)model
{
	// Bind from model to text field
	if([model valueForKey:self.fieldName] != nil) {
		self.date = [model valueForKey:self.fieldName];
	}
	
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
	self.currentModel = model;
	[model addObserver:self forKeyPath:self.fieldName options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:self.fieldName]) {
		NSDate* newVal = change[NSKeyValueChangeNewKey];
		if(![newVal isEqualToDate:self.date]) {
			[self setDate:newVal animated:YES];
		}
	}
}

-(void)handleDateChange:(id)sender
{
	if(self.currentModel != nil) {
		[self.currentModel setValue:self.date forKey:self.fieldName];
	}
}

-(void)dealloc
{
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
}
@end
