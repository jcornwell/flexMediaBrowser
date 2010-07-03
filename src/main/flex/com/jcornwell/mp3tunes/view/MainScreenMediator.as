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
	
    /**
     * A Mediator for interacting with the MainScreen component.
     */
    public class MainScreenMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = "MainScreenMediator";
        
		private var configProxy:ConfigProxy;
		private var localeProxy:LocaleProxy;
		
        /**
         * Constructor. 
         */
        public function MainScreenMediator( viewComponent:MainScreen ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
		}
			
        override public function onRegister():void
        {
			// retrieve the proxies
			configProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			localeProxy = facade.retrieveProxy( LocaleProxy.NAME ) as LocaleProxy;
			
			mainScreen.addEventListener( MainScreen.CREATION_COMPLETE, handleCreationComplete );
        }


        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Mediator class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return MainScreen the viewComponent cast to org.puremvc.as3.demos.flex.appskeleton.view.components.MainScreen
         */
		 
        protected function get mainScreen():MainScreen
		{
            return viewComponent as MainScreen;
        }
		
		/*********************************/
		/* events handler 				 */
		/*********************************/
		
		private function handleCreationComplete( evt:Event ):void
		{
			mainScreen.welcomeText = localeProxy.getText( LocaleKeyEnum.WELCOME );
		}
    }
}