#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	ofBackground(127,127,127);
    doubleTapCount = 0;

    NSURL *url = [NSURL URLWithString:@"http://www.openframeworks.cc"];
//    NSURL *url = [NSURL URLWithString:@"fdsajiofas0F#ARfs a"];        // this will fail to load

    inlineWebViewController.showAnimatedWithUrlAndFrameAndToolbar(NO, url, CGRectMake(20, 20, 280, 400), NO);
    ofAddListener(inlineWebViewController.event, this, &testApp::webViewEvent);
    ofAddListener(fullscreenWebViewController.event, this, &testApp::webViewEvent);
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ofxiPhoneGetGLView().bounds.size.width, 40)];
    label.center = CGPointMake(ofxiPhoneGetGLView().bounds.size.width / 2.0, ofxiPhoneGetGLView().bounds.size.height - 30);
    label.text = @"Double tap to open fullscreen";
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    [ofxiPhoneGetGLView() addSubview:label];
}

//--------------------------------------------------------------
void testApp::webViewEvent(ofxiPhoneWebViewControllerEventArgs &args) {
    if(args.state == ofxiPhoneWebViewStateDidStartLoading){
        NSLog(@"Webview did start loading URL %@.", args.url);
    }
    else if(args.state == ofxiPhoneWebViewStateDidFinishLoading){
        NSLog(@"Webview did finish loading URL %@.", args.url);
    }
    else if(args.state == ofxiPhoneWebViewStateDidFailLoading){
        NSLog(@"Webview did fail to load the URL %@. Error: %@", args.url, args.error);
    }
}

//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){
	
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    if(doubleTapCount % 3 == 0){
        NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
        fullscreenWebViewController.showAnimatedWithUrl(YES, url);
        label.text = @"Double tap to change URL";
    }
    else if(doubleTapCount %3 == 1){
        NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
        inlineWebViewController.loadNewUrl(url);
        label.text = @"Double tap to change URL back";
    }
    else {
        NSURL *url = [NSURL URLWithString:@"http://www.openframeworks.cc"];
        inlineWebViewController.loadNewUrl(url);
        label.text = @"Double tap to change open fullscreen";
    }

    doubleTapCount ++;
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

