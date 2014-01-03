//
//  EABoundSwitch.m
//  EstimateAssistant
//
//  Created by Joel Sonoda on 12/30/13.
//  Copyright (c) 2013 Boise Inc. All rights reserved.
//

#import "UIBoundSwitch.h"

@interface UIBoundSwitch()
@property NSObject* currentModel;
@end


@implementation UIBoundSwitch
@synthesize fieldName;
@synthesize currentModel;


- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self) {
		currentModel = nil;
		[self addTarget:self action:@selector(handleValueChange:) forControlEvents:UIControlEventValueChanged];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)bindToModel:(NSObject *)model
{
	NSNumber* isOn = [model valueForKey:self.fieldName];
	self.on = [isOn boolValue];
	
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
	self.currentModel = model;
	[model addObserver:self forKeyPath:self.fieldName options:NSKeyValueObservingOptionNew context:NULL];
	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:self.fieldName]) {
		BOOL newVal = ((NSNumber*)change[NSKeyValueChangeNewKey]).boolValue;
		if(newVal != self.on) {
			[self setOn:newVal animated:YES];
		}
	}
}

-(void)handleValueChange:(id)source {
	if(self.currentModel != nil) {
		[self.currentModel setValue:[NSNumber numberWithBool:self.on] forKey:self.fieldName];
	}
}

-(void)dealloc
{
	if(self.currentModel != nil) {
		[self.currentModel removeObserver:self forKeyPath:self.fieldName];
	}
}

@end
