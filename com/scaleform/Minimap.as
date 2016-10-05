/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY 
 OF DESIGN, MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

/**
 * This class drives the minimap symbol.
 */
import flash.external.ExternalInterface;
import gfx.core.UIComponent;
//import com.scaleform.MinimapControls;

class com.scaleform.Minimap extends UIComponent
{

	// The entities, layers and controls of the minimap
	public var player:MovieClip;
	public var icons_waypoint:MovieClip;
	public var icons_flag:MovieClip;
	public var icons_diamond:MovieClip;
	public var compass:MovieClip;
	public var icons_player_red:MovieClip;
	public var icons_player_blue:MovieClip;
	public var map:MovieClip;
	public var secterBar:MovieClip;
	public var mask_mc:MovieClip;

	public var mapOver:MovieClip;
	//
	public var mapLine:MovieClip;

	// Path to load the terrain map. This variable can be overwritten from the application
	// during the registerMiniMapView XI.call to change the loading path.
	public var mapImagePath:String;
	//public var mapImagePath:String="chk_minimap.jpg"
	public var mapOverImagePath:String;
	public var mapLineImagePath:String;
	public var zoomBar:MovieClip;
	// Keeps track of generated icon counts
	var iconCounts:Object;

	public function Minimap()
	{
		//
	}

	public function configUI():Void
	{

		// Register minimap values with the app
		//
		// Params: 
		//minimap movieclip (this),
		//view radius, 
		//
		ExternalInterface.call("registerMiniMapView",this,166,412,512);
		trace(this.player._name);
		trace(this.player._x);
		trace(this.player._y);
		//
		map.loadMovie(mapImagePath);
		//
		//mapOver.loadMovie(mapOverImagePath);
	}


	public function mapOverLoader():Void
	{
		//
		mapOver.loadMovie(mapOverImagePath);
		//
		//ExternalInterface.call("registerMiniMapView", this, 124);
	}
	public function mapLineLoader():Void
	{
		//
		mapLine.loadMovie(mapLineImagePath);
		//
		//ExternalInterface.call("registerMiniMapView", this, 124);
	}
	public function setSecterName(str:String):Void
	{
		//
		secterBar.txtSecterName.textField.htmlText = str;
	}
	public function setZoomBarPoz(no:Number)
	{
		var yPoz = 117 - ((no / 100) * 117);
		zoomBar.bar.bar._y = yPoz;
	}

}