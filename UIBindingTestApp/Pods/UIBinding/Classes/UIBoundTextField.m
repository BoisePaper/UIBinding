//
//  UIBoundTextField.m
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import "UIBoundTextField.h"

@interface UIBoundTextField()
@property(strong) NSObject * currentModel;
@end


@implementation UIBoundTextField

@synthesize fieldName;
@synthesize currentModel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self) {
		currentModel = nil;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextChange:) name:UITextFieldTextDidChangeNotification object:self];
	}
	return self;
}

-(void)bindToModel:(NSObject*)model
{
	// Bind from model to text field
	self.text = [model valueForKey:self.fieldName];
	
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
	self.currentModel = model;
	[model addObserver:self forKeyPath:self.fieldName options:NSKeyValueObservingOptionNew context:NULL];
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

-(void)handleTextChange:(NSNotification*)notification {
	if(self.currentModel != nil) {
		[self.currentModel setValue:self.text forKey:self.fieldName];
	}
}

-(void)dealloc
{
	[self.currentModel removeObserver:self forKeyPath:self.fieldName];
}
@end
