//
//  SimpleRequestDownloadAppDelegate.h
//  SimpleRequestDownload
//
//  Created by Alexandre Cassagne on 30/12/2010.
//  Copyright 2010 Alexandre Cassagne. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "SimpleRequestDownload.h"
@interface SimpleRequestDownloadAppDelegate : NSObject<NSApplicationDelegate, SimpleRequestDownloadDelegate>
{
    NSWindow *window;
    NSTextField *urlField;
    NSTextField *mimeType;
    NSImageView *imageView;
}
@property (retain) IBOutlet NSImageView *imageView;

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSTextField *urlField;
- (IBAction)startRequest:(id)sender;
@property (retain) IBOutlet NSTextField *mimeType;

@end
