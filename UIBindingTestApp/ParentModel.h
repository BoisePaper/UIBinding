//
//  ParentModel.h
//  UIBinding
//
//  Created by Peter Davidson on 1/2/14.
//  Copyright (c) 2014 Peter Davidson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChildModel.h"

@interface ParentModel : NSObject

@property NSString * string;
@property NSNumber * number;
@property NSDate * date;
@property BOOL boolean;

@property ChildModel * child;
@end
