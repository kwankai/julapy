/***********************************************************************
 
 This class is for drawing a fluidsolver using the OpenFrameworks texture
 
 /***********************************************************************
 
 Copyright (c) 2008, 2009, Memo Akten, www.memo.tv
 *** The Mega Super Awesome Visuals Company ***
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of MSA Visuals nor the names of its contributors 
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE. 
 *
 * ***********************************************************************/ 


#pragma once


#include "ofMain.h"
#include "ofxCvMain.h"
#include "ofxMSAFluidSolver.h"

class ofxMSAFluidDrawer
{

public:
	
	ofxMSAFluidDrawer();
	~ofxMSAFluidDrawer();
	
	ofxMSAFluidSolver* setup( ofxMSAFluidSolver* f, int renderWidth, int renderHeight );
	ofxMSAFluidSolver* getFluidSolver();
	
	void update();
	void draw( float x, float y, float renderWidth, float renderHeight );
	unsigned char * getFluidPixels();
	
	ofxCvGrayscaleImage	imageSml;
	ofxCvGrayscaleImage	imageLrg;
	unsigned char		*imagePixels;
	int					imageSmlWidth;
	int					imageSmlHeight;
	int					imageLrgWidth;
	int					imageLrgHeight;

protected:	
	
	ofxMSAFluidSolver	*_fluidSolver;
	
};
