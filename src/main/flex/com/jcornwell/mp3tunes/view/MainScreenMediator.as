package com.jcornwell.mp3tunes.view
{
  import com.jcornwell.mp3tunes.model.ConfigProxy;
  import com.jcornwell.mp3tunes.model.LocaleProxy;
  import com.jcornwell.mp3tunes.model.enum.ConfigKeyEnum;
  import com.jcornwell.mp3tunes.model.enum.LocaleKeyEnum;
  import com.jcornwell.mp3tunes.view.components.MainScreen;

  import flash.events.Event;

  import org.puremvc.as3.interfaces.IMediator;
  import org.puremvc.as3.patterns.mediator.Mediator;


  public class MainScreenMediator extends Mediator implements IMediator
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const NAME:String = "MainScreenMediator";


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

    public function MainScreenMediator( viewComponent:MainScreen )
    {
      super( NAME, viewComponent );
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

      mainScreen.addEventListener( MainScreen.CREATION_COMPLETE, creationCompleteHandler );
    }


    //----------------------------------------------------------
    //
    // Methods - Protected
    //
    //----------------------------------------------------------

    protected function get mainScreen():MainScreen
    {
      return viewComponent as MainScreen;
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    //----------------------------------------------------------
    // Event Handlers
    //----------------------------------------------------------

    private function creationCompleteHandler( evt:Event ):void
    {
      mainScreen.welcomeText = localeProxy.getLocalizedText( LocaleKeyEnum.WELCOME );
    }
  }
}