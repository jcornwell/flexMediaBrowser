package com.jcornwell.mp3tunes.model.business
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class LoadXMLDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function LoadXMLDelegate( responder : IResponder, url:String) 
		{
			// constructor will store a reference to the service we're going to call
			service = new HTTPService();
			service.resultFormat = 'xml';
			service.url = url;
			
			// and store a reference to the proxy that created this delegate
			this.responder = responder;
		}

		public function load() : void 
		{
			// call the service
			var token:AsyncToken = service.send();
			// notify this responder when the service call completes
			token.addResponder( responder );
		}
	}
}