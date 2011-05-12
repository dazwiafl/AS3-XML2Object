package  {
	
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import basilbox.labs.XML2Obj;
	
	
	public class XML2ObjSwf extends MovieClip {
		
		
		public function XML2ObjSwf() {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, parseRegXml);
			xmlLoader.load(new URLRequest("reg.xml"));
		}
		
		private function parseRegXml(e:Event):void{
			var xml:XMLDocument = new XMLDocument();
			xml.ignoreWhite = true;
			xml.parseXML(e.currentTarget.data);
			var objXMLParser : XML2Obj = new XML2Obj(xml);
			var oXML:Object = objXMLParser.ParsedObject;
			trace("set breakpoint here");
		}		
	}	
}
