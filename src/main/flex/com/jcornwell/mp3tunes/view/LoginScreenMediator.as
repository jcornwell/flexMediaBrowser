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
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const NAME:String = "LoginScreenMediator";


    //----------------------------------------------------------
    //
    // Variables - Private
    //
    //----------------------------------------------------------

    private var configProxy:ConfigProxy;
    private var localeProxy:LocaleProxy;


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function LoginScreenMediator( viewComponent:LoginScreen )
    {
      super( NAME, viewComponent );
    }


    //----------------------------------------------------------
    //
    // Properties - Protected
    //
    //----------------------------------------------------------

    protected function get loginScreen():LoginScreen
    {
      return viewComponent as LoginScreen;
    }


    //----------------------------------------------------------
    //
    // Methods - Public
    //
    //----------------------------------------------------------

    //----------------------------------------------------------
    // Overrides
    //----------------------------------------------------------

    override public function onRegister():void
    {
      configProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
      localeProxy = facade.retrieveProxy( LocaleProxy.NAME ) as LocaleProxy;

      loginScreen.addEventListener( LoginScreen.CREATION_COMPLETE, handleCreationComplete );
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    //----------------------------------------------------------
    // Event Handlers
    //----------------------------------------------------------

    private function handleCreationComplete( evt:Event ):void
    {
      loginScreen.usernameText = localeProxy.getLocalizedText( LocaleKeyEnum.USER_NAME );
      loginScreen.passwordText = localeProxy.getLocalizedText( LocaleKeyEnum.PASSWORD );
      loginScreen.loginText = localeProxy.getLocalizedText( LocaleKeyEnum.LOGIN );
    }
  }
}