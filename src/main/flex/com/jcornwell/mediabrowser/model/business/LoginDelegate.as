package com.jcornwell.mediabrowser.model.business
{
  import com.jcornwell.mediabrowser.model.enum.LoginResultStatusEnum;
  import com.jcornwell.mediabrowser.model.helpers.JSONHelper;
  import com.jcornwell.mediabrowser.model.helpers.Mp3TunesAPIHelper;
  import com.jcornwell.mediabrowser.model.vo.LoginResultVO;

  import flash.events.Event;
  import flash.events.HTTPStatusEvent;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  import mx.rpc.IResponder;

  public class LoginDelegate
  {
    //----------------------------------------------------------
    //
    // Variables - Private
    //
    //----------------------------------------------------------

    private var responder:IResponder;
    private var loader:URLLoader;
    private var url:String;


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function LoginDelegate(responder:IResponder, username:String, password:String)
    {
      url = Mp3TunesAPIHelper.getLoginEndpoint(username, password);
      loader = new URLLoader();
      this.responder = responder;
    }


    //----------------------------------------------------------
    //
    // Methods - Public
    //
    //----------------------------------------------------------

    public function execute(): void
    {
      loader.addEventListener(Event.COMPLETE, loader_completeHandler);
      loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, loader_statusHandler);
      loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
      loader.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
      loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
      loader.load(new URLRequest(url));
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    //----------------------------------------------------------
    // Event Handlers
    //----------------------------------------------------------

    private function loader_completeHandler(evt:Event): void
    {
      var loginResultVO:Object = JSONHelper.decodeToFlexClass(LoginResultVO, loader.data) as LoginResultVO;

      if (loginResultVO && loginResultVO.status == LoginResultStatusEnum.STATUS_SUCCESS)
      {
        this.responder.result(loginResultVO);
      }
      else
      {
        this.responder.fault(loginResultVO);
      }
    }


    private function loader_statusHandler(evt:HTTPStatusEvent): void
    {
      trace ("LoginDelgate", "loader_statusHandler", evt.status);
    }


    private function loader_errorHandler(evt:IOErrorEvent): void
    {
      trace ("LoginDelgate", "loader_errorHandler", evt.text);
    }


    private function loader_progressHandler(evt:ProgressEvent): void
    {
      trace ("LoginDelgate", "loader_progressHandler", evt.bytesLoaded, evt.bytesTotal);
    }


    private function loader_securityErrorHandler(evt:SecurityErrorEvent): void
    {
      trace ("LoginDelgate", "loader_securityErrorHandler", evt.text);
    }
  }
}