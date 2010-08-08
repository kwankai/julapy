/*
 *  ofxStage.h
 *  emptyExample
 *
 *  Created by Lukasz Karluk on 6/08/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"
#include "ofxSprite.h"

class ofxStage : public ofxSprite
{	
	
public:
	
	 ofxStage();
	~ofxStage();
	
	void update	( ofEventArgs &e );
	void draw	( ofEventArgs &e );
	
	///////////////////////////////////////////////
	//
	//	PRIVATE.
	//
	///////////////////////////////////////////////
	
private:

	void updateChildren	( vector<ofxSprite*>& children );
	void drawChildren	( vector<ofxSprite*>& children );
};