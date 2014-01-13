//
//  EABoundStepper.m
//  EstimateAssistant
//
//  Created by Joel Sonoda on 1/13/14.
//  Copyright (c) 2014 Boise Inc. All rights reserved.
//

#import "UIBoundStepper.h"

@interface UIBoundStepper()
@property NSObject* currentModel;
@end

@implementation UIBoundStepper
@synthesize fieldName;
@synthesize currentModel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currentModel = nil;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
        currentModel = nil;
		[self addTarget:self action:@selector(handleValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:self.fieldName]) {
		NSObject* newVal = change[NSKeyValueChangeNewKey];
		
		if([newVal isKindOfClass:[NSNumber class]]) {
			NSNumber* newNumber = (NSNumber*) newVal;
			if(![newNumber isEqualToNumber:[NSNumber numberWithDouble:self.value]]) {
				self.value = newNumber.doubleValue;
			}
		}
		
		if([newVal isKindOfClass:[NSString class]]) {
			NSNumber* newNumber = [NSNumber numberWithDouble:[((NSString*)newVal) doubleValue]];
			if(![newNumber isEqualToNumber:[NSNumber numberWithDouble:self.value]]) {
				self.value = newNumber.doubleValue;
			}
		}
	}
}

-(void)bindToModel:(NSObject *)model
{
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
		
	self.currentModel = model;
	NSObject* modelValue = [self.currentModel valueForKeyPath:self.fieldName];
	if([modelValue isKindOfClass:[NSNumber class]]) {
		self.value = ((NSNumber*)modelValue).doubleValue;
	} else if([modelValue isKindOfClass:[NSString class]]) {
		self.value = [((NSString*)modelValue) doubleValue];
	}
	self.value = [[self.currentModel valueForKeyPath:self.fieldName] doubleValue];

	[model addObserver:self forKeyPath:self.fieldName options:NSKeyValueObservingOptionNew context:NULL];
	
}

-(void)handleValueChange:(id)sender
{
	if(self.currentModel != nil) {
		NSObject* currentValue = [self.currentModel valueForKeyPath:self.fieldName];
		if([currentValue isKindOfClass:[NSNumber class]]) {
			[self.currentModel setValue:[NSNumber numberWithDouble:self.value] forKeyPath:self.fieldName];
		} else if([currentValue isKindOfClass:[NSString class]]) {
			NSString* newValue = [NSString stringWithFormat:@"%f", self.value];
			[self.currentModel setValue:newValue forKeyPath:self.fieldName];
		}
		
	}
}

-(void)dealloc
{
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
}

@end
