#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    
	// initialize the accelerometer
	ofxAccelerometer.setup();
	//If you want a landscape oreintation
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
	
	ofBackground(127);

    inlineWebViewController.showView(ofGetWindowWidth(), ofGetWindowHeight(), NO, YES, YES, NO);
    inlineWebViewController.setOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
    inlineWebViewController.setAutoRotation(false);
    
    ofAddListener(inlineWebViewController.event, this, &testApp::webViewEvent);

    string fileToLoad = "demo";
    inlineWebViewController.loadLocalFile(fileToLoad);

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
    
    ofSetColor(255);
    ofCircle(0,0,1500);
    ofSetColor(0);
    ofDrawBitmapString(ofToString(ofGetWindowWidth())+"/"+ofToString(ofGetWidth()), ofPoint(20,500));
	
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
    
    // TODO: Better way of handling autorotation.
    
    if(!inlineWebViewController.autoRotation) return;

    switch (newOrientation) {
        case 1:
            inlineWebViewController.setOrientation(OFXIPHONE_ORIENTATION_PORTRAIT);
            break;
        case 2:
            inlineWebViewController.setOrientation(OFXIPHONE_ORIENTATION_UPSIDEDOWN);
            break;
        case 3:
            inlineWebViewController.setOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
            break;
        case 4:
            inlineWebViewController.setOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
            break;
        default:
            break;
    }
    
}

