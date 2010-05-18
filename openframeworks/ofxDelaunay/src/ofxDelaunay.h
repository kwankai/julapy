/*
 *  ofxDelaunay.h
 *  openFrameworks
 *
 *  Created by Pat Long on 29/10/09.
 *  Copyright 2009 Tangible Interaction. All rights reserved.
 *
 *  Some parts based on demo code by Gilles Dumoulin. 
 *  Source: http://local.wasp.uwa.edu.au/~pbourke/papers/triangulate/cpp.zip
 *
 *	Cleaned up by Lukasz Karluk, 19/05/2010
 *
 */

#ifndef _OFX_DELAUNAY
#define _OFX_DELAUNAY

#include "ofMain.h"
#include "Delaunay.h"

struct ofxDelaunayTriangle
{
	ofPoint		points[ 3 ];
	int			pointIndex[ 3 ];
};

class ofxDelaunay
{

public:
	
	 ofxDelaunay();
	~ofxDelaunay();
	
	int  addPoint		( const ofPoint& point );
	int  addPoint		( float x, float y, float z );
	
	int  triangulate	();
	void reset			();
	void draw			();
	
	vector<ofxDelaunayTriangle>		triangles;
	
private:
	
	vector<XYZ>			points;
	
};

#endif
