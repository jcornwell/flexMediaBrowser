package com.jcornwell.mediabrowser.view
{
  import com.jcornwell.mediabrowser.model.ConfigProxy;
  import com.jcornwell.mediabrowser.model.LocaleProxy;
  import com.jcornwell.mediabrowser.model.enum.ConfigKeyEnum;
  import com.jcornwell.mediabrowser.model.enum.LocaleKeyEnum;
  import com.jcornwell.mediabrowser.view.components.MainScreen;

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

    public function MainScreenMediator(viewComponent:MainScreen)
    {
      super(NAME, viewComponent);
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
      configProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
      localeProxy = facade.retrieveProxy(LocaleProxy.NAME) as LocaleProxy;

      mainScreen.addEventListener(MainScreen.CREATION_COMPLETE, creationCompleteHandler);
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

    private function creationCompleteHandler(evt:Event):void
    {
      mainScreen.albumText = localeProxy.getLocalizedText(LocaleKeyEnum.ALBUM);
      mainScreen.artistText = localeProxy.getLocalizedText(LocaleKeyEnum.ARTIST);
      mainScreen.playlistsText = localeProxy.getLocalizedText(LocaleKeyEnum.PLAYLISTS);
    }
  }
}