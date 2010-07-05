package com.jcornwell.mediabrowser.model.helpers
{
  import com.adobe.serialization.json.JSON;

  import mx.utils.ObjectUtil;

  public class JSONHelper
  {
    //----------------------------------------------------------
    //
    // Methods - Public - Static
    //
    //----------------------------------------------------------

    public static function decodeToFlexClass(classType:Class, jsonData:String):Object
    {
      var jsonObject:Object = JSON.decode(jsonData);
      var newClass:Object = new classType();

      var classInfo:Object = ObjectUtil.getClassInfo(newClass);

      for each (var qname:QName in classInfo.properties)
      {
        if (jsonObject.hasOwnProperty(qname.localName))
        {
          newClass[qname.localName] = jsonObject[qname.localName]
        }
      }

      return newClass;
    }
  }
}
