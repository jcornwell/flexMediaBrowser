package com.jcornwell.mp3tunes.view
{
  import com.jcornwell.mp3tunes.ApplicationFacade;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.mediator.Mediator;


  public class ApplicationMediator extends Mediator implements IMediator
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const NAME:String = "ApplicationMediator";


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function ApplicationMediator( viewComponent:Main )
    {
      super( NAME, viewComponent );
    }


    //----------------------------------------------------------
    //
    // Properties - Protected
    //
    //----------------------------------------------------------

    protected function get app():Main
    {
      return viewComponent as Main
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
      facade.registerMediator( new SplashScreenMediator( app.splashScreen ) );
      facade.registerMediator( new MainScreenMediator( app.mainScreen ) );
      facade.registerMediator( new LoginScreenMediator( app.loginScreen ) );
    }


    override public function listNotificationInterests():Array
    {
      return [
      ApplicationFacade.VIEW_SPLASH_SCREEN,
      ApplicationFacade.VIEW_LOGIN_SCREEN,
      ApplicationFacade.VIEW_MAIN_SCREEN
      ];
    }


    override public function handleNotification( note:INotification ):void
    {
      switch ( note.getName() )
      {
        case ApplicationFacade.VIEW_SPLASH_SCREEN:
          app.vwStack.selectedChild = app.splashScreen;
          break;

        case ApplicationFacade.VIEW_LOGIN_SCREEN:
          app.vwStack.selectedChild = app.loginScreen;
          break;

        case ApplicationFacade.VIEW_MAIN_SCREEN:
          app.vwStack.selectedChild = app.mainScreen;
          break;
       }
    }
  }
}