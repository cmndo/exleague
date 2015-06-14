p/*
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
package  com.exleague.view {

	import flash.display.MovieClip;
	import com.exleague.streamcontrol.XMLAdapter;
	import com.exleague.ExEvent;
	import com.exleague.streamcontrol.FieldProxy;


	public class LoserBracket extends MovieClip {

		private var xmlAdapter:XMLAdapter;
		private var fieldProxy:FieldProxy;

		public function LoserBracket() {

			// construct our adapter - There's an input field on the stage currently called sourceURLInput.
			// but if you leave it blank, you'll load up the default file for streamcontrol.
			xmlAdapter = new XMLAdapter(sourceURLInput.text || "streamcontrol.xml");

			// listen for adapter events
			xmlAdapter.addEventListener(ExEvent.ERROR, reportError);
			xmlAdapter.addEventListener(ExEvent.UPDATED, updateUI);


			/*
				construct our proxy and pass in an object with the xml node name
				and the text field that it updaes.

				There are two options for this. The simplest way is to give the object the name of the xml node name
				you want to listen to and equate that to an object with 1 property named "target". When that node value changes
				it will update the text value of the text field automatically.

				The second way is very similar except that you also include a second property called "changed" that fires a
				cabllback once the xml node value changes. This doesn't automatically update the text value, but rather passes
				the new value to the callback so that you can update it on your own when you're done animating.

				Author's Note
				This is where the fun happens. Construct animations of all kinds and trigger them to run when the property changes.


			*/
			fieldProxy = new FieldProxy({
				wm1p1:{
					target:wm1p1.playerName
					changed: function (newValue){
						w1p1.playerName.text = newValue;
					}
				},
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

		//I haven't run into any errors, but in case edits require error reporting, it's here.
		private function reportError(e:ExEvent):void {
			trace("There was a problem with XMLAdapter.");
		}

		private function updateUI(e:ExEvent):void {
			//when the xml has been updated, run the update method in com.exleague.streamcontrol.FieldProxy
			// if you're reading these comments to understand how my code works, you should jump in there.
			fieldProxy.update(e.result);
		}


	}

}

}
