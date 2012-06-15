//
//  ofxiPhoneWebViewController.mm
//  emptyExample
//
//  Created by Daan van Hasselt on 5/28/12.
//  Copyright (c) 2012 Touchwonders B.V. All rights reserved.
//

#include "ofxiPhoneWebViewController.h"


///-------------------------------------------------
/// c++ OF class
///-------------------------------------------------


//--------------------------------------------------------------
void ofxiPhoneWebViewController::showAnimatedWithUrl(BOOL animated, NSURL *url){
    showAnimatedWithUrlAndFrameAndToolbar(animated, url, ofxiPhoneGetGLView().bounds, YES);
}

//--------------------------------------------------------------
void ofxiPhoneWebViewController::showAnimatedWithUrlAndFrameAndToolbar(BOOL animated, NSURL *url, CGRect frame, BOOL addToolbar) {
    // init delegate
    _delegate = [[ofxiPhoneWebViewDelegate alloc] init];
    _delegate.delegate = this;
    
    createView(addToolbar, frame);           // create the view
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    _view.transform = CGAffineTransformMakeTranslation(0, _view.bounds.size.height);          // transform down
    [ofxiPhoneGetGLView() addSubview:_view];     // add to main glView
    if(!animated){
        _view.transform = CGAffineTransformIdentity; // if not animated, just set transform to identity
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{   // otherwise, animate it to identity
        _view.transform = CGAffineTransformIdentity;
    }];
}

//--------------------------------------------------------------
void ofxiPhoneWebViewController::hideAnimated(BOOL animated){
    if(animated){
        [UIView animateWithDuration:0.5 animations:^{
            _view.transform = CGAffineTransformMakeTranslation(0, _view.bounds.size.height);      // transform down
        } completion:^(BOOL finished) {
            [_view removeFromSuperview];
            [_view release];
            [_webView release];
            [_delegate release];
        }];
    }
    else{
        [_view removeFromSuperview];
        [_view release];
        [_webView release];
        [_delegate release];
    }
    
}

//--------------------------------------------------------------
void ofxiPhoneWebViewController::createView(BOOL withToolbar, CGRect frame){
    // init view
    _view = [[UIView alloc] initWithFrame:frame];
    
    _view.backgroundColor = [UIColor whiteColor];
    
    if(withToolbar){
        // add toolbar with close button and title
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _view.bounds.size.width, 44)];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithTitle:@"Browser" style:UIBarButtonItemStylePlain target:nil action:nil];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:_delegate action:@selector(closeButtonTapped)];
        
        [toolbar setItems:[NSArray arrayWithObjects:spacer, title, spacer, closeButton, nil]];
        [_view addSubview:toolbar];
    }
    
    // add webview
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 
                                                           withToolbar ? 44 : 0, 
                                                           _view.bounds.size.width, 
                                                           withToolbar ? _view.bounds.size.height - 44 : _view.bounds.size.height)];
    [_view addSubview:_webView];
    _webView.delegate = _delegate;
}

///-------------------------------------------------
/// obj-c webview delegate
///-------------------------------------------------

@implementation ofxiPhoneWebViewDelegate

@synthesize delegate;

- (void)closeButtonTapped {
    delegate->hideAnimated(YES);
}

//
// UIWebviewDelegate methods below
//

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end