//
//  UIBindingManager.m
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import "UIBindingManager.h"
#import "UIBoundField.h"

@implementation UIBindingManager {
	NSObject * _model;
	UIView * _view;
}


-(id)initWithView:(UIView *)view model:(NSObject *)model
{
	if (self = [super init])
	{
		_model = model;
		_view = view;
		
		[self bindModelToView];
		
	}
	return self;
}

+(void) bindModel:(NSObject*)model toView:(UIView*)view
{
	[[UIBindingManager alloc] initWithView:view model:model];
}

-(void) bindModelToView
{
	[self for:_view andAllSubviewsPerform:^(UIView *vw) {
		if([vw conformsToProtocol:@protocol(UIBoundField)]) {
			UIView<UIBoundField>* bf = (UIView<UIBoundField>*) vw;
			[bf bindToModel:_model];
		}
	}];

}

-(void)for:(UIView*)view andAllSubviewsPerform:(void(^) (UIView* view)) block
{
	block(view);
	for(UIView* vw in [view subviews]) {
		[self for:vw andAllSubviewsPerform:[block copy]];
	}
}



@end
