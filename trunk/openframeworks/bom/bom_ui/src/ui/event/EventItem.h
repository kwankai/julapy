/*
 *  EventItem.h
 *  emptyExample
 *
 *  Created by lukasz karluk on 16/10/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"
#include "ofxSprite.h"
#include "EventDataItem.h"
#include "EventItemCloseBtn.h"

class EventItem : public ofxSprite
{

public:
	
	EventItem()
	{
		rect.width	= 400;
		rect.height	= 400;
		rect.x = x	= (int)( ( ofGetWidth()  - rect.width  ) * 0.5 );
		rect.y = y	= (int)( ( ofGetHeight() - rect.height ) * 0.5 );
		
		closeBtn.setup();
		closeBtn.setPos( rect.x + rect.width - 32, rect.y + 10 );
		closeBtn.enableMouseEvents();
		
		sound = NULL;
		
		ofAddListener( closeBtn.btnPressEvent, this, &EventItem :: closeBtnPressed );
	};
	
	~EventItem()
	{
		closeBtn.disableAllEvents();
		
		ofRemoveListener( closeBtn.btnPressEvent, this, &EventItem :: closeBtnPressed );
	};
	
	//==================================================
	
	ofRectangle			rect;
	EventDataItem		data;
	ofImage*			bg;
	ofSoundPlayer*		sound;
	
	EventItemCloseBtn	closeBtn;
	ofEvent<int>		closeEvent;
	
	//==================================================
	
	void populate ( EventDataItem data )
	{
		this->data = data;
	}
	
	virtual void setup ()
	{
		sound = ofxAssets :: getInstance()->getSoundByFileName( data.sound );
	}
	
	virtual void show ()
	{
		visible = true;
		
		closeBtn.enabled = true;
		
		if( sound != NULL )
		{
			sound->setPosition( 0 );
			sound->play();
		}
	}
	
	virtual void hide ()
	{
		visible = false;
		
		closeBtn.enabled = false;
		
		if( sound != NULL )
		{
			sound->stop();
		}
	}
	
	virtual void update ()
	{
		//
	}
	
	virtual void draw ()
	{
		closeBtn.draw();
	}
	
	void closeBtnPressed ( int & btnId )
	{
		ofNotifyEvent( closeEvent, data.id, this );
	}
	
};