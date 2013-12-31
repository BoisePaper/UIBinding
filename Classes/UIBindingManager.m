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

-(void) bindModelToView
{
	[self forEverySubviewOf:_view perform:^(UIView *vw) {
		if([vw conformsToProtocol:@protocol(UIBoundField)]) {
			UIView<UIBoundField>* bf = (UIView<UIBoundField>*) vw;
			[bf bindToModel:_model];
		}
	}];

}

-(void)forEverySubviewOf:(UIView*)view perform:(void(^) (UIView* view)) block
{
	for(UIView* vw in [view subviews]) {
		block(vw);
		[self forEverySubviewOf:vw perform:[block copy]];
	}
}



@end
