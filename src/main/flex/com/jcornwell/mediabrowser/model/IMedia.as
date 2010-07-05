package com.pluggd.medialibrary.model
{
  public interface IMedia
  {
    function get id():String;
    function get title():String

    function get artistId:String();
    function get artistName:String();

    function get albumId():String;
    function get albumName():String;
    function get albumYear():Number;
    function get albumArtUrl():String;

    function get filename():String;
    function get filekey():String;
    function get filesize():Number;

    function get downloadUrl():String;
    function get playUrl():String;
  }
}
