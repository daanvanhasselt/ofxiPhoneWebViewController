//
//  ofxiPhoneWebViewController.h
//  emptyExample
//
//  Created by Daan van Hasselt on 5/28/12.
//  Copyright (c) 2012 Touchwonders B.V. All rights reserved.
//

#pragma once

#include "ofMain.h"
#include "ofxiPhoneExtras.h"

///-------------------------------------------------
/// c++ OF class
///-------------------------------------------------

@class ofxiPhoneWebViewDelegate;
class ofxiPhoneWebViewController {
    
public:
    void showAnimatedWithUrl(BOOL animated, NSURL *url);
    void hideAnimated(BOOL animated);
    
private:
    void createView();
    UIView *_view;
    UIWebView *_webView;
    ofxiPhoneWebViewDelegate *_delegate;
};

///-------------------------------------------------
/// obj-c webview delegate
///-------------------------------------------------

@interface ofxiPhoneWebViewDelegate : NSObject <UIWebViewDelegate>
- (void)closeButtonTapped;

@property (nonatomic, assign) ofxiPhoneWebViewController *delegate;
@end
