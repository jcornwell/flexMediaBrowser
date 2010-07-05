package com.jcornwell.mediabrowser.model
{
  import com.jcornwell.mediabrowser.model.business.LoginDelegate;
  import com.jcornwell.mediabrowser.model.helpers.XmlResource;

  import mx.rpc.IResponder;

  import org.puremvc.as3.interfaces.IProxy;
  import org.puremvc.as3.patterns.proxy.Proxy;


  public class LoginProxy extends Proxy implements IProxy, IResponder
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const NAME:String = "LoginProxy";
    public static const SEPARATOR:String = "/";


    //----------------------------------------------------------
    // Notifications
    //----------------------------------------------------------

    public static const LOGIN_SUCCESSFUL:String = NAME + "loginSuccessful";
    public static const LOGIN_FAILED:String = NAME + "loginFailed";


    //----------------------------------------------------------
    // Messages
    //----------------------------------------------------------

    public static const ERROR_LOAD_FILE:String  = "Could Not Load the Config File!";


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function LoginProxy(data:Object = null)
    {
      super(NAME, data);
    }


    //----------------------------------------------------------
    //
    // Methods - Public
    //
    //----------------------------------------------------------

    public function login(username:String, password:String):void
    {
      var delegate : LoginDelegate = new LoginDelegate(this, username, password);
      delegate.execute();
    }


    public function result(rpcObject : Object): void
    {
      // TODO: store the session_id somewhere useful
      sendNotification(LoginProxy.LOGIN_SUCCESSFUL);
    }


    public function fault(rpcObject : Object): void
    {
      // TODO: do something useful with this error
      sendNotification(LoginProxy.LOGIN_FAILED);
    }


    //----------------------------------------------------------
    // Overrides
    //----------------------------------------------------------

    override public function onRegister():void
    {
      setData(new Object());
    }
  }
}