//
//  SimpleRequestDownload.m
//  
//  Contact at alexandre.cassagne@gmail.com
//
//  => You may use this code freely, without need for credit Ð although it is greatly appreciated ;)
//  but please tell me (at my email address quoted above) if you use or improve it.
//  It has been tested and is in use in my applications, but I am not responsible for how it used
//
//  Created by Alexandre Cassagne on 17/06/2010.
//  Copyright 2010 Alexandre Cassagne. All rights reserved.
//

#import "SimpleRequestDownload.h"

#import <Foundation/Foundation.h>

@implementation SimpleRequestDownload
@synthesize delegate, request;

/* static int networkCount = 0;
+ (void)retainNetwork {
    if (IS_IPHONE) {
        networkCount++;
        if (networkCount > 0) {
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = YES;
        }
        else {
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = NO;
        }
    }
}
+ (void)releaseNetwork {
    if (IS_IPHONE) {
        networkCount--;
        if (networkCount > 0) {
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = YES;
        }
        else {
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = NO;
        }
    }
}
+ (unsigned int)networkCount {
    if (IS_IPHONE) {
        return networkCount;
    }
    return 0;
}
 */
- (void)startRequest {
	theConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self];
    
	if (theConnection) {
		[receivedData release];
		receivedData = nil;
		receivedData = [[NSMutableData data] retain];
        if (IS_IPHONE) [SimpleRequestDownload retainNetwork];
		[self retain];
	} 
	else {
		[self.delegate request:[self request] didFailDownloadWithError:nil];
		[theConnection release];
	}
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	MIMEType = [response MIMEType];
	[receivedData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if (IS_IPHONE) [SimpleRequestDownload releaseNetwork];
    [receivedData release];
	[self.delegate request:request didFailDownloadWithError:error];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (IS_IPHONE) [SimpleRequestDownload releaseNetwork];
	[self.delegate request:request didDownloadData:receivedData MIMEType:MIMEType];
	[self release];
}
- (void) dealloc {
	[theConnection release];
	[receivedData release];
	[super dealloc];
}
@end
