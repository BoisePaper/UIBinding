//
//  UIBoundLabel.m
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import "UIBoundLabel.h"

@interface UIBoundLabel()
@property(strong)NSObject * currentModel;
@end

@implementation UIBoundLabel

@synthesize fieldName;
@synthesize currentModel;
@synthesize format;


-(void)bindToModel:(NSObject*)model
{
	NSString * name = self.fieldName;
	if ([name rangeOfString:@"."].location == NSNotFound){
		name = [@"self." stringByAppendingString:name];
	}
	NSObject * value = [model valueForKeyPath:name];
	[self setTextWithModelValue:value];
	
	
	// Bind from model to text field
	
	
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
	self.currentModel = model;
	[model addObserver:self forKeyPath:self.fieldName options:NSKeyValueObservingOptionNew context:NULL];
}


-(void) setTextWithModelValue:(NSObject *) modelValue
{
//	if(self.format != nil && [modelValue isKindOfClass:[NSNumber class]])
//	{
//		NSNumberFormatter nf = [[NSNumberFormatter alloc] init];
//		nf.
//	}
//	else if (self.format !=nil && [modelValue isKindOfClass:[NSDate class]])
//	{
//		
//	}
//	else
//	{
		self.text = [NSString stringWithFormat:@"%@", modelValue];
//	}
	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:self.fieldName]) {
		NSString* newVal = change[NSKeyValueChangeNewKey];
		if(![newVal isEqualToString:self.text]) {
			self.text = newVal;
		}
	}
}

-(void)dealloc
{
	[self.currentModel removeObserver:self forKeyPath:self.fieldName];
}

@end
