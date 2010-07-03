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
    public static const NAME:String = "MainScreenMediator";

    private var configProxy:ConfigProxy;
    private var localeProxy:LocaleProxy;


    ////////////////////////////////////////////////////////////
    //
    // Constructor
    //
    ////////////////////////////////////////////////////////////

    public function MainScreenMediator( viewComponent:MainScreen )
    {
      super( NAME, viewComponent );
    }


    override public function onRegister():void
    {
      configProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
      localeProxy = facade.retrieveProxy( LocaleProxy.NAME ) as LocaleProxy;

      mainScreen.addEventListener( MainScreen.CREATION_COMPLETE, handleCreationComplete );
    }


    protected function get mainScreen():MainScreen
    {
      return viewComponent as MainScreen;
    }


    /*********************************/
    /* events handler          */
    /*********************************/

    private function handleCreationComplete( evt:Event ):void
    {
      mainScreen.welcomeText = localeProxy.getText( LocaleKeyEnum.WELCOME );
    }
  }
}