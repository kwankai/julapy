#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include "ofxTileSaver.h"
#include "ofxScreenGrabUtil.h"
#include "Blobs01.h"
#include "Blobs02.h"

class testApp : public ofSimpleApp
{
public:
	void setup();
	void update();
	void draw();
	
	void toggleFullScreen();
	
	void keyPressed( int key );
	void keyReleased( int key );
	void mouseMoved( int x, int y );
	void mouseDragged( int x, int y, int button );
	void mousePressed( int x, int y, int button );
	void mouseReleased( int x, int y, int button );
	void windowResized( int w, int h );
	
	ofRectangle			renderArea;
	ofRectangle			renderAreaWindow;
	ofRectangle			renderAreaFullScreen;
	
	ofxTileSaver		tileSaver;
	ofxScreenGrabUtil	screenGrabUtil;
	
	ofxJulapyApp		*julApp;
};

#endif
	
