package com.jcornwell.mediabrowser.model.vo
{
  public class ResourceVO
  {
    public var proxyName:String;
    public var loaded:Boolean;
    public var blockChain:Boolean;

    function ResourceVO(proxyName:String, blockChain:Boolean)
    {
      this.proxyName = proxyName;
      this.loaded = false;
      this.blockChain = blockChain;
    }
  }

}
