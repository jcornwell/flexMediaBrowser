package com.jcornwell.mediabrowser.model.business
{
  import mx.rpc.AsyncToken;
  import mx.rpc.IResponder;
  import mx.rpc.http.HTTPService;

  public class LoadXMLDelegate
  {
    //----------------------------------------------------------
    //
    // Variables - Private
    //
    //----------------------------------------------------------

    private var responder : IResponder;
    private var service : HTTPService;


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function LoadXMLDelegate(responder : IResponder, url:String)
    {
      service = new HTTPService();
      service.resultFormat = 'xml';
      service.url = url;

      this.responder = responder;
    }


    //----------------------------------------------------------
    //
    // Methods - Public
    //
    //----------------------------------------------------------

    public function load(): void
    {
      var token:AsyncToken = service.send();
      token.addResponder(responder);
    }
  }
}