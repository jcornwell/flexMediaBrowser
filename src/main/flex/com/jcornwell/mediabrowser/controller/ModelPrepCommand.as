package com.jcornwell.mediabrowser.controller
{
  import com.jcornwell.mediabrowser.model.ConfigProxy;
  import com.jcornwell.mediabrowser.model.LocaleProxy;
  import com.jcornwell.mediabrowser.model.StartupMonitorProxy;

  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.command.SimpleCommand;

  public class ModelPrepCommand extends SimpleCommand
  {
    override public function execute( note:INotification ) :void
    {
      facade.registerProxy(new StartupMonitorProxy());
      facade.registerProxy(new ConfigProxy());
      facade.registerProxy(new LocaleProxy());
    }
  }
}