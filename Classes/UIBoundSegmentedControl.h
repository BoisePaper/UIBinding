//
//  EABoundSegmentedControl.h
//  EstimateAssistant
//
//  Created by Joel Sonoda on 12/31/13.
//  Copyright (c) 2013 Boise Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBoundField.h"

@interface UIBoundSegmentedControl : UISegmentedControl<UIBoundField>
@property NSString* codes;
@end
