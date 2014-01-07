//
//  UIBoundLabel.h
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBoundView.h"

@interface UIBoundLabel : UILabel<UIBoundView>
@property NSString * negativeFormat;
@end
