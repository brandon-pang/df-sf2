/**
 * 인게임에서 사용되는 상점
 * By senariel
 */

import flash.external.ExternalInterface; 
import gfx.layout.Panel;

class com.scaleform.InGameShop extends gfx.layout.Panel
{
	private var MAX_SHOP_ITEM:Number = 6;
	private var VERTICAL_ITEM_COUNT:Number = 2;

// Public Properties
	
// Private Properties
	private var shop_items:Array = new Array();		// 갯수가 특정되지 않아 별도 설정합니다.
	private var is_shop_opened:Boolean = false;

// UI Elements

// Initialization
	public function InGameShop() { super(); }

	public function InitializePVEShopItems()
	{
		for (var i:Number = 0; i < MAX_SHOP_ITEM; i++)
		{
			shop_items[i] = this["item"+i];
		}
		
		Key.addListener( this );

		ResetPVEShopItems();
	}

	/** 로드 완료 시 초기화 */
	private function onLoad():Void 
	{
		super.onLoad();

		InitializePVEShopItems();
	}


// Public Methods
	/** PVE 상점 아이템 목록을 초기화합니다. */
	public function ResetPVEShopItems()
	{
		var list_size:Number = shop_items.length;

		for (var i = 0; i < list_size; i++ )
		{
			shop_items[i].txtTitle.text = "";
			shop_items[i].Ltxtwname.text = "";
			shop_items[i].Ltxtprice.text = "";
			shop_items[i].Rtxtwname.text = "";
			shop_items[i].Rtxtprice.text = "";
			shop_items[i].Lbtn.disableFocus = true;
			shop_items[i].Rbtn.disableFocus = true;
			shop_items[i]._visible = false;
			
			shop_items[i].Lbtn.addEventListener( "click", this, "onItemClick" );
			shop_items[i].Rbtn.addEventListener( "click", this, "onItemClick" );
		}
	}

	// PVe 상점 아이템 목록 세팅
	public function SetPveWeaponItemList( arr:Array )
	{
		//trace(arr.length);
		//trace(arr[0].Type);
		
		// 일단 싹 지우고 시작. 
		// arr의 갯수에 따라 이전 설정 값이 남아 있을 수 있습니다.
		ResetPVEShopItems();

		var _len:Number = arr.length;
		for (var i = 0; i < _len; i++)
		{
			// 값 설정
			shop_items[i].txtTitle.text = arr[i].Type;

			if (arr[i].ItemID1 != null)
			{
				shop_items[i].Ltxtwname.text = arr[i].ImgName1;
				shop_items[i].Ltxtprice.text = arr[i].ImgPrice1;
				shop_items[i].Lbtn.data = arr[i].ItemID1;
				shop_items[i].LItemImage.attachMovie(arr[i].ImgSet1, "item_image", shop_items[i].LItemImage.getNextHighestDepth());
			}

			if (arr[i].ItemID2 != null)
			{
				shop_items[i].Rtxtwname.text = arr[i].ImgName2;
				shop_items[i].Rtxtprice.text = arr[i].ImgPrice2;
				shop_items[i].Rbtn.data = arr[i].ItemID2;
				shop_items[i].RItemImage.attachMovie(arr[i].ImgSet2, "item_image", shop_items[i].RItemImage.getNextHighestDepth());
			}

			shop_items[i].Lbtn.disabled = (arr[i].ItemID1 == null);
			shop_items[i].Rbtn.disabled = (arr[i].ItemID2 == null);

			shop_items[i]._visible = true;
		}

		is_shop_opened = true;
		gotoAndPlay("open");
	}

	public function SetPveWeaponItemListClose()
	{
		is_shop_opened = false;
		gotoAndPlay("close");
	}

	public function onItemClick( event:Object )
	{
		Req_ItemBuy( event.target.data );
	}

	public function onKeyDown()
	{
		if (is_shop_opened)
		{
			// Key.getCode() 를 바로 반환하면 공백이 오네요.. 이건 또 웬 버그...
			var key_code:Number = Key.getCode();
			
			if (Key.getCode() == Key.ESCAPE)
			{
				Req_CloseShop();
				return;
			}
			
			key_code = key_code - String("0").charCodeAt(0) - 1;
			
			if (key_code < 0 || key_code > (MAX_SHOP_ITEM * VERTICAL_ITEM_COUNT))
			{
				return;
			}

			var row_index:Number = Math.floor( key_code / VERTICAL_ITEM_COUNT );
			var side:Number = (key_code % VERTICAL_ITEM_COUNT);
			var item_index:Number = (side == 0) ? shop_items[row_index].Lbtn.data : shop_items[row_index].Rbtn.data;

			if (item_index == null)
			{
				return;
			}

			Req_ItemBuy( item_index.toString() );
		}
	}

// Private Methods
	private function Req_ItemBuy( item_id:String )
	{
		ExternalInterface.call( "OnSelectInGameShopItem", item_id );
	}

	private function Req_CloseShop()
	{
		ExternalInterface.call( "OnRequestCloseShopItem" );
	}
	
	private function NotifyDebugInfo( str:String )
	{
		ExternalInterface.call( "OnDebugInfo", str );
	}
}