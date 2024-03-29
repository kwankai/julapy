package com.julapy.ph.makeup.view
{
	import com.holler.core.View;
	import com.julapy.ph.makeup.events.BlinkEvent;
	import com.julapy.ph.makeup.model.ModelLocator;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class FaceView extends View
	{
		private var asset		: MovieClip;
		private var face		: MovieClip;
		private var blink		: MovieClip;

		private var blinkTimer	: Timer;

		public function FaceView(sprite:Sprite=null)
		{
			super( null );

			setAsset( sprite as MovieClip );

			start();

			ModelLocator.getInstance().makeupModel.addEventListener( BlinkEvent.BLINK_FORCE_START,	blinkForceHandler );
			ModelLocator.getInstance().makeupModel.addEventListener( BlinkEvent.BLINK_FORCE_STOP,	blinkForceHandler );
		}

		/////////////////////////////////////////
		//	PUBLIC
		/////////////////////////////////////////

		public function setAsset ( a : MovieClip ):void
		{
			asset	= null;
			face	= null;
			blink	= null;

			asset	= a;
			face	= asset.getChildByName( "face" ) as MovieClip;
			blink	= asset.getChildByName( "blink" ) as MovieClip;
		}

		public function start ():void
		{
			hideBlink();
			initShowBlinkTimer();
		}

		public function stop ():void
		{
			hideBlink();
			killShowBlinkTimer();
			killHideBlinkTimer();
		}

		/////////////////////////////////////////
		//	NOT SO PUBLIC.
		/////////////////////////////////////////

		private function initShowBlinkTimer ():void
		{
			var blinkDelay : int;
			blinkDelay = Math.random() * 5000 + 1000;

			blinkTimer = new Timer( blinkDelay, 1 );
			blinkTimer.addEventListener( TimerEvent.TIMER_COMPLETE, showBlinkTimerHandler );
			blinkTimer.start();
		}

		private function killShowBlinkTimer ():void
		{
			if( blinkTimer )
			{
				blinkTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, showBlinkTimerHandler );
				blinkTimer.stop();
				blinkTimer = null;
			}
		}

		private function showBlinkTimerHandler ( e : TimerEvent ):void
		{
			killShowBlinkTimer();
			showBlink();
			initHideBlinkTimer();
		}

		private function initHideBlinkTimer ():void
		{
			var blinkDelay : int;
			blinkDelay = 150;

			blinkTimer = new Timer( blinkDelay, 1 );
			blinkTimer.addEventListener( TimerEvent.TIMER_COMPLETE, hideBlinkTimerHandler );
			blinkTimer.start();
		}

		private function killHideBlinkTimer ():void
		{
			if( blinkTimer )
			{
				blinkTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, hideBlinkTimerHandler );
				blinkTimer.stop();
				blinkTimer = null;
			}
		}

		private function hideBlinkTimerHandler ( e : TimerEvent ):void
		{
			killHideBlinkTimer();
			hideBlink();
			initShowBlinkTimer();
		}

		private function showBlink ():void
		{
			blink.visible = true;

			ModelLocator.getInstance().makeupModel.blinking = true;
		}

		private function hideBlink ():void
		{
			blink.visible = false;

			ModelLocator.getInstance().makeupModel.blinking = false;
		}

		private function blinkForceHandler ( e : BlinkEvent ):void
		{
			if( e.blinkForce )
			{
				killHideBlinkTimer();
				killShowBlinkTimer();
				showBlink();
			}
			else
			{
				killHideBlinkTimer();
				killShowBlinkTimer();
				hideBlink();
				initShowBlinkTimer();
			}
		}
	}
}