package com.jcornwell.mp3tunes.controller
{
  import com.jcornwell.mp3tunes.model.ConfigProxy;

  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.command.SimpleCommand;


  public class SetDefaultConfigValuesCommand extends SimpleCommand
  {
    override public function execute( note:INotification ) :void
    {
      var configProxy:ConfigProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
      configProxy.setDefaultValue( "language", "en" );
      configProxy.setDefaultValue( "testDefaultValue", "This isn't defined in config.xml but in SetDefaultConfigValuesCommand" );
    }
  }
}