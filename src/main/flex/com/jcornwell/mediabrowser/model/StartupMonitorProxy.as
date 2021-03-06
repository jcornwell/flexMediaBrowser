package com.jcornwell.mediabrowser.model
{
  import com.jcornwell.mediabrowser.model.vo.ResourceVO;

  import org.puremvc.as3.interfaces.IProxy;
  import org.puremvc.as3.patterns.proxy.Proxy;


  public class StartupMonitorProxy extends Proxy implements IProxy
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const NAME:String = "StartupMonitorProxy";


    //----------------------------------------------------------
    // Notifications
    //----------------------------------------------------------

    public static const LOADING_STEP:String = NAME + "loadingStep";
    public static const LOADING_COMPLETE:String = NAME + "loadingComplete";


    //----------------------------------------------------------
    //
    // Variables - Private
    //
    //----------------------------------------------------------

    private var resourceList:Array;
    private var totalReources:int = 0;
    private var loadedReources:int = 0;


    //----------------------------------------------------------
    //
    // Constructor
    //
    //----------------------------------------------------------

    public function StartupMonitorProxy(data:Object = null)
    {
      super(NAME, data);
      resourceList = new Array();
    }


    //----------------------------------------------------------
    //
    // Methods - Public
    //
    //----------------------------------------------------------

    public function addResource(proxyName:String, blockChain:Boolean = false):void
    {
      resourceList.push(new ResourceVO(proxyName, blockChain));
    }


    public function loadResources():void
    {
      for(var i:int = 0; i < resourceList.length; i++)
      {
        var r:ResourceVO = resourceList[i] as ResourceVO;
        if (!r.loaded)
        {
          var proxy:* = facade.retrieveProxy(r.proxyName) as Proxy;
          proxy.load();

          // check if the loading process must be stopped until the resource is loaded
          if (r.blockChain)
          {
            break;
          }
        }
      }
    }


    public function resourceComplete(proxyName:String):void
    {
      for(var i:int = 0; i < resourceList.length; i++)
      {
        var r:ResourceVO = resourceList[i] as ResourceVO;
        if (r.proxyName == proxyName)
        {
          r.loaded = true;
          loadedReources++;
          // send the notification for update the progress bar
          sendNotification(StartupMonitorProxy.LOADING_STEP, (loadedReources * 100) / resourceList.length);
          // check if the process is completed
          // if is not completed and the resources have blocked the process chain
          // continue to read the other resources
          if (!checkResources() && r.blockChain)
          {
            loadResources();
          }
          break;
        }
      }

    }


    //----------------------------------------------------------
    //
    // Methods - Private
    //
    //----------------------------------------------------------

    private function checkResources():Boolean
    {
      for(var i:int = 0; i < resourceList.length; i++)
      {
        var r:ResourceVO = resourceList[i] as ResourceVO;
        if (!r.loaded)
        {
          return false;
        }
      }
      sendNotification(StartupMonitorProxy.LOADING_COMPLETE);
      return true;
    }
  }
}