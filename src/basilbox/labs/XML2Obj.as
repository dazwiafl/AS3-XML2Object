/**
 *
 * Copyright 2011 Basilbox GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 */
 
 /**
 * Converts XMLDocument to recursive Object.
 *
 * @author Anton Kahr ak at basilbox dot com
 */
  package  basilbox.labs {
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	public class XML2Obj {
		/**
		* The resulting Object of the XMLDocument.
		*/
		private var __parsedObject : Object = null;
		
		/**
		* Create a new XML2Obj with the given XMLDocument.
		*
		* @param XMLDocument the loaded xml-Data 
		* irgnoreWhite = true, recommended
		*/
		public function XML2Obj(_xml:XMLDocument) {
			__parsedObject = addXMLTree(_xml.firstChild);
		}

		/**
   		* Getter Function of the parsed Object.
	   	*
	   	* @return Object parsed Object
	   	*/
		public function get ParsedObject():Object{ return __parsedObject; }
		
		/**
		* Recursive function returns Object of XMLNode.
	   	*
		*
	   	* @private
		*
		* @param XMLNode xn A XMLNode
	   	* @return Object 
	   	*/
		private function addXMLTree(xn:XMLNode):Object{
			var obj:Object = new Object();
			if(xn.childNodes.length != 0){
				doAttributes(xn, obj);
				for(var i:int = 0; i < xn.childNodes.length; i++){
					var xn1:XMLNode = xn.childNodes[i];

					if(xn1.nodeName != null){
						if(!obj[xn1.nodeName])
							obj[xn1.nodeName] = {};
						obj[xn1.nodeName] = addXMLTree(xn1);
						if(!obj is String)
							obj[xn1.nodeName].nodeValue = xn1.nodeValue == null ? "" : xn1.nodeValue;
					}else{
						var isEmpty:Boolean = true;
						for (var n:* in obj) { isEmpty = false; break; }
						if(isEmpty)
							obj = xn1.nodeValue == null ? "" : xn1.nodeValue;
						else
							obj.nodeValue = xn1.nodeValue == null ? "" : xn1.nodeValue;
					}
				}
			}
			else{
				doAttributes(xn,obj);
				obj.nodeValue = xn.nodeValue == null ? "" : xn.nodeValue;
			}
			return obj;
		}
		
		/**
   		* Get all attributes of a XMLNode.
		*
	   	* @private
		*
		* @param XMLNode xn A XMLNode
		* @param Object obj The Object which gets filled.
		*
		* @see addXMLTree
	   	*/
		private function doAttributes(xn:XMLNode, obj:Object):void{
			for(var k:* in xn.attributes){
				obj[k] = xn.attributes[k];
			}
		}

	}
	
}
