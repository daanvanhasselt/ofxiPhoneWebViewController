#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    
	// initialize the accelerometer
	ofxAccelerometer.setup();
	//If you want a landscape oreintation
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
	
	ofBackground(127);
    
    // TODO: Consider screen sizes and rotation when creating the view to fit the screen.
    inlineWebViewController.showView(CGRectMake(0, 0, ofGetWidth(), ofGetHeight()*1.5), NO, NO, YES, NO);
    
    ofAddListener(inlineWebViewController.event, this, &testApp::webViewEvent);

    string fileToLoad = "demo";
    inlineWebViewController.loadLocalFile(fileToLoad);
    
    // TODO: Size / Rotation more intuitive.
    //       deviceOrientationChanged integrated in classs
    ofxiPhoneGetGLView().transform = CGAffineTransformMakeRotation(PI/2.0);
    ofxiPhoneGetGLView().frame = CGRectMake(0, 0, ofGetHeight(), ofGetWidth());
    
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
void testApp::touchDown(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
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
    float rotation = 0;
    switch (newOrientation) {
        case 1:
            rotation = 0;
            break;
        case 2:
            rotation = PI;
            break;
        case 3:
            rotation = PI / 2.0;
            break;
        case 4:
            rotation = -PI / 2.0;
            break;
            
        default:
            break;
    }
    
    // TODO: Add rotation auto option.
    
    /*
    [UIView animateWithDuration:0.5 animations:^{
        ofxiPhoneGetGLView().transform = CGAffineTransformMakeRotation(rotation);
        ofxiPhoneGetGLView().frame = CGRectMake(0, 0, ofGetHeight(), ofGetWidth());;
    }];
    */
    
}

