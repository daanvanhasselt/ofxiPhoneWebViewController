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
    ofxiPhoneWebViewStateDidFailLoading,
    ofxiPhoneWebViewCalledExternalFunction,
    ofxiPhoneWebViewDidCloseWindow
} ofxiPhoneWebViewState;

class ofxiPhoneWebViewControllerEventArgs : public ofEventArgs
{     

    public:
    
        NSURL *url;
        NSString *param;
        NSError *error;
        ofxiPhoneWebViewState state;
    
        ofxiPhoneWebViewControllerEventArgs()
        {
            url = nil;
            param = nil;
            error = nil;
            state = ofxiPhoneWebViewStateUndefined;
        }
    
        ofxiPhoneWebViewControllerEventArgs(NSURL *_url, ofxiPhoneWebViewState _state, NSError *_error)
        {
            url = _url;
            param = nil;
            state = _state;
            error = _error;
        }
    
        ofxiPhoneWebViewControllerEventArgs(NSString *_param, ofxiPhoneWebViewState _state, NSError *_error)
        {
            url = nil;
            param = _param;
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

    void showView(int frameWidth, int frameHeight,  BOOL animated, BOOL addToolbar, BOOL transparent, BOOL scroll, BOOL useTransitionMoveIn);
    void hideView(BOOL animated);
    void reOpenView(BOOL animated, NSString *newurl);
    
    void setOrientation(ofOrientation orientation);
    
    void loadNewUrl(NSString *url);
    void loadLocalFile(string & filename);
    
    ofEvent<ofxiPhoneWebViewControllerEventArgs> event;
    
    bool autoRotation;
    void setAutoRotation(bool _autoRotation);
    
    /**
     * I would prefer to make these methods private, but we can't make a obj-c class a friend of a c++ class.
     */
    void didStartLoad();
    void didFinishLoad();
    void didFailLoad(NSError *error);
    void didCloseWindow();
    
    void callExternalFunction(string &functionName, NSString *param);
    
private:
    
    void createView(BOOL withToolbar, CGRect frame, BOOL transparent, BOOL scroll);
    UIView *_view;
    UIWebView *_webView;
    ofxiPhoneWebViewDelegate *_delegate;
    
    bool isRetina();
    
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

