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
*/﻿﻿
/*
	Piece of cake really.
	This file is commented. you should be able to figure out what it does.
	To me a FieldProxy is a middleman between when a text field changes, and when that change is reflected.
	This is needed in case you want to animate the current property out, and then animate the new property in.
	So that's what this proxy does. It loops through the nodes that you are tracking and checks to see if the value
	has changed from what it was last time.

	If it changed then we have 2 conditions to take into consideration. The first is to simply replace the value of
	the text field. This defeats the purpose of the proxy so lets discuss the second one.

	All it does is check if there is a "changed" property. If it detects one it calls that function and passes the
	new value to the callback. Read for yourself.

*/
package  com.exleague.streamcontrol{
	import flash.xml.XMLDocument;

	public class FieldProxy {

		private var references:Object;

		public function FieldProxy(_references:Object) {
			// store our references
			references = _references;
			
		}
		public function update(xmlObj:XML):void {
			//loop through references. Check to see if their value has changed
			var tmpValue:*;
			for(var element in references){
				tmpValue = xmlObj.elements(element);

				if(references[element].target.text != tmpValue){

					//if there's a callback, send it the information about the change but take no action.
					if(references[element].hasOwnProperty("changed")){

						references[element].changed(tmpValue);

					}else{

						//the more simple process is to simply make the change ourselves here.
						references[element].target.text = tmpValue;

					}
				}
			}
		}

	}

}
