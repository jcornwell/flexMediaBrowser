package com.jcornwell.mediabrowser.controller
{
  import com.jcornwell.mediabrowser.ApplicationFacade;
  import com.jcornwell.mediabrowser.view.ApplicationMediator;

  import org.puremvc.as3.interfaces.INotification;
  import org.puremvc.as3.patterns.command.SimpleCommand;


  public class ViewPrepCommand extends SimpleCommand
  {
    override public function execute( note:INotification ) :void
    {
      facade.registerMediator( new ApplicationMediator( note.getBody() as Main ) );
      sendNotification( ApplicationFacade.VIEW_SPLASH_SCREEN );
    }
  }
}
