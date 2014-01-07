//
//  UIBindingManager.m
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import "UIBindingManager.h"
#import "UIBoundView.h"

@implementation UIBindingManager

-(id)initWithView:(UIView *)view model:(NSObject *)model
{
	if (self = [super init])
	{
		[self bindModel:model toView:view];
	}
	return self;
}

+(void) bindModel:(NSObject*)model toView:(UIView*)view
{
	UIBindingManager* instance = [[UIBindingManager alloc] init];
	[instance bindModel:model toView:view];
}

-(void) bindModel: (NSObject*)model toView:(UIView*)view
{
	[self for:view andAllSubviewsPerform:^(UIView *vw) {
		if([vw conformsToProtocol:@protocol(UIBoundView)]) {
			UIView<UIBoundView>* bf = (UIView<UIBoundView>*) vw;
			[bf bindToModel:model];
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
