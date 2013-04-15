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
/// Event
///-------------------------------------------------

typedef enum _ofxiPhoneWebViewState{
    ofxiPhoneWebViewStateUndefined,
    ofxiPhoneWebViewStateDidStartLoading,
    ofxiPhoneWebViewStateDidFinishLoading,
    ofxiPhoneWebViewStateDidFailLoading
} ofxiPhoneWebViewState;

class ofxiPhoneWebViewControllerEventArgs : public ofEventArgs
{     
public:
    NSURL *url;
    NSError *error;
    ofxiPhoneWebViewState state;
    
	ofxiPhoneWebViewControllerEventArgs()
    {
        url = nil;
        error = nil;
        state = ofxiPhoneWebViewStateUndefined;
    }
    
    ofxiPhoneWebViewControllerEventArgs(NSURL *_url, ofxiPhoneWebViewState _state, NSError *_error)
    {
        url = _url;
        state = _state;
        error = _error;
    }
}; 

///-------------------------------------------------
/// c++ OF class
///-------------------------------------------------

@class ofxiPhoneWebViewDelegate;
class ofxiPhoneWebViewController {
    
public:
    void showAnimatedWithUrl(BOOL animated, NSURL *url);
    void showAnimatedWithUrlAndFrameAndToolbar(BOOL animated, NSURL *url, CGRect frame, BOOL addToolbar);
    
    void hideAnimated(BOOL animated);
    
    void loadNewUrl(NSURL *url);
    void loadLocalFile(string & filename);
    
    ofEvent<ofxiPhoneWebViewControllerEventArgs> event;
    
    /**
     * I would prefer to make these methods private, but we can't make a obj-c class a friend of a c++ class.
     */
    void didStartLoad();
    void didFinishLoad();
    void didFailLoad(NSError *error);
    
private:
    void createView(BOOL addToolbar, CGRect frame);
    UIView *_view;
    UIWebView *_webView;
    ofxiPhoneWebViewDelegate *_delegate;
};

///-------------------------------------------------
/// obj-c webview delegate
///-------------------------------------------------

@interface ofxiPhoneWebViewDelegate : NSObject <UIWebViewDelegate> {
    int _numWebViewLoads; // to prevent firing delegate multiple times
}

- (void)closeButtonTapped;

@property (nonatomic, assign) ofxiPhoneWebViewController *delegate;
@end
