import gfx.core.UIComponent;
import gfx.motion.Tween;
//import gfx.ui.InputDetails;
//import gfx.ui.NavigationCode;
import mx.data.encoders.Bool;
import mx.transitions.easing.*;
import flash.external.ExternalInterface;
import com.scaleform.udk.views.View;

class com.scaleform.udk.managers.MenuManager extends UIComponent
{

	// Manager movieClip to which all the views are attached.
	public var manager:MovieClip;

	// Reference to the current movieClip on the top of the stack.
	public var currentView:MovieClip;

	// The stack of views which are currently being displayed.
	private var _viewStack:Array;

	// Parameters for the standard 'push view/pop view' tweens.
	private var _tweenInitParams:Object;

	private var cursor:MovieClip;
	

	public function MenuManager()
	{
		super();

		_viewStack = [];
		Tween.init();

		// manager._z = 0;
		manager._x = 0;
		//manager._yrotation = -8;

		// Removed _perspfov change until fix in GFx core is added for _perspfov mouse-picking.
		// manager._perspfov = 30;

		//_tweenInitParams = { _alpha:0, _z: -15000, _x:750 };
		_tweenInitParams = { _alpha:0, _x:1024 };
		//MotionBoolean = true;
	}

	// Returns a reference to the current view on the top of the _viewstack.
	public function getCurrentView():MovieClip
	{
		return _viewStack[_viewStack.lengh - 1];
	}


	// Accessor, mutator for _viewStack.
	public function get viewStack():Array
	{
		return _viewStack;
	}
	public function set viewStack(value:Array):Void
	{
		_viewStack = value;
	}
	
	// Pushes a view onto the stack using the standard animation.
	public function pushStandardView(targetView:View):Void
	{
		if (!targetView)return;		
		pushViewImpl(targetView,{x:1024});
	}
	
	// Pushes a dialog onto the stack with a different animation than pushStandardView.
	public function pushDialogView(targetView:View):Void
	{
		if (!targetView)return;		
		pushViewImpl(targetView,{x:0});
	}

	// Pops a view from the view stack.
	public function popView(targetView:View):Void
	{
		if (!targetView)return;
		popViewImpl(targetView,{x:-1080});
	}

	public function popDialogView(targetView:View):Void
	{
		if (!targetView)return;		
		popViewImpl(targetView,{x:0});
	}

