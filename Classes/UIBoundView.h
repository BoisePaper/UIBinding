//
//  BPMBoundView.h
//  BoisePaperMobile
//
//  Created by Peter Davidson on 12/27/13.
//  Copyright (c) 2013 Boise Paper Holdings. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UIBoundView <NSObject>
@property (nonatomic, strong) NSString* fieldName;
-(void) bindToModel:(NSObject *) model;

@optional
@property (nonatomic, strong) NSString * format;

@end
