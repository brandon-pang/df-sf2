/**
 * ...
 * @author 
 */

import gfx.utils.Delegate;
import com.greensock.easing.Back;
import gfx.layout.Panel;
import com.greensock.TweenMax;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class com.scaleform.sf2.hud.shooter.ShooterEquipWnd extends Panel
{
	
	public var equipWndCont:MovieClip;
	
	private var _slotNum:Number = 0;
	
    public function ShooterEquipWnd()
    {         
        super();
		
		equipWndCont.slot0.bg.mc.gotoAndStop(1);
		equipWndCont.slot1.bg.mc.gotoAndStop(2);
		equipWndCont.slot2.bg.mc.gotoAndStop(3);
		equipWndCont.slot3.bg.mc.gotoAndStop(4);
		equipWndCont.slot4.bg.mc.gotoAndStop(5);
    }
	
	public function show():Void
	{
		gotoAndPlay("show");
	}
	
	public function setShortcut(slot0:String, slot1:String, slot2:String, slot3:String, slot4:String):Void
	{
		equipWndCont.slot0.key.textField.text = slot0;
		equipWndCont.slot1.key.textField.text = slot1;
		equipWndCont.slot2.key.textField.text = slot2;
		equipWndCont.slot3.key.textField.text = slot3;
		equipWndCont.slot4.key.textField.text = slot4;
	}
	
	public function setEquipSlot(slotNum:Number, 
								index:String, 
								imgSet:String, 
								camoBgName:String, 
								bullet:Number):Void
	{
		equipWndCont["slot" + slotNum].setSlot(index, imgSet, camoBgName, bullet);
	}

	public function setWeaponBullets(slotNum:Number,bullet:Number)
	{
		equipWndCont["slot" + slotNum].setBulletSlot(bullet);
	}	
	
	public function setSelectSlot(slotNum:Number):Void
	{
		if (equipWndCont.select._x == equipWndCont["slot"+slotNum]._x) { return; }
		var isSlotF:Boolean = false;
		if (slotNum == 4) { isSlotF = true; }
		
		equipWndCont.select.gotoAndStop(2);
		TweenMax.to(equipWndCont.select, 0.16, {
													_x:equipWndCont["slot"+slotNum]._x,
													ease:Back.easeOut,
													onComplete:Delegate.create(this, onSelectTweenComplete),
													onCompleteParams:[isSlotF, _slotNum]
												});
		_slotNum = slotNum;
	}
	
	private function onSelectTweenComplete(isSlotF:Boolean, oldSlot:Number):Void
	{
		equipWndCont.select.gotoAndStop(1);
		equipWndCont["slot"+_slotNum].bg.gotoAndPlay("show");
		if (isSlotF)
		{
			TweenMax.to(equipWndCont.select, 0.16, {
														_x:equipWndCont["slot"+oldSlot]._x,
														ease:Back.easeOut,
														onComplete:Delegate.create(this, onSelectTweenComplete),
														onCompleteParams:[false, _slotNum]
													});
			_slotNum = oldSlot;
		}
	}
	
	public function hide():Void
	{
		gotoAndPlay("hide");
	}
	
	private function configUI():Void
	{
		super.configUI();
	}
	
}