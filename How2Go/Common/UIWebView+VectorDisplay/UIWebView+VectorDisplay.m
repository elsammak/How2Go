//
//  UIWebView+VectorDisplay.m
//  VectorDisplay
//
//  Created by Mohammed Elsammak on 4/17/16.
//  Copyright © 2016 Elsammak. All rights reserved.
//

#import "UIWebView+VectorDisplay.h"

@implementation UIWebView (VectorDisplay)

- (void) setupImageHtml:(NSString*) ImageUrl
{
    
    NSString* html =  [[NSString alloc] initWithFormat:@"%@%@%@", @"<!DOCTYPE html>"
                       "<html>"
                       "<head>"
                       "<style type=\"text/css\">"
                       "img{"
                       "position: absolute;"
                       "top: 0;"
                       "bottom: 0;"
                       "left: 0;"
                       "right: 0;"
                       "margin: auto;"
                       "max-width: 100%;"
                       "max-height: 100%;"
                       "}"
                       "</style>"
                       "</head>"
                       "<img src='",ImageUrl,@"'/> </body></html>"];
        
    [self loadHTMLString:html baseURL:nil];
}

@end
