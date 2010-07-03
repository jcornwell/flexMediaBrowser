package com.jcornwell.mp3tunes
{
  import com.jcornwell.mp3tunes.controller.ApplicationStartupCommand;

  import org.puremvc.as3.patterns.facade.Facade;


  public class ApplicationFacade extends Facade
  {
    public static const STARTUP:String = "startup";
    public static const SHUTDOWN:String = "shutdown";

    public static const COMMAND_STARTUP_MONITOR:String = "StartupMonitorCommand";

    public static const VIEW_SPLASH_SCREEN:String = "viewSplashScreen";
    public static const VIEW_LOGIN_SCREEN:String = "viewLoginScreen";
    public static const VIEW_MAIN_SCREEN:String = "viewMainScreen";


    public static function getInstance() : ApplicationFacade
    {
      if ( instance == null ) instance = new ApplicationFacade( );
      return instance as ApplicationFacade;
    }


    override protected function initializeController( ) : void
    {
      super.initializeController();
      registerCommand( STARTUP, ApplicationStartupCommand );
    }


    public function startup( app:Main ):void
    {
      sendNotification( STARTUP, app );
    }
  }
}