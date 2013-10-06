//
//  KLClipping.h
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLClipping : NSObject

@property (strong, nonatomic) NSString *content;
@property (nonatomic) int webID;
@property (strong, nonatomic) NSString *createdAt;
@property (strong, nonatomic) NSString *updatedAt;

-(void) add:(NSDictionary*)input;


@end
