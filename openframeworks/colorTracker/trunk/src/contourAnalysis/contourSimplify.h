#pragma once


#include "ofMain.h"
#include "ofxVectorMath.h"
#include "ofxOpenCv.h"

#include "polylineSimplify.h"
#include "convexHull.h"

class contourSimplify{
	
	public:
		contourSimplify(){
		
		}
		
		//------------------------------
		void smooth(vector <ofxPoint2f> &contourIn, vector <ofxPoint2f> &contourOut, float smoothPct){
			int length = MIN(contourIn.size(), contourOut.size());
			
			float invPct = 1.0 - smoothPct;
			
			//first copy the data 
			for(int i = 0; i < length; i++){
				contourOut[i] = contourIn[i];
			}
			
			//then smooth the contour
			//we start at 1 as we take a small pct of the prev value
			for(int i = 1; i < length; i++){
				contourOut[i] = contourOut[i] * smoothPct   +   contourOut[i-1] * invPct;
			}
			
		}
		
		//------------------------------
		void simplify(vector <ofxPoint2f> &contourIn, vector <ofxPoint2f> &contourOut, float tolerance){
			int length = contourIn.size();
		
			//the polyLine simplify class needs data as a vector of ofxPoint3fs 
			ofxPoint3f		*polyLineIn = new ofxPoint3f[length];
			ofxPoint3f		*polyLineOut = new ofxPoint3f[length];
			
			//first we copy over the data to a 3d point array
			for(int i = 0; i < length; i++){
				polyLineIn[i].x = contourIn[i].x;
				polyLineIn[i].y = contourIn[i].y;
				polyLineIn[i].z = 0.0f;
				polyLineOut[i].x = 0.0f;
				polyLineOut[i].y = 0.0f;
				polyLineOut[i].z = 0.0f;
			}
			
			int numPoints = poly_simplify(tolerance, polyLineIn, length, polyLineOut);
			contourOut.clear();
			contourOut.assign(numPoints, ofxPoint2f());
			
			//copy the data to our contourOut vector
			for(int i = 0; i < numPoints; i++){
				contourOut[i].x = polyLineOut[i].x;
				contourOut[i].y = polyLineOut[i].y;
			}
			
			delete[] polyLineIn;
			delete[] polyLineOut;
			
		}
		
		//------------------------------
		void convexHull(vector <ofxPoint2f> &contourIn, vector <ofxPoint2f> &contourOut){
			
			int numPtsIn = contourIn.size();
						
			vector <hPoint> hullPointsIn;
			hullPointsIn.clear();
			hullPointsIn.assign(numPtsIn, hPoint());
			
			for(int i = 0; i < numPtsIn; i++){
				hullPointsIn[i].x = contourIn[i].x;
				hullPointsIn[i].y = contourIn[i].y;
			}
			
			vector <hPoint> hullPointsOut = calcConvexHull(hullPointsIn);
			int numOut = hullPointsOut.size();
			
			contourOut.clear();
			contourOut.assign(numOut, ofxPoint2f() );
			
			for(int i = 0; i < numOut; i++){
				contourOut[i].x = hullPointsOut[i].x;
				contourOut[i].y = hullPointsOut[i].y;
			}
			
		}
		
		
};