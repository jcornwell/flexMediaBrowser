package com.jcornwell.mp3tunes
{
	import com.jcornwell.mp3tunes.controller.ApplicationStartupCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
    /**
     * A concrete <code>Facade</code> for the <code>ApplicationSkeleton</code> application.
     * <P>
     * The main job of the <code>ApplicationFacade</code> is to act as a single 
     * place for mediators, proxies and commands to access and communicate
     * with each other without having to interact with the Model, View, and
     * Controller classes directly. All this capability it inherits from 
     * the PureMVC Facade class.</P>
     * 
     * <P>
     * This concrete Facade subclass is also a central place to define 
     * notification constants which will be shared among commands, proxies and
     * mediators, as well as initializing the controller with Command to 
     * Notification mappings.</P>
     */
    public class ApplicationFacade extends Facade
    {
        // Notification name constants
		// application
        public static const STARTUP:String 					= "startup";
        public static const SHUTDOWN:String 				= "shutdown";

		// command
        public static const COMMAND_STARTUP_MONITOR:String	= "StartupMonitorCommand";
		
		// view
		public static const VIEW_SPLASH_SCREEN:String		= "viewSplashScreen";
		public static const VIEW_MAIN_SCREEN:String			= "viewMainScreen";
		

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade 
		{
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController(); 
            registerCommand( STARTUP, ApplicationStartupCommand );
        }
		
		/**
		 * Start the application
		 */
		public function startup( app:Main ):void
		{
			sendNotification( STARTUP, app );
		}
		
    }
}