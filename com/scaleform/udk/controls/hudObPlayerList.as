/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;

class com.scaleform.udk.controls.hudObPlayerList extends ListItemRenderer
{

	private var txtName:MovieClip;
	private var txtKill:MovieClip;
	private var txtAssist:MovieClip;
	private var txtDeath:MovieClip;
	private var numbers:MovieClip;

	// Initialization:
	public function hudObPlayerList()
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
		//data.stat data.playerNo data.playerName, data.team, data.hp
		numbers["txtNo"].text=data.playerNo.substring(1)
		txtName.text=data.playerName
		txtKill.text=data.kill+ " / "
		txtAssist.text=data.assist + " / "
		txtDeath.text=data.death
		
		if(data.playerNo.charAt(0)=="R"){
			//red 
			numbers.gotoAndStop(1)
		}else{
			//blue
			numbers.gotoAndStop(2)
		}
		
		if(data.stat=="0"){
			//살았을 경우
			txtName.textColor=0x999999
			txtKill.textColor=0x999999
			txtAssist.textColor=0x999999
			txtDeath.textColor=0x999999
			
			numbers["txtNo"].textColor=0xffe4af
			numbers._alpha=100			
		}else{
			//죽었을 경우
			txtName.textColor=0x1d1d1d
			txtKill.textColor=0x1d1d1d
			txtAssist.textColor=0x1d1d1d
			txtDeath.textColor=0x1d1d1d
			numbers["txtNo"].textColor=0xffe4af
			numbers._alpha=15			
		}
		
	}	
	private function updateAfterStateChange():Void
	{		
		numbers["txtNo"].text=data.playerNo.substring(1)
		txtName.text=data.playerName
		txtKill.text=data.kill+ " / "
		txtAssist.text=data.assist + " / "
		txtDeath.text=data.death
		
		if(data.playerNo.charAt(0)=="R"){
			//red 
			numbers.gotoAndStop(1)
		}else{
			//blue
			numbers.gotoAndStop(2)
		}
		
		if(data.stat=="0"){
			//살았을 경우
			txtName.textColor=0x999999
			txtKill.textColor=0x999999
			txtAssist.textColor=0x999999
			txtDeath.textColor=0x999999
			
			numbers["txtNo"].textColor=0xffe4af
			numbers._alpha=100			
		}else{
			//죽었을 경우
			txtName.textColor=0x1d1d1d
			txtKill.textColor=0x1d1d1d
			txtAssist.textColor=0x1d1d1d
			txtDeath.textColor=0x1d1d1d
			
			numbers["txtNo"].textColor=0xffe4af
			numbers._alpha=15			
		}
	}
}