/**
 * ...
 * @author ...
 */

import gfx.controls.ListItemRenderer;
import gfx.controls.CoreList;
import gfx.controls.UILoader;

class com.scaleform.TileItemRenderer extends ListItemRenderer {

   public var index:Number;
   public var owner:CoreList;
   public var selectable:Boolean = true;
   
   public var myImage:UILoader;
   
   public function TileItemRenderer() { super(); }
   
   public function setData(data:Object):Void {
	   if (data == undefined) {
         this._visible = false;
         return;
      } 
      this.data = data;
      this.label = data._label;
      invalidate();
   }      
   
   public function draw():Void {
      super.draw();
      // Reset the UILoader visibilty to true because it may be set to false
      // internally while loading the image. If a second source is set in the
      // middle of loading an image, the visibility state may be invalid.
      myImage.visible = true;
      myImage.source = data._imagePath;
   }
} 