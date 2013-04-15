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
#pragma mark - C++ OF class

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
void ofxiPhoneWebViewController::loadNewUrl(NSURL *url) {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

//--------------------------------------------------------------
void ofxiPhoneWebViewController::loadLocalFile(string & filename) {
  
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html" inDirectory:@"www"];
    
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:baseURL];

}


#pragma mark Private

//--------------------------------------------------------------
void ofxiPhoneWebViewController::createView(BOOL withToolbar, CGRect frame){
    // init view
    _view = [[UIView alloc] initWithFrame:frame];
    
    //_view.backgroundColor = [UIColor whiteColor];
    
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

    _webView.opaque = false;
    _webView.backgroundColor = [UIColor clearColor];
    
    [_view addSubview:_webView];
    _webView.delegate = _delegate;
    
    _view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


#pragma mark Callbacks
//--------------------------------------------------------------
void ofxiPhoneWebViewController::didStartLoad() {
    ofxiPhoneWebViewControllerEventArgs args = ofxiPhoneWebViewControllerEventArgs(_webView.request.URL, ofxiPhoneWebViewStateDidStartLoading, nil);
    ofNotifyEvent(event, args, this);
}

//--------------------------------------------------------------
void ofxiPhoneWebViewController::didFinishLoad() {
    ofxiPhoneWebViewControllerEventArgs args = ofxiPhoneWebViewControllerEventArgs(_webView.request.URL, ofxiPhoneWebViewStateDidFinishLoading, nil);
    ofNotifyEvent(event, args, this);
}

//--------------------------------------------------------------
void ofxiPhoneWebViewController::didFailLoad(NSError *error) {
    ofxiPhoneWebViewControllerEventArgs args = ofxiPhoneWebViewControllerEventArgs(_webView.request.URL, ofxiPhoneWebViewStateDidFailLoading, error);
    ofNotifyEvent(event, args, this);
}

///-------------------------------------------------
/// obj-c webview delegate
///-------------------------------------------------
#pragma mark - Obj-c WebView Delegate

@implementation ofxiPhoneWebViewDelegate

@synthesize delegate;

- (void)closeButtonTapped {
    delegate->hideAnimated(YES);
}

//
// UIWebviewDelegate methods
//

- (void)webViewDidStartLoad:(UIWebView *)webView {
    delegate->didStartLoad();
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    delegate->didFinishLoad();
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    delegate->didFailLoad(error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end