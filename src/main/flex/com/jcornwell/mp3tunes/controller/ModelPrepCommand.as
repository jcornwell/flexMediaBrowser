package com.jcornwell.mp3tunes.controller
{
	import com.jcornwell.mp3tunes.model.ConfigProxy;
	import com.jcornwell.mp3tunes.model.LocaleProxy;
	import com.jcornwell.mp3tunes.model.StartupMonitorProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
    /**
     * Create and register <code>Proxy</code>s with the <code>Model</code>.
     */
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