//
//  KLModel.h
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLAPI.h"

@interface KLModel : NSObject

@property (strong, nonatomic) KLAPI *api;

+(id)sharedInstance;

@end
