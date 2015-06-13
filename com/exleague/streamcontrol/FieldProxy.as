/*

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