	// Pushes a view onto the stack, tweening it in and configuring its modal properties.
	private function pushViewImpl(targetView:View, pushParams:Object):Void
	{
		
		var subXpos:Number = 700;
		var pushedContainer:MovieClip = targetView._parent;
		pushedContainer._visible = true;// PPS: Do we need this?
		targetView["tweenPushParams"] = pushParams;
		
		var tarMc:MovieClip = targetView["container"];
		
		trace ("==============wait  asdasd: "+tarMc)		
		
		if (tarMc["notice"])
		{
			tarMc["notice"].gotoAndPlay("open");
		}
		else if (tarMc["log_in"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["makeCode"])
		{
			tarMc["makeCode"].gotoAndPlay("open");
		}
		else if (tarMc["makeWeapon"])
		{
			tarMc["makeWeapon"].gotoAndPlay("open");
		}
		else if (tarMc["dialog"])
		{
			pushedContainer._x = 0;
			tarMc["dialog"].gotoAndPlay("open");
		}
		else if (tarMc["createDialog"])
		{			
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["all_buy_dialog"])
		{			
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["env_dialog"]) {
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["lobbyChat"])
		{
			tarMc["lobbyChat"].gotoAndPlay("open");
			pushedContainer._x = 0;
			pushedContainer._y = 768 - 209;
		}
		else if (tarMc["main_navi"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["join_game"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["channel_list"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["waiting_room"])
		{
			trace ("wait  asdasd: "+tarMc)
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["inven_mc"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["inven_weapon_mc"])
		{
			tarMc["inven_weapon_mc"].gotoAndPlay("open");
		}
		else if (tarMc["inven_equip_mc"])
		{
			tarMc["inven_equip_mc"].gotoAndPlay("open");
		}
		else if (tarMc["clanlist"])
		{
			tarMc["clanlist"].gotoAndPlay("open");
		}
		else if (tarMc["clanhome"])
		{
			tarMc["clanhome"].gotoAndPlay("open");
		}
		else if (tarMc["shop_mc"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["my_Info"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["messenger_mc"])
		{
			tarMc["messenger_mc"].gotoAndPlay("open");
		}
		else if (tarMc["messenger_chat"])
		{
			tarMc["messenger_chat"].gotoAndPlay("open");
		}
		else if (tarMc["minigame_mc"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["resell_dialog"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["modifyAll_dialog"])
		{
			tarMc.gotoAndPlay("open");
		}		
		else if (tarMc["modifyAll_dialog"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_box"])
		{
			tarMc._y=200
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_camo"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_reset_weapon"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_result"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["left_notice"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_charge"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_weapon_nametag"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["clanmatch_waitroom"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["clanmatch_list"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["GachaSelect"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["GachaGame"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["PictureBox"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["dialog_exit"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_exit_pop"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_exit_begin"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["clan_mark_make"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_new_member"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_event"])
		{
			
			tarMc.gotoAndPlay("open");		
		}
		else if (tarMc["dialog_tag"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["dialog_choice"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["leftReBuy"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["videoMc"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["declareWnd"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["communityWnd"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["clanWeekRankWnd"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["clanWeekRankBase"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["gachaRollWnd"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["wideMc"])
		{
			tarMc.gotoAndPlay("open");
		}
		else if (tarMc["clanSearchWnd"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["clanMakeWnd"])
		{
			targetView["openInit"]();
		}
		else if (tarMc["twitch_container"])
		{
			targetView["openInit"]();
		}		
		else if (tarMc["enchantCont"])
		{
			targetView["openInit"]();
		}
		
		if (targetView["modalBG"])
		{
			var tMc:MovieClip = targetView["modalBG"].attachMovie("modal", "modal", this.getNextHighestDepth());
			tMc._x = 0;
		}
		//_viewStack.push(targetView);         
	}

	private function popViewImpl(targetView:View, popParams:Object):Void
	{
		
		// Restore next screen in stack
		var subXpos = -1024;
		var poppedView:MovieClip = MovieClip(targetView);
		//var latestView:MovieClip = MovieClip(_viewStack[_viewStack.length-1]);
		//Selection["modalClip"] = latestView;
		var tarMc:MovieClip = targetView["container"];
		//tarMc.noAdvance=true
		if (tarMc["notice"])
		{
			tarMc["notice"].gotoAndPlay("close");
		}
		else if (tarMc["log_in"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["makeCode"])
		{
			tarMc["makeCode"].gotoAndPlay("close");
		}
		else if (tarMc["makeWeapon"])
		{
			tarMc["makeWeapon"].gotoAndPlay("close");
		}
		else if (tarMc["dialog"])
		{		
			tarMc["dialog"].gotoAndPlay("close");
		}
		else if (tarMc["createDialog"])
		{			
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["all_buy_dialog"])
		{			
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["env_dialog"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["lobbyChat"])
		{
			tarMc["lobbyChat"].gotoAndPlay("close");
		}
		else if (tarMc["main_navi"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["join_game"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["channel_list"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["waiting_room"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["inven_mc"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["inven_weapon_mc"])
		{
			tarMc["inven_weapon_mc"].gotoAndPlay("close");
		}
		else if (tarMc["inven_equip_mc"])
		{
			tarMc["inven_equip_mc"].gotoAndPlay("close");
		}
		else if (tarMc["clanlist"])
		{
			tarMc["clanlist"].gotoAndPlay("close");
		}
		else if (tarMc["clanhome"])
		{
			tarMc["clanhome"].gotoAndPlay("close");
		}
		else if (tarMc["declareWnd"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["invenWeapon"])
		{
			//tarMc["waiting_room"].gotoAndPlay("close");
			var poppedContainer:MovieClip = poppedView._parent;
			poppedContainer.tweenTo(0.5,{_alpha:0, _x:subXpos},Strong.easeOut);
		}
		else if (tarMc["invenChr"])
		{
			//tarMc["charShop"].gotoAndPlay("close");
			var poppedContainer:MovieClip = poppedView._parent;
			poppedContainer.tweenTo(0.5,{_alpha:0, _x:subXpos},Strong.easeOut);
		}
		else if (tarMc["shop_mc"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["charShop"])
		{
			//tarMc["charShop"].gotoAndPlay("close");
			var poppedContainer:MovieClip = poppedView._parent;
			poppedContainer.tweenTo(0.5,{_alpha:0, _x:subXpos},Strong.easeOut);
		}
		else if (tarMc["my_Info"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["messenger_mc"])
		{
			tarMc["messenger_mc"].gotoAndPlay("close");
		}
		else if (tarMc["messenger_chat"])
		{
			tarMc["messenger_chat"].gotoAndPlay("close");
		}
		else if (tarMc["minigame_mc"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["resell_dialog"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["modifyAll_dialog"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_box"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_camo"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_reset_weapon"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_result"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["left_notice"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_charge"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_weapon_nametag"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["clanmatch_waitroom"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["clanmatch_list"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["GachaSelect"])
		{
			tarMc.gotoAndPlay("close");
		}	
		else if (tarMc["GachaGame"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["PictureBox"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["dialog_exit"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_exit_pop"])
		{
			tarMc.gotoAndPlay("close");
		}else if (tarMc["dialog_exit_begin"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["clan_mark_make"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_new_member"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_event"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_tag"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["leftReBuy"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["videoMc"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["dialog_choice"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["communityWnd"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["wideMc"])
		{
			tarMc.gotoAndPlay("close");
		}
		else if (tarMc["clanWeekRankWnd"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["clanWeekRankBase"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["gachaRollWnd"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["clanSearchWnd"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["clanMakeWnd"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["twitch_container"])
		{
			targetView["closeInit"]();
		}
		else if (tarMc["enchantCont"])
		{
			targetView["closeInit"]();
		}
		else
		{
			trace("popView(" + poppedView + ")");

			var popParams:Object = poppedView.tweenPushParams;
			//var zPull:Number = popParams.z;
			//var xPull:Number = popParams.x;
			var xPull:Number = popParams.x;

			// Outro tween popped screen
			var poppedContainer:MovieClip = poppedView._parent;
			poppedContainer.tweenTo(0.5,{_alpha:0, _x:xPull},Strong.easeOut);
		}

		/*
		var container:MovieClip = MovieClip(targetView)._parent;
		//var invIdx:Number = _viewStack.length-i-1;
		//  var targetZ:Number = container.target.z + zPull;
		var targetX:Number = container.target.x-xPull;
		container.tweenTo(0.5, 
		{ 
		_alpha:100 / (invIdx * 25 + 1), 
		_z: targetZ,
		_x: targetX
		}, Strong.easeOut);
		            container.target = { z:targetZ, x:targetX };  
		container.tweenTo(0.5,{_alpha:0, _x:0},Strong.easeOut);
		container.target = {x:targetX};
		*/
		if (poppedView["modalBG"])
		{
			poppedView["modalBG"].modal.removeMovieClip();
		}
		//return poppedView;         
	}

	public function setSelectionFocus(mc:MovieClip):Void
	{
		Selection.setFocus(mc);
		trace("setSelectionFocus:: Selection.getFocus(): " + Selection.getFocus());
	}
	
	public function setSelectionTextField(mc,startIdx:Number,endIdx:Number):Void
	{
		Selection.setFocus(mc);
    	Selection.setSelection(startIdx, endIdx);
		trace("setSelectionTextField:: Selection.setFocus(): " + Selection.getFocus());
		trace("setSelectionTextField:: Selection.setSelection(): " + startIdx+","+endIdx);
	}

	public function showCursor(value:Boolean)
	{
		cursor._visible = value;
	}
}