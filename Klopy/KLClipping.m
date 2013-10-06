//
//  KLClipping.m
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "KLClipping.h"

@implementation KLClipping

- (id)init
{
    self = [super init];
    if (self) {
        _content = @"";
        _createdAt = @"";
        _updatedAt = @"";
        _webID = 0;
    }
    return self;
}


-(void) add:(NSDictionary*)input
{
    self.content = [input objectForKey:@"content"];
    self.createdAt = [input objectForKey:@"created_at"];
    self.updatedAt = [input objectForKey:@"updated_at"];
    self.webID = [[input objectForKey:@"id"] intValue];
}


@end
