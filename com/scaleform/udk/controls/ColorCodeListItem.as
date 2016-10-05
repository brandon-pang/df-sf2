/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.utils.Delegate;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.ColorCodeListItem extends ListItemRenderer
{
	private var drawMc:MovieClip;
	
	public function ColorCodeListItem()
	{
		super();
	}
	
	public function setData(data:Object):Void
	{
		//trace(data.toString());
		if (data == undefined)
		{
			this._visible = false;
			return;
		}
		this._visible = true;
		this.data = data;
		invalidate();
		
		if(data.ColorCode==""||data.ColorCode==null||data.ColorCode=="0"||data.ColorCode==" "){
			this.disabled=true
			drawMc._visible=false
		}else{
			trace (" - =- =- =- =- data.ColorCode = "+data.ColorCode)
			this.disabled=false
			drawMc._visible=true
			drawRect(2, 2, 29, 28,4,data.ColorCode)
		}
	}

	private function updateAfterStateChange():Void
	{		
		if(data.ColorCode==""||data.ColorCode==null||data.ColorCode=="0"||data.ColorCode==" "){
			this.disabled=true
			drawMc._visible=false
		}else{
			this.disabled=false
			drawMc._visible=true
			drawRect(2, 2, 29, 28,4,data.ColorCode)
		}	
	}
	
	private function drawRect(x, y, w, h,cornerRadius,color) {
	// if the user has defined cornerRadius our task is a bit more complex. :)
		var _this:MovieClip=drawMc
		_this.clear ();
		var codeColor="0x"+color
		_this.lineStyle (1, Number(codeColor));		
		_this.beginFill (Number(codeColor), 100);
		
		var theta, angle, cx, cy, px, py;
		// make sure that w + h are larger than 2*cornerRadius
		// theta = 45 degrees in radians
		if (cornerRadius>Math.min(w, h)/2) {
			cornerRadius = Math.min(w, h)/2;
		}
		theta = Math.PI/4;
		// draw top line
		
		_this.moveTo(x+cornerRadius, y);
		_this.lineTo(x+w-cornerRadius, y);
		//angle is currently 90 degrees
		angle = -Math.PI/2;
		// draw tr corner in two parts
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		// draw right line
		_this.lineTo(x+w, y+h-cornerRadius);
		// draw br corner
		angle += theta;
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+w-cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+w-cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		// draw bottom line
		_this.lineTo(x+cornerRadius, y+h);
		// draw bl corner
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+h-cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+h-cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		// draw left line
		_this.lineTo(x, y+cornerRadius);
		// draw tl corner
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		angle += theta;
		cx = x+cornerRadius+(Math.cos(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		cy = y+cornerRadius+(Math.sin(angle+(theta/2))*cornerRadius/Math.cos(theta/2));
		px = x+cornerRadius+(Math.cos(angle+theta)*cornerRadius);
		py = y+cornerRadius+(Math.sin(angle+theta)*cornerRadius);
		_this.curveTo(cx, cy, px, py);
		
		_this.endFill ();
	}
	private function configUI():Void {
		super.configUI();
		focusTarget = owner; // The component sets the focusTarget to its owner instead of vice-versa.  This allows sub-classes to override this behaviour.
	}
}