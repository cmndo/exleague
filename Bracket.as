package  {
	
	import flash.display.MovieClip;
	import com.exleague.streamcontrol.XMLAdapter;
	import com.exleague.ExEvent;
	import com.exleague.streamcontrol.FieldProxy;
	
	
	public class Bracket extends MovieClip {
		
		private var xmlAdapter:XMLAdapter;
		private var fieldProxy:FieldProxy;
		
		public function Bracket() {
			
			// construct our adapter
			xmlAdapter = new XMLAdapter(sourceURLInput.text || "streamcontrol.xml");
			
			// listen for adapter events			
			xmlAdapter.addEventListener(ExEvent.ERROR, reportError);
			xmlAdapter.addEventListener(ExEvent.UPDATED, updateBrackets);
			
			
			//construct our proxy
			fieldProxy = new FieldProxy({

				wm1p1:{target:wm1p1.playerName},
				wm1p2:{target:wm1p2.playerName},
				wm2p1:{target:wm2p1.playerName},
				wm2p2:{target:wm2p2.playerName},

				wfp1:{target:wfp1.playerName},
				wfp2:{target:wfp2.playerName},
				lsp1:{target:lsp1.playerName},
				lsp2:{target:lsp2.playerName},

				gfp1:{target:gfp1.playerName},
				gfp2:{target:gfp2.playerName}
				
			});
			
		}
		
		//private
		private function reportError(e:ExEvent):void {
			trace("There was a problem with XMLAdapter.");
		}
		
		private function updateBrackets(e:ExEvent):void {
			//when the xml has been updated, update the fieldProxy
			fieldProxy.update(e.result);
			trace(e.result);
		}
		
		
	}
	
}
