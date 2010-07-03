package com.jcornwell.mp3tunes.view
{
  import com.jcornwell.mp3tunes.model.ConfigProxy;
  import com.jcornwell.mp3tunes.model.LocaleProxy;
  import com.jcornwell.mp3tunes.model.enum.LocaleKeyEnum;
  import com.jcornwell.mp3tunes.view.components.LoginScreen;

  import flash.events.Event;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.patterns.mediator.Mediator;


  public class LoginScreenMediator extends Mediator implements IMediator
  {
    public static const NAME:String = "LoginScreenMediator";

    private var configProxy:ConfigProxy;
    private var localeProxy:LocaleProxy;


    ////////////////////////////////////////////////////////////
    //
    // Constructor
    //
    ////////////////////////////////////////////////////////////

    public function LoginScreenMediator( viewComponent:LoginScreen )
    {
      super( NAME, viewComponent );
    }


    override public function onRegister():void
    {
      configProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
      localeProxy = facade.retrieveProxy( LocaleProxy.NAME ) as LocaleProxy;

      loginScreen.addEventListener( LoginScreen.CREATION_COMPLETE, handleCreationComplete );
    }


    protected function get loginScreen():LoginScreen
    {
      return viewComponent as LoginScreen;
    }


    /*********************************/
    /* events handler          */
    /*********************************/

    private function handleCreationComplete( evt:Event ):void
    {
      loginScreen.usernameText = localeProxy.getText( LocaleKeyEnum.USER_NAME );
      loginScreen.passwordText = localeProxy.getText( LocaleKeyEnum.PASSWORD );
      loginScreen.loginText = localeProxy.getText( LocaleKeyEnum.LOGIN );
    }
  }
}