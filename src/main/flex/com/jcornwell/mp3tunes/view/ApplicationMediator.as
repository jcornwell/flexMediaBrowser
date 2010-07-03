package com.jcornwell.mp3tunes.view
{
  import com.jcornwell.mp3tunes.ApplicationFacade;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.mediator.Mediator;

  /**
   * A Mediator for interacting with the top level Application.
   *
   * <P>
   * In addition to the ordinary responsibilities of a mediator
   * the MXML application (in this case) built all the view components
   * and so has a direct reference to them internally. Therefore
   * we create and register the mediators for each view component
   * with an associated mediator here.</P>
   *
   * <P>
   * Then, ongoing responsibilities are:
   * <UL>
   * <LI>listening for events from the viewComponent (the application)</LI>
   * <LI>sending notifications on behalf of or as a result of these
   * events or other notifications.</LI>
   * <LI>direct manipulating of the viewComponent by method invocation
   * or property setting</LI>
   * </UL>
   */
  public class ApplicationMediator extends Mediator implements IMediator
  {
    public static const NAME:String = "ApplicationMediator";


    public function ApplicationMediator( viewComponent:Main )
    {
      super( NAME, viewComponent );
    }


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


    protected function get app():Main
    {
      return viewComponent as Main
    }
  }
}