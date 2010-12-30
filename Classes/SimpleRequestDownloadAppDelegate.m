//
//  SimpleRequestDownloadAppDelegate.m
//  SimpleRequestDownload
//
//  Created by Alexandre Cassagne on 30/12/2010.
//  Copyright 2010 Alexandre Cassagne. All rights reserved.
//

#import "SimpleRequestDownloadAppDelegate.h"

@implementation SimpleRequestDownloadAppDelegate

@synthesize imageView;
@synthesize window;
@synthesize urlField;
- (void)requestDidStartConnection:(NSURLRequest *)request {
    
}


- (void)request:(NSURLRequest *)request didFailDownloadWithError:(NSError *)error
{
    NSRunInformationalAlertPanel(@"", [NSString stringWithFormat:@"Connection failed because %@", error], @"OK", nil, nil);
    
}


- (void)request:(NSURLRequest *)request didDownloadData:(NSData *)data MIMEType:(NSString *)MIMEType
{
    if ([MIMEType hasPrefix:@"image"]){
        NSImage *image = [[NSImage alloc] initWithData:data];
        [imageView setImage:image];
        [mimeType setStringValue:MIMEType];
        [mimeType setTextColor:[NSColor blackColor]];
    }
    else {
        NSRunInformationalAlertPanel(@"Incorrect media type", [NSString stringWithFormat:@"The URL you entered links to a media of type %@. It should link to an image.", MIMEType] , @"OK", nil, nil);
        [imageView setImage:nil];
        [mimeType setStringValue:MIMEType];
        [mimeType setTextColor:[NSColor redColor]];
    }
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (IBAction)startRequest:(id)sender {
    NSURL *URLField = [NSURL URLWithString:[self.urlField stringValue]];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URLField];
    SimpleRequestDownload* SRD = [[SimpleRequestDownload alloc] init];
    SRD.request = URLRequest;
    [SRD setDelegate:self];
    [SRD startRequest];
    [SRD release];
}
@synthesize mimeType;

- (void)dealloc {
    [window release];
    [super dealloc];
}
@end
