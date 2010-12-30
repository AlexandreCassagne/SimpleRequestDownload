//
//  SimpleRequestDownload.h
//  
//  Contact at alexandre.cassagne@gmail.com
//
//  => You may use this code freely, without need for credit – although it is greatly appreciated ;)
//  but please tell me (at my email address quoted above) if you use or improve it.
//  It has been tested and is in use in my applications, but I am not responsible for how it used
//
//  Created by Alexandre Cassagne on 17/06/2010.
//  Copyright 2010 Alexandre Cassagne. All rights reserved.
//


/* -- ABSTRACT / DOCUMENTATION --
 This class is a wrapper for NSURLConnection to quickly and efficiently 
 download the URL Request provided. It is used this way :
 set the 'request' property with an NSURLRequest ;
 set the 'delegate' property with an id which conforms to the <SimpleRequestDownloadDelegate> protocol ;
 call 'startRequest' ;
 make sure your protocol implements all required methods.
 requestDidStartConnection:, if implemented, is called even if the connection
 fails (in other words, you can count on code written in request:didFailDownloadWithError:).
 
 About the 'networkCount', it is a public method which allows you to do simultaneous network operations and have
 a coherent network indicator. If you wish to launch a connection from another class, it would be a good
 idea to indicate when you start a connection with [SimpleRequestDownload retainNetwork] and
 when that connection is over with [SimpleRequestDownload releaseNetwork].
 It is comparable to NSObjects's retain/release/count scheme but for the network indicator
*/

#import <Foundation/Foundation.h>

#define IS_IPHONE NO

@protocol SimpleRequestDownloadDelegate
@required
- (void)request:(NSURLRequest*)request didDownloadData:(NSData*)data MIMEType:(NSString*)MIMEType;
- (void)request:(NSURLRequest*)request didFailDownloadWithError:(NSError*)error;
@optional
- (void)requestDidStartConnection:(NSURLRequest*)request;
@end

@interface SimpleRequestDownload : NSObject {
	NSURLConnection *theConnection;
	NSString *MIMEType;
	NSURLRequest *request;
	id<SimpleRequestDownloadDelegate> delegate;
	NSMutableData *receivedData;
}

// If someone knows how to make it a conditional preprocesor directive to import
// UIKit if it is an iPhone…
// In the meantime, uncomment the following methods and their equivalent in
// the implementation if you are on iPhone.
// Don't forget to import UIKit if needed.
/*
+ (int)networkCount; // 
+ (void)retainNetwork; // 
+ (void)releaseNetwork; // 
*/
- (void)startRequest;
@property (nonatomic, retain) id<SimpleRequestDownloadDelegate> delegate;
@property (nonatomic, retain) NSURLRequest *request;
@end
