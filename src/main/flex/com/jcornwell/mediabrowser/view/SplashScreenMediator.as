package com.jcornwell.mediabrowser.view
{
  import com.jcornwell.mediabrowser.ApplicationFacade;
  import com.jcornwell.mediabrowser.model.ConfigProxy;
  import com.jcornwell.mediabrowser.model.LocaleProxy;
  import com.jcornwell.mediabrowser.model.StartupMonitorProxy;
  import com.jcornwell.mediabrowser.view.components.SplashScreen;

  import flash.events.Event;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.mediator.Mediator;


  public class SplashScreenMediator extends Mediator implements IMediator
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------
    
    public static const NAME:String = "SplashScreenMediator";

    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function SplashScreenMediator(viewComponent:SplashScreen)
    {
      super(NAME, viewComponent);

      splashScreen.addEventListener(SplashScreen.EFFECT_END, endEffectHandler);
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
        StartupMonitorProxy.LOADING_STEP,
        StartupMonitorProxy.LOADING_COMPLETE,
        ConfigProxy.LOAD_FAILED,
        LocaleProxy.LOAD_FAILED
        ];
    }


    override public function handleNotification(note:INotification):void
    {
      switch (note.getName())
      {
        case StartupMonitorProxy.LOADING_STEP:
          this.splashScreen.pb.setProgress(note.getBody() as int, 100);
          break;

        case StartupMonitorProxy.LOADING_COMPLETE:
          this.sendNotification(ApplicationFacade.VIEW_LOGIN_SCREEN);
          break;

        case ConfigProxy.LOAD_FAILED:
        case LocaleProxy.LOAD_FAILED:
          this.splashScreen.errorText.text = note.getBody() as String;
          this.splashScreen.errorBox.visible = true;
          break;
      }
    }


    //----------------------------------------------------------
    //
    // Methods - Protected
    //
    //----------------------------------------------------------

    protected function get splashScreen():SplashScreen
    {
      return viewComponent as SplashScreen;
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    //----------------------------------------------------------
    // Event Handlers
    //----------------------------------------------------------

    private function endEffectHandler(event:Event=null):void
    {
      var startupMonitorProxy:StartupMonitorProxy = facade.retrieveProxy(StartupMonitorProxy.NAME) as StartupMonitorProxy;
      startupMonitorProxy.loadResources();
    }
  }
}
