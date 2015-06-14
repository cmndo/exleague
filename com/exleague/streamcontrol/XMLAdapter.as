/*
Copyright (c) 2015 Aaron Sherrill - @codecommando

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/﻿
/*
	This file just loads the same xml document over and over again. In my ideal world this would be handled much more
	gracefully with a socket server. But since this seems to work, I don't know if it makes much sense to reinvent the wheel
	just yet.
*/
﻿package  com.exleague.streamcontrol{

	import flash.events.*;
	import com.exleague.ExEvent;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.xml.XMLDocument;
	import flash.utils.Timer;


	public class XMLAdapter extends EventDispatcher {

		private var streamData:XML;
		private var src:String;
		private var timestampOld:Number;
		private var timestamp:Number;
		public var animating:Boolean = false;


		public function XMLAdapter(_src:String = "streamcontrol.xml")
		{
			// constructor code
			src = _src;

			// Set up poller.
			var poller:Timer = new Timer(500);
			poller.addEventListener(TimerEvent.TIMER, loadData);
			poller.start();

		}

		public function loadData (e:TimerEvent):void
		{
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, onComplete);
			xmlLoader.addEventListener(ErrorEvent.ERROR, onError);
			xmlLoader.load(new URLRequest(src));
		}

		//private methods
		private function onComplete (e:Event):void
		{
			streamData = new XML(e.target.data);
			timestampOld = timestamp;
			timestamp = streamData.elements("timestamp");

			if (timestamp != timestampOld && !animating) {
				dispatchEvent(new ExEvent(ExEvent.UPDATED, streamData));
			}
		}

		private function onError(event:ErrorEvent):void {
			dispatchEvent(new ExEvent(ExEvent.ERROR, event.type));
		}

	}

}
