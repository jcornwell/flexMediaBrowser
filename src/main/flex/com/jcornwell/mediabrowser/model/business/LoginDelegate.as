package com.jcornwell.mediabrowser.model.business
{
  import com.jcornwell.mediabrowser.model.enum.LoginResultStatusEnum;
  import com.jcornwell.mediabrowser.model.helpers.JSONHelper;
  import com.jcornwell.mediabrowser.model.helpers.Mp3TunesAPIHelper;
  import com.jcornwell.mediabrowser.model.vo.LoginResultVO;

  import flash.events.Event;
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
      // TODO: listen for erros from the loader
      loader.load(new URLRequest(url));
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
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
  }
}