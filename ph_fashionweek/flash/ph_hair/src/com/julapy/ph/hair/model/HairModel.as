package com.julapy.ph.hair.model
{
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;


	public class HairModel extends EventDispatcher
	{
		private var _appRect		: Rectangle	= new Rectangle( 0, 0, 600, 800 );

		public function HairModel()
		{
			//
		}

		/////////////////////////////////////
		//	APP SIZE.
		/////////////////////////////////////

		public function get appWidth ():int
		{
			return _appRect.width;
		}

		public function get appHeight ():int
		{
			return _appRect.height;
		}
	}
}