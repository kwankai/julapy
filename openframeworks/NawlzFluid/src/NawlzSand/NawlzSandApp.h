#ifndef NAWLZ_SAND_APP
#define NAWLZ_SAND_APP

#include "ofMain.h"

#ifndef TARGET_OF_IPHONE

#include "ofxSimpleGuiToo.h"

#include "NawlzSand.h"

class NawlzSandApp : public ofBaseApp
{
public:
	
	void setup	();
	void update	();
	void draw	();
	
	void keyPressed		( int key );
	void keyReleased	( int key );
	void mouseMoved		( int x, int y );
	void mouseDragged	( int x, int y, int button );
	void mousePressed	( int x, int y, int button );
	void mouseReleased	( int x, int y, int button );
	void windowResized	( int w, int h );
	
	bool				bDebug;
	
	ofImage				backgroundImage;
	ofImage				particleImage;
	
	NawlzSand			nawlzSand;
	
	ofxSimpleGuiToo		gui;
};

#endif

#endif
