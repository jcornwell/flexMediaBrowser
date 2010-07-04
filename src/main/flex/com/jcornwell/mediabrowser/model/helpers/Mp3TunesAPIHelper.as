package com.jcornwell.mediabrowser.model.helpers
{
  import mx.utils.StringUtil;

  public class Mp3TunesAPIHelper
  {
    //----------------------------------------------------------
    //
    // Constants - Public - Static
    //
    //----------------------------------------------------------

    public static const PARTNER_TOKEN:String = "8309320273";


    //----------------------------------------------------------
    //
    // Methods - Public - Static
    //
    //----------------------------------------------------------

    public static function getLoginEndpoint(username:String, password:String):String
    {
      return StringUtil.substitute("https://shop.mp3tunes.com/api/v1/login?username={0}&password={1}&partner_token={2}", username, password, PARTNER_TOKEN)
    }
  }
}
