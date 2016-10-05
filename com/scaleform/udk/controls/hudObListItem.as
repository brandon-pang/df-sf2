/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/
import gfx.controls.ListItemRenderer;

class com.scaleform.udk.controls.hudObListItem extends ListItemRenderer
{

	private var txtName:MovieClip;
	private var txtNo:MovieClip;
	private var numbers:MovieClip;
	private var gauges:MovieClip;
	private var bg:MovieClip;
	private var weaponNameMC:MovieClip;
	private var weaponFrames:String;

	// Initialization:
	public function hudObListItem()
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
        //0:none 1:녹색 2:붉은색 3:흰색 4:와인색
		//data.stat data.playerNo data.playerName, data.team, data.hp
		txtNo.text=data.playerNo.substring(1);
		txtName.text=data.playerName;		
		
		if(data.stat=="0"){
			txtName.textColor=0xffffff
			txtNo.textColor=0xffe4af
			numbers._alpha=100
			bg._alpha=100
			gauges._visible=true;
			weaponNameMC._alpha=100;
		}else{
			txtName.textColor=0x858585
			txtNo.textColor=0x5d5b5a
			numbers._alpha=20
			bg._alpha=45;
			gauges._visible=false;
			weaponNameMC._alpha=45;
		}
		
		if(data.playerNo.charAt(0)=="R"){
			//red 
			this._visible=true
			numbers.gotoAndStop(1)
		}else if(data.playerNo.charAt(0)=="B"){
			//blue
			this._visible=true
			numbers.gotoAndStop(2)
		}else if(data.playerNo.charAt(0)==""){
			this._visible=false
		}
		
		gauges.setGaugeValue(data.playerNo.charAt(0),Number(data.hp))
		
		//----------------- 무기이름표시(2-15 추가)
		weaponNameMC.MC.textField.text = data.playerWeaponName;
		//무기이름 표시 프레임 제어
		//래드 열기 : Ropen, 무기변경 : Rani, 닫기 : Rclose
		//블루 열기 : Bopen, 무기변경 : Bani, 닫기 : Bclose
		weaponFrames = data.WeaponNameSetData;		
		//trace("***********************  값 : "+weaponFrames)	
		
		trace("******************* weaponChange YES"+data.WeaponNameSetData+": playerNo :"+data.playerNo+": playerWeaponName  :"+data.playerWeaponName+": playerName  :"+data.playerName)
		
		if(weaponFrames!="undefined"){			
			weaponNameMC.gotoAndPlay(weaponFrames);
			//trace("******************* weaponChange YES"+weaponFrames)
		}else{
			//trace("******************* weaponChange No"+weaponFrames)
			if(data.playerNo.charAt(0)=="R"){
				//red 
				weaponNameMC.gotoAndStop(6)
			}else if(data.playerNo.charAt(0)=="B"){
				//blue
				weaponNameMC.gotoAndStop(23)
			}			
		}				
	}	
	
	private function updateAfterStateChange():Void
	{		
		txtNo.text=data.playerNo.substring(1);
		txtName.text=data.playerName
		
		if(data.stat=="0"){
			txtName.textColor=0xffffff
			txtNo.textColor=0xffe4af
			numbers._alpha=100
			bg._alpha=100
			gauges._visible=true;
			weaponNameMC._alpha=100;
		}else{
			txtName.textColor=0x858585
			txtNo.textColor=0x5d5b5a
			numbers._alpha=20
			bg._alpha=45;
			gauges._visible=false;
			weaponNameMC._alpha=45;
		}
		
		if(data.playerNo.charAt(0)=="R"){
			//red 
			this._visible=true
			numbers.gotoAndStop(1)
		}else if(data.playerNo.charAt(0)=="B"){
			//blue
			this._visible=true
			numbers.gotoAndStop(2)
		}else if(data.playerNo.charAt(0)==""){
			this._visible=false
		}
		
		gauges.setGaugeValue(data.playerNo.charAt(0),Number(data.hp))
		
		//----------------- 무기이름표시(2-15 추가)
		/*weaponNameMC.MC.textField.text = data.playerWeaponName;
		//무기이름 표시 프레임 제어
		//래드 열기 : Ropen, 무기변경 : Rani, 닫기 : Rclose
		//블루 열기 : Bopen, 무기변경 : Bani, 닫기 : Bclose
		weaponFrames = data.WeaponNameSetData;		
		//trace("***********************  값 : "+weaponFrames)		
		if(weaponFrames!="undefined"){			
			weaponNameMC.gotoAndPlay(weaponFrames);
			trace("무기변경 OK"+weaponFrames)
		}else{
			trace("무기변경 NO"+weaponFrames)
			if(data.playerNo.charAt(0)=="R"){
				//red 
				weaponNameMC.gotoAndStop(6)
			}else if(data.playerNo.charAt(0)=="B"){
				//blue
				weaponNameMC.gotoAndStop(23)
			}			
		}*/
		
		
	}
}