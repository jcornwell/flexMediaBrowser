package com.jcornwell.mp3tunes.model.helpers
{
  public class XmlResource
  {
    //----------------------------------------------------------
    //
    // Methods - Public - Static
    //
    //----------------------------------------------------------

    static public function parse(data:Object, node:Object, prefix:String=''):void
    {
      for(var i:Number=0;i<node.childNodes.length;i++)
      {
        var currentNode:Object = node.childNodes[i];
        if (currentNode.nodeName=='param' || currentNode.nodeName=='item')
        {
          if (currentNode.attributes.value!=null)
            data[(prefix+currentNode.attributes.name).toLowerCase()] = currentNode.attributes.value;
          else
            data[(prefix+currentNode.attributes.name).toLowerCase()] = currentNode.firstChild.nodeValue;
        }
        else if (currentNode.nodeName=='group' && currentNode.hasChildNodes())
        {
          XmlResource.parse(data, currentNode, prefix+currentNode.attributes.name+'/');
          continue;
        }
        if (currentNode.hasChildNodes()) XmlResource.parse(data, currentNode, prefix);
      }
    }
  }
}
