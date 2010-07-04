package com.jcornwell.mediabrowser.model
{
  import com.jcornwell.mediabrowser.model.business.LoadXMLDelegate;
  import com.jcornwell.mediabrowser.model.helpers.XmlResource;

  import mx.rpc.IResponder;

  import org.puremvc.as3.interfaces.IProxy;
  import org.puremvc.as3.patterns.proxy.Proxy;


  public class LocaleProxy extends Proxy implements IProxy, IResponder
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const NAME:String = "LocaleProxy";

    //----------------------------------------------------------
    // Notifications
    //----------------------------------------------------------

    public static const LOAD_SUCCESSFUL:String   = NAME + "loadSuccessful";
    public static const LOAD_FAILED:String     = NAME + "loadFailed";


    //----------------------------------------------------------
    // Messages
    //----------------------------------------------------------

    public static const ERROR_LOAD_FILE:String  = "Could Not Load the Config File!";


    //----------------------------------------------------------
    //
    // Variables - Private
    //
    //----------------------------------------------------------

    private var startupMonitorProxy:StartupMonitorProxy;


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function LocaleProxy ( data:Object = null )
    {
      super ( NAME, data );
    }


    //----------------------------------------------------------
    //
    // Methods - Public
    //
    //----------------------------------------------------------

    public function load():void
    {
      var configProxy:ConfigProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
      var language:String = configProxy.getValue('language');

      if ( language && language != "" )
      {
        var url:String = "assets/" + configProxy.getValue('language') + '.xml';

        var delegate : LoadXMLDelegate = new LoadXMLDelegate(this, url);
        delegate.load();
      }
      else
      {
        resourceLoaded();
      }
    }


    public function result( rpcEvent : Object ) : void
    {
      XmlResource.parse(data, rpcEvent.result);
      resourceLoaded();
    }


    public function fault( rpcEvent : Object ) : void
    {
      sendNotification( LocaleProxy.LOAD_FAILED, LocaleProxy.ERROR_LOAD_FILE );
    }


    public function getLocalizedText(key:String):String
    {
      return data[key.toLowerCase()];
    }


    //----------------------------------------------------------
    // Overrides
    //----------------------------------------------------------

    override public function onRegister():void
    {
      startupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
      startupMonitorProxy.addResource( LocaleProxy.NAME, true );

      setData( new Object() );
    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    private function resourceLoaded():void
    {
      startupMonitorProxy.resourceComplete( LocaleProxy.NAME );
      sendNotification( ConfigProxy.LOAD_SUCCESSFUL );
    }
  }
}