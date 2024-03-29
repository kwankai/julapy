/*
 *  ColorCycle.h
 *  emptyExample
 *
 *  Created by lukasz karluk on 14/08/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"
#include "ofxBox2d.h"
#include "ofxScreen.h"
#include "ofxColorPicker.h"
#include "ofxDelaunay.h"
#include "ofxEaseValue.h"

#include "ColorPhysics.h"
#include "ColorRect.h"
#include "ColorTriangle.h"
#include "ColorPanel.h"
#include "ColorConstants.h"
#include "ColorSound.h"
 
class ColorCycle
{

public:
	
	 ColorCycle();
	~ColorCycle();
	
	void setBox2d		( ofxBox2d* box2d );
	void setScreenSize	( int w, int h );
	void setFrameRate	( int fr );
	void setSounds		( ColorSound* sounds );
	void setBgClick		( bool b );
	void setUpsideDown	( bool b );
	
	void setGravity		( float gx, float gy );
	
	void setup			();
	void update			();
	void draw			();
	
	void updatePhysics			();
	void updateDelaunay			();
	void fakeDelaunay			();
	void updateTriangles		();
	bool checkTriangleHit		( float x, float y, int id );
	ofColor interpolateColor	( const ofColor& c1, const ofColor& c2, float p );
	
	void drawColorPickers		();
	void drawColorPanel			();
	void drawTriangles			();
	
	void addCircle				();
	void removeCircle			();
	void shuffle				();
	void startColorSelectMode	();
	void stopColorSelectMode	();
	
	void down			( int x, int y, int id = -1 );
	void drag			( int x, int y, int id = -1 );
	void up				( int x, int y, int id = -1 );
	void inputCheck		();
	
	ofxScreen		screen;
	int				frameRate;
	
	ofxBox2d*		box2d;
	
	ofxColorPicker	colorPicker0;
	ofxColorPicker	colorPicker1;
	float			colorScale;
	ofxEaseValue	rndColorAngle0;
	ofxEaseValue	rndColorAngle1;
	ofColor			upperColor;
	ofColor			lowerColor;
	ofColor			white;
	ofColor			black;
	
	ColorPanel		panel;
	
	ColorRect		rect;
	
	ColorPhysics*	physics;

	bool			bColorSelectMode;
	bool			bColorSelectModeOnBgClick;
	bool			bColorSelectTimeout;
	int				colorSelectTimeout;
	int				colorSelectTimeoutMax;
	
	ofPoint			inputPos1;
	ofPoint			inputPos2;
	ofPoint			inputVel;
	int				inputLastID;
	bool			bInputDown;
	
	ofxDelaunay				delaunay;
	vector<ColorTriangle*>	triangles;
	int						trianglesFound;
	ofxEaseValue			triColorScale;
	
	ColorSound*			sounds;
	
	bool			upsideDown;
};