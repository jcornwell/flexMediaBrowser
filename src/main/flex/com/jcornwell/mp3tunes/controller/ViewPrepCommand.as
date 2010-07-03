package com.jcornwell.mp3tunes.controller
{
	import com.jcornwell.mp3tunes.ApplicationFacade;
	import com.jcornwell.mp3tunes.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
    /**
     * Prepare the View for use.
     * 
     * <P>
     * The <code>Notification</code> was sent by the <code>Application</code>,
     * and a reference to that view component was passed on the note body.
     * The <code>ApplicationMediator</code> will be created and registered using this
     * reference. The <code>ApplicationMediator</code> will then register 
     * all the <code>Mediator</code>s for the components it created.</P>
     * 
     */
    public class ViewPrepCommand extends SimpleCommand
    {
        override public function execute( note:INotification ) :void    
		{
            // Register the ApplicationMediator
            facade.registerMediator( new ApplicationMediator( note.getBody() as Main ) );
			
			// send the notification for show the Splash Screen
			sendNotification( ApplicationFacade.VIEW_SPLASH_SCREEN );
        }
    }
}
