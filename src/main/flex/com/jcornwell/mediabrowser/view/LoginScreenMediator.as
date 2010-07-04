package com.jcornwell.mediabrowser.view
{
  import com.jcornwell.mediabrowser.ApplicationFacade;
  import com.jcornwell.mediabrowser.model.LocaleProxy;
  import com.jcornwell.mediabrowser.model.LoginProxy;
  import com.jcornwell.mediabrowser.model.enum.LocaleKeyEnum;
  import com.jcornwell.mediabrowser.view.components.LoginScreen;

  import flash.events.Event;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.interfaces.INotification;
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

    private var localeProxy:LocaleProxy;
    private var loginProxy:LoginProxy;


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function LoginScreenMediator(viewComponent:LoginScreen)
    {
      super(NAME, viewComponent);
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

    override public function listNotificationInterests():Array
    {
      return [
        LoginProxy.LOGIN_SUCCESSFUL,
        LoginProxy.LOGIN_FAILED
        ];
    }


    override public function handleNotification(note:INotification):void
    {
      switch (note.getName())
      {
        case LoginProxy.LOGIN_SUCCESSFUL:
          this.sendNotification(ApplicationFacade.VIEW_MAIN_SCREEN);
          break;

        case LoginProxy.LOGIN_FAILED:
          // TODO: show error message to user
          break;
      }
    }


    override public function onRegister():void
    {
      localeProxy = facade.retrieveProxy(LocaleProxy.NAME) as LocaleProxy;
      loginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;

      loginScreen.addEventListener(LoginScreen.CREATION_COMPLETE, creationCompleteHandler);
      loginScreen.addEventListener(LoginScreen.LOGIN_ATTEMPT, loginAttemptHandler);
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    //----------------------------------------------------------
    // Event Handlers
    //----------------------------------------------------------

    private function creationCompleteHandler(evt:Event):void
    {
      loginScreen.usernameText = localeProxy.getLocalizedText(LocaleKeyEnum.USER_NAME);
      loginScreen.passwordText = localeProxy.getLocalizedText(LocaleKeyEnum.PASSWORD);
      loginScreen.loginText = localeProxy.getLocalizedText(LocaleKeyEnum.LOGIN);
    }


    private function loginAttemptHandler(evt:Event):void
    {
      loginProxy.login(loginScreen.usernameTextInput.text, loginScreen.passwordTextInput.text);
    }
  }
}