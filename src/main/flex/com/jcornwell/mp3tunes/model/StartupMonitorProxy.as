package com.jcornwell.mp3tunes.model
{
  import com.jcornwell.mp3tunes.model.vo.ResourceVO;

  import org.puremvc.as3.interfaces.IProxy;
  import org.puremvc.as3.patterns.proxy.Proxy;


  public class StartupMonitorProxy extends Proxy implements IProxy
  {
    public static const NAME:String = "StartupMonitorProxy";

    // Notifications constansts
    public static const LOADING_STEP:String        = NAME + "loadingStep";
    public static const LOADING_COMPLETE:String      = NAME + "loadingComplete";

    private var resourceList:Array;
    private var totalReources:int = 0;
    private var loadedReources:int = 0;


    public function StartupMonitorProxy ( data:Object = null )
    {
      super ( NAME, data );
      resourceList = new Array();
    }


    public function addResource( proxyName:String, blockChain:Boolean = false ):void
    {
      resourceList.push( new ResourceVO( proxyName, blockChain ) );
    }


    public function loadResources():void
    {
      for( var i:int = 0; i < resourceList.length; i++)
      {
        var r:ResourceVO = resourceList[i] as ResourceVO;
        if ( !r.loaded )
        {
          var proxy:* = facade.retrieveProxy( r.proxyName ) as Proxy;
          proxy.load();

          // check if the loading process must be stopped until the resource is loaded
          if ( r.blockChain )
          {
            break;
          }
        }
      }
    }

    /**
     * The resource is loaded, update the state anche check if the loading process is completed
     *
     * @param name proxy name
     */
    public function resourceComplete( proxyName:String ):void
    {
      for( var i:int = 0; i < resourceList.length; i++)
      {
        var r:ResourceVO = resourceList[i] as ResourceVO;
        if ( r.proxyName == proxyName )
        {
          r.loaded = true;
          loadedReources++;
          // send the notification for update the progress bar
          sendNotification( StartupMonitorProxy.LOADING_STEP, (loadedReources * 100) / resourceList.length );
          // check if the process is completed
          // if is not completed and the resources have blocked the process chain
          // continue to read the other resources
          if ( !checkResources() && r.blockChain )
          {
            loadResources();
          }
          break;
        }
      }

    }

    /**
     * Check if the loading process is completed
     *
     * @return boolean process is completed
     */
    private function checkResources():Boolean
    {
      for( var i:int = 0; i < resourceList.length; i++)
      {
        var r:ResourceVO = resourceList[i] as ResourceVO;
        if ( !r.loaded )
        {
          return false;
        }
      }
      sendNotification( StartupMonitorProxy.LOADING_COMPLETE );
      return true;
    }
  }
}