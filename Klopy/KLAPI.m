//
//  KLAPI.m
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "KLAPI.h"

static NSString *host = @"http://klopy.herokuapp.com/api/";
static double delayInSeconds = 2.0;

@implementation KLAPI

- (id)init
{
    self = [super init];
    if (self) {
        [self update];
    }
    
    return self;
}

-(void) update
{
    self.networkConnection = [self connectionTo:@"all" withParams:@""];
}

-(void) add:(NSString *) string{
    self.networkConnection = [self connectionTo:@"create" withParams:[NSString stringWithFormat:@"content=%@",[string stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //    NSLog(@"did receive response: %@", response.description);
}

-(NSURLConnection *) connectionTo:(NSString *) path withParams:(NSString *)params
{
    
    NSString *tmpString = [NSString stringWithFormat:@"%@%@.json?%@", host, path, params];
//    NSLog(@"%@", tmpString);
    NSURLConnection *tmp = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:
                                                                     [NSURL URLWithString:tmpString
                                                                      ]]
                                                           delegate:self
                                                   startImmediately:YES];
    [tmp start];
//    NSLog(@"%@", tmp.debugDescription);
    return tmp;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    //    [self.clippings removeAllObjects];
    
    NSMutableArray *tmpNew = [[NSMutableArray alloc] init];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    for (int i = 0; i < jsonArray.count; i++) {
        KLClipping *clipping = [[KLClipping alloc] init];
        [clipping add:[jsonArray objectAtIndex:i]];
        [tmpNew addObject:clipping];
    }
    
    
    if (!self.clippings) {
        self.clippings = tmpNew;
        [self.delegate api:self didReceiveUpdate:nil];
    }else if (self.clippings.count != tmpNew.count){
        self.clippings = tmpNew;
        [self.delegate api:self didReceiveUpdate:nil];
        // send message back to delegate
    }
    
    // begin another pull
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self update];
    });
    
    
}

@end
