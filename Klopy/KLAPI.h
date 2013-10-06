//
//  KLAPI.h
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLClipping.h"

@class KLAPI;

@protocol KLAPIDelegate <NSObject>

-(void)api:(KLAPI*)api didReceiveUpdate:(NSDictionary *)info;

@end

@interface KLAPI : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) id<KLAPIDelegate> delegate;

@property (strong, nonatomic) NSURLConnection *networkConnection;

@property (strong, nonatomic) NSMutableArray *clippings;

-(void) update;
-(void) add:(NSString *) string;

@end
