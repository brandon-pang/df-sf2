/**
 * 인게임에서 사용되는 상점
 * By senariel
 */

import flash.external.ExternalInterface; 
import gfx.layout.Panel;

class com.scaleform.RemainingEnemiesInfo extends gfx.layout.Panel
{
	private var MAX_DISPLAY_ITEM:Number = 6;
	
	// Public Properties
	
	// Private Properties
	private var _items:Array = new Array();
	//private var _images:;
	
	// UI Elements
	public var mc:MovieClip;
	
	// Initialization
	public function RemainingEnemiesInfo() { super(); }
	
	public function InitializeEnemiesInfo()
	{
		for (var i:Number = 0; i < MAX_DISPLAY_ITEM; i++)
		{
			_items[i] = mc["item"+i];
		}
		
		ResetEnemiesInfo();
	}
	
	/** 로드 완료 시 초기화 */
	private function onLoad():Void
	{
		super.onLoad();
		
		InitializeEnemiesInfo();
	}


	// Public Methods
	/** PVE 적 목록을 초기화합니다. */
	public function ResetEnemiesInfo()
	{
		var list_size:Number = _items.length;
		
		for (var i = 0; i < list_size; i++ )
		{
			_items[i].mc.textField.text = "";
			_items[i]._visible = false;
		}
	}

	// PVE 적 목록 세팅
	public function setMonsterEnemyBoard( arr:Array )
	{
		// 일단 싹 지우고 시작.
		// arr의 갯수에 따라 이전 설정 값이 남아 있을 수 있습니다.
		ResetEnemiesInfo();

		var _len:Number = arr.length;
		for (var i = 0; i < _len; i++)
		{
			// 값 설정
			_items[i].mc.textField.text = arr[i];
			_items[i]._visible = true;
		}

		gotoAndPlay("open");
	}

	public function setMonsterEnemyBoardClose()
	{
		gotoAndPlay("close");
	}


	// Private Methods
}
