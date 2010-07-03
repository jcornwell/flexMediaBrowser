package com.jcornwell.mp3tunes.model
{
  import com.jcornwell.mp3tunes.model.business.LoadXMLDelegate;
  import com.jcornwell.mp3tunes.model.helpers.XmlResource;

  import mx.rpc.IResponder;

  import org.puremvc.as3.interfaces.IProxy;
  import org.puremvc.as3.patterns.proxy.Proxy;


  public class ConfigProxy extends Proxy implements IProxy, IResponder
  {
    public static const NAME:String = "ConfigProxy";                  // Proxy name
    public static const SEPARATOR:String = "/";

    // Notifications constansts
    public static const LOAD_SUCCESSFUL:String   = NAME + "loadSuccessful";        // Successful notification
    public static const LOAD_FAILED:String     = NAME + "loadFailed";          // Failed notification

    // Messages
    public static const ERROR_LOAD_FILE:String  = "Could Not Load the Config File!";  // Error message

    private var startupMonitorProxy:StartupMonitorProxy;                // StartupMonitorProxy instance


    public function ConfigProxy ( data:Object = null )
    {
      super ( NAME, data );
    }


    override public function onRegister():void
    {
      startupMonitorProxy = facade.retrieveProxy( StartupMonitorProxy.NAME ) as StartupMonitorProxy;
      startupMonitorProxy.addResource( ConfigProxy.NAME, true );

      setData( new Object() );
    }


    public function load():void
    {
      var delegate : LoadXMLDelegate = new LoadXMLDelegate(this, 'assets/config.xml');
      delegate.load();
    }


    public function result( rpcEvent : Object ) : void
    {
      XmlResource.parse(data, rpcEvent.result);
      startupMonitorProxy.resourceComplete( ConfigProxy.NAME );
      sendNotification( ConfigProxy.LOAD_SUCCESSFUL );
    }


    public function fault( rpcEvent : Object ) : void
    {
      sendNotification( ConfigProxy.LOAD_FAILED, ConfigProxy.ERROR_LOAD_FILE );
    }


    public function getValue(key:String):String
    {
      return data[key.toLowerCase()];
    }


    public function getNumber(key:String):Number
    {
      return Number( data[key.toLowerCase()] );
    }


    public function getBoolean(key:String):Boolean
    {
      return data[key.toLowerCase()] ? data[key.toLowerCase()].toLowerCase() == "true" : false;
    }


    public function setDefaultValue( key:String, value:Object ):void
    {
      if ( !data[key.toLowerCase()] )
      {
        data[key.toLowerCase()] = value;
      }
    }
  }
}