package  com.exleague.streamcontrol{
	
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
