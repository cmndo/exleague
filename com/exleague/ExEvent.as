package com.exleague {

	import flash.events.Event;
	
	public class ExEvent extends Event
	{
		public static const COMPLETE:String = "COMPLETE";
		public static const UPDATED:String = "UPDATED";
		public static const ERROR:String = "ERROR";
		
		
		public var result:*;

		public function ExEvent(type:String, result:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.result = result;
		}

		// always create a clone() method for events in case you want to redispatch them.
		public override function clone():Event
		{
			return new ExEvent(type, result, bubbles, cancelable);
		}
	}
}