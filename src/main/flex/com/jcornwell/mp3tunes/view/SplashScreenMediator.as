package com.jcornwell.mp3tunes.view
{
  import com.jcornwell.mp3tunes.ApplicationFacade;
  import com.jcornwell.mp3tunes.model.ConfigProxy;
  import com.jcornwell.mp3tunes.model.LocaleProxy;
  import com.jcornwell.mp3tunes.model.StartupMonitorProxy;
  import com.jcornwell.mp3tunes.view.components.SplashScreen;

  import flash.events.Event;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.mediator.Mediator;


  public class SplashScreenMediator extends Mediator implements IMediator
  {
    public static const NAME:String = "SplashScreenMediator";

    /**
     * Constructor.
     */
    public function SplashScreenMediator( viewComponent:SplashScreen )
    {
      super( NAME, viewComponent );

      splashScreen.addEventListener(SplashScreen.EFFECT_END, endEffectHandler);
    }


    override public function listNotificationInterests():Array
    {
      return [
        StartupMonitorProxy.LOADING_STEP,
        StartupMonitorProxy.LOADING_COMPLETE,
        ConfigProxy.LOAD_FAILED,
        LocaleProxy.LOAD_FAILED
        ];
    }


    override public function handleNotification( note:INotification ):void
    {
      switch ( note.getName() )
      {
        case StartupMonitorProxy.LOADING_STEP:
          this.splashScreen.pb.setProgress( note.getBody() as int, 100);
          break;

        case StartupMonitorProxy.LOADING_COMPLETE:
          this.sendNotification( ApplicationFacade.VIEW_LOGIN_SCREEN );
          break;

        case ConfigProxy.LOAD_FAILED:
        case LocaleProxy.LOAD_FAILED:
          this.splashScreen.errorText.text = note.getBody() as String;
          this.splashScreen.errorBox.visible = true;
          break;
      }
    }


    protected function get splashScreen():SplashScreen
    {
      return viewComponent as SplashScreen;
    }


    private function endEffectHandler(event:Event=null):void
    {
      var startupMonitorProxy:StartupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
      startupMonitorProxy.loadResources();
    }
  }
}
