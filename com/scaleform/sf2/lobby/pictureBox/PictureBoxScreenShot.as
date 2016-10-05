/**
 * ...
 * @author 
 */

import com.scaleform.udk.controls.PictureBoxThumbListItem;
import flash.external.ExternalInterface;
import gfx.data.SFGameDataProvider;
import gfx.managers.InputDelegate;
import gfx.managers.FocusHandler;
import gfx.controls.TextInput;
import gfx.controls.TileList;
import com.scaleform.udk.controls.BlockInteraction;
import gfx.utils.Delegate;
import flash.geom.Rectangle;
import com.greensock.easing.Cubic;
import com.greensock.TweenMax;
import gfx.controls.UILoader;
import gfx.controls.Button;
import gfx.controls.ButtonBar;
import gfx.core.UIComponent;

class com.scaleform.sf2.lobby.pictureBox.PictureBoxScreenShot extends UIComponent
{
	public var loader:UILoader;
	public var modal:BlockInteraction;
	public var loadingMC:MovieClip;
	public var removeBtn:Button;
	public var zoomBtn:Button;
	public var prevBtn:Button;
	public var nextBtn:Button;
	public var closeBtn:Button;
	public var bgBtn:Button;
	public var fileNameBtn:Button;
	public var fileNameInput:TextInput;
	public var fileNameEditBtn:Button;
	public var fileNameEditDummy:Button;
	public var btnFacebookShot:Button;

	public var btnScreenShotFolder:Button;
	public var folderPathTxt:TextField;
	public var tileList_picture:TileList;
	public var item1:PictureBoxThumbListItem;
	public var item2:PictureBoxThumbListItem;
	public var item3:PictureBoxThumbListItem;
	public var item4:PictureBoxThumbListItem;
	public var item5:PictureBoxThumbListItem;

	private var listIndex:Number = -1;
	private var visibleRect:Rectangle;
	private var oldDisInfo:Object = {};
	private var inputFocused:Boolean = false;
	private var inputChanged:Boolean = false;
	private var canceled:Boolean = false;

	private var intervalId:Number;

	public function PictureBoxScreenShot()
	{
		super();
	}

	public function screenShotInit():Void
	{
		zoomBtn.visible = false;
		removeBtn.visible = false;
		prevBtn.visible = false;
		nextBtn.visible = false;
		closeBtn.visible = false;
		modal.visible = false;
		bgBtn.visible = false;
		fileNameBtn.visible = false;
		fileNameInput.visible = false;
		fileNameEditBtn.visible = false;
		fileNameEditDummy.visible = false;
		btnFacebookShot.visible = false;

		loader.unload();
		//tileList_picture.dataProvider = [];
		tileList_picture.scrollPosition = 0;
		tileList_picture.selectedIndex = -1;
		listIndex = -1;

		oldDisInfo = {};
		inputFocused = false;
		inputChanged = false;
		canceled = false;
		Selection.setFocus(null);
		FocusHandler.instance.onSetFocus(null);

		loadingMC.gotoAndStop(1);
	}

	public function screenShot_SetSelectedIndex(index:Number):Void
	{
		if (index == -1)
		{
			screenShotInit();
			return;
		}
		if (tileList_picture.dataProvider.length == 0 || index > tileList_picture.dataProvider.length - 1)
		{
			return;
		}
		tileList_picture.selectedIndex = index;
		listIndex = index;
		tileList_picture.dataProvider.requestItemAt(tileList_picture.selectedIndex,this,"onSetImageFileName");
	}

	public function screenShot_SetRemoveSuccess(index:Number):Void
	{
		if (tileList_picture.dataProvider.length == 0)
		{
			zoomBtn.visible = false;
			removeBtn.visible = false;
			prevBtn.visible = false;
			nextBtn.visible = false;
			bgBtn.visible = false;
			fileNameBtn.visible = false;
			fileNameInput.visible = false;
			fileNameEditBtn.visible = false;
			btnFacebookShot.visible = false;
			fileNameEditDummy.visible = false;
			loader.unload();
			return;
		}
		removeBtn.visible = false;
		if (index > tileList_picture.dataProvider.length - 1)
		{
			index = tileList_picture.dataProvider.length - 1;
		}
		tileList_picture.selectedIndex = index;
		listIndex = index;
		tileList_picture.dataProvider.requestItemAt(index,this,"onSetImageFileName");
		ExternalInterface.call("screenShot_OnThumbListItemClick",listIndex);
	}

	public function screenShot_SetName(fileName:String):Void
	{
		setFileName(fileName);
	}

	public function screenShot_SetNameEditCancel():Void
	{
		canceled = true;
		Selection.setFocus(null);
		FocusHandler.instance.onSetFocus(null);
	}

	public function screenShot_SetNameEditEnter():Void
	{
		Selection.setFocus(null);
		FocusHandler.instance.onSetFocus(null);
	}

	public function screenShot_SetZoomOut():Void
	{
		setImgZoomOut();
	}

	public function screenShot_SetFolderPath(folderPath:String):Void
	{
		folderPathTxt.text = resizeFileName(folderPathTxt, folderPath);
	}

	private function configUI():Void
	{
		super.configUI();
		if (_root.designMode)
		{
			InputDelegate.instance.addEventListener("input",this,"handleInputs");
		}

		screenShotInit();

		fileNameInput.textField.noTranslate = true;
		fileNameInput.textField.restrict = '^\\\\/:*?"<>|';
		folderPathTxt.noTranslate = true;
		bgBtn.useHandCursor = false;
		fileNameBtn.useHandCursor = false;
		modal.doubleClickEnabled = true;
		visibleRect = Stage.visibleRect;

		loader.addEventListener("complete",this,"onLoaderComplete");

		removeBtn.addEventListener("click",this,"onRemoveBtnClick");
		removeBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		removeBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");
		removeBtn.addEventListener("releaseOutside",this,"onCtrlBtnRollOut");

		zoomBtn.addEventListener("click",this,"onZoomBtnClick");
		zoomBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		zoomBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");
		zoomBtn.addEventListener("releaseOutside",this,"onCtrlBtnRollOut");

		closeBtn.addEventListener("click",this,"onCloseBtnClick");
		modal.addEventListener("doubleClick",this,"onCloseBtnClick");

		bgBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		bgBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");
		bgBtn.addEventListener("releaseOutside",this,"onCtrlBtnRollOut");

		prevBtn.addEventListener("click",this,"onPrevBtnClick");
		prevBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		prevBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");
		prevBtn.addEventListener("releaseOutside",this,"onCtrlBtnRollOut");

		nextBtn.addEventListener("click",this,"onNextBtnClick");
		nextBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		nextBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");
		nextBtn.addEventListener("releaseOutside",this,"onCtrlBtnRollOut");

		fileNameBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		fileNameBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");

		fileNameInput.addEventListener("focusIn",this,"onFileNameInputFocusIn");
		fileNameInput.addEventListener("focusOut",this,"onFileNameInputFocusOut");
		fileNameInput.addEventListener("textChange",this,"onFileNameInputTextChange");

		fileNameEditBtn.addEventListener("click",this,"onFileNameEditStartClick");
		fileNameEditBtn.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		fileNameEditBtn.addEventListener("rollOut",this,"onCtrlBtnRollOut");

		btnFacebookShot.addEventListener("rollOver",this,"onCtrlBtnRollOver");
		btnFacebookShot.addEventListener("rollOut",this,"onCtrlBtnRollOut");

		btnScreenShotFolder.addEventListener("click",this,"onFolderBtnClick");

		tileList_picture.addEventListener("itemClick",this,"onListItemClick");

		tileList_picture.dataProvider = new SFGameDataProvider("ScreenShot:list");

		item1.addEventListener("selectedSetData",this,"onListItemSelectedSetData");
		item2.addEventListener("selectedSetData",this,"onListItemSelectedSetData");
		item3.addEventListener("selectedSetData",this,"onListItemSelectedSetData");
		item4.addEventListener("selectedSetData",this,"onListItemSelectedSetData");
		item5.addEventListener("selectedSetData",this,"onListItemSelectedSetData");	
		//|| _root.LanguageIndex == "KOR"
		if (_root.NowBranch == "ROOT"|| _root.LanguageIndex == "KOR"||_root.LanguageIndex == "IDN")
		{
			fileNameBtn._x = 197;
			fileNameInput._x = 197;
			fileNameEditDummy._x = 364;
			fileNameEditBtn._x = 364;
		}
		else
		{
			fileNameBtn._x = 219;
			fileNameInput._x = 219;
			fileNameEditDummy._x = 386;
			fileNameEditBtn._x = 386;
		}
		

		

		if (_global.gfxPlayer)
		{
			tileList_picture.dataProvider = [{url:"gfxImgSet/ScreenShots/ScreenShot00000.png", fileName:"ScreenShot00000wwwwwwwwwwwwwwwwwwwwwwwww"}, {url:"gfxImgSet/ScreenShots/ScreenShot00001.png", fileName:"ScreenShot00001"}, {url:"gfxImgSet/ScreenShots/ScreenShot00002.png", fileName:"ScreenShot00002"}, {url:"gfxImgSet/ScreenShots/ScreenShot00003.png", fileName:"ScreenShot00003wwwwwwwwwwwwwwwwwwwwwwwww"}, {url:"gfxImgSet/ScreenShots/ScreenShot00004.png", fileName:"ScreenShot00004"}, {url:"gfxImgSet/ScreenShots/ScreenShot00005.png", fileName:"ScreenShot00005"}, {url:"gfxImgSet/ScreenShots/ScreenShot00006.png", fileName:"ScreenShot00006"}, {url:"gfxImgSet/ScreenShots/ScreenShot00007.png", fileName:"ScreenShot00007"}, {url:"gfxImgSet/ScreenShots/ScreenShot00008.png", fileName:"ScreenShot00008"}, {url:"gfxImgSet/ScreenShots/ScreenShot00009.png", fileName:"ScreenShot00009"}, {url:"gfxImgSet/ScreenShots/ScreenShot00010.png", fileName:"ScreenShot00010"}];
			screenShot_SetSelectedIndex(0);
			//screenShot_SetFolderPath("C:/Netmarble/NetmarbleSF2/SFGame/ScreenShots/Netmarble/NetmarbleSF2/SFGame/ScreenShots/Netmarble/NetmarbleSF2/SFGame/ScreenShots/Netmarble/NetmarbleSF2/SFGame/ScreenShots/");
		}
	}

	private function setResizeModal():Void
	{
		var point:Object = {x:visibleRect.x, y:visibleRect.y};
		this.globalToLocal(point);

		modal._x = point.x;
		modal._y = point.y;
		modal.width = visibleRect.width;
		modal.height = visibleRect.height;
	}

	private function setFileName(fileName:String):Void
	{
		fileNameInput.text = "";
		fileNameInput.text = resizeFileName(fileNameInput.textField, fileName);
	}

	private function setFileNameFocusEnd(fileName:String):Void
	{
		fileNameInput.text = fileName;
	}

	private function resizeFileName(textField:TextField, fileName:String):String
	{
		var origName:String = fileName;
		var tempName:String;
		textField.text = fileName;

		if (textField.textWidth > (textField._width - 3))
		{
			for (var i:Number = origName.length - 1; i > 0; i--)
			{
				textField.text = origName.slice(0, i) + "..";
				if (textField.textWidth < (textField._width - 3))
				{
					tempName = textField.text;
					return tempName;
				}
			}
		}

		return origName;
	}

	private function onSetImageFileName(data:Object):Void
	{
		loadScreenShot(data.url);
		setFileName(data.fileName);
	}

	private function onSetFileName(data:Object):Void
	{
		setFileName(data.fileName);
	}

	private function onSetFileNameFocusEnd(data:Object):Void
	{
		setFileNameFocusEnd(data.fileName);
	}

	private function onSetImage(data:Object):Void
	{
		loadScreenShot(data.url);
	}

	private function loadScreenShot(url:String):Void
	{
		if (url == undefined || url == null || url == "")
		{
			return;
		}
		if (loader.source == url)
		{
			return;
		}
		bgBtn.visible = false;
		prevBtn.visible = false;
		nextBtn.visible = false;
		loader.source = url;
		loadingMC.gotoAndPlay("open");
	}

	private function onLoaderComplete(e:Object):Void
	{
		bgBtn.visible = true;
		loadingMC.gotoAndStop(1);
		clearInterval(intervalId);
		intervalId = setInterval(this, "onLoadInterval", 2);
	}

	private function onLoadInterval():Void
	{
		clearInterval(intervalId);
		removeBtn._x = loader._x + loader.width - 23 - loader.content._x;
		removeBtn._y = loader._y - 12 + loader.content._y;
	}

	private function onRemoveBtnClick():Void
	{
		ExternalInterface.call("screenShot_OnRemoveBtnClick",tileList_picture.selectedIndex);
		if (_root.designMode)
		{
			var sIndex:Number = tileList_picture.selectedIndex;
			tileList_picture.dataProvider.splice(sIndex,1);
			tileList_picture.invalidate();
			screenShot_SetRemoveSuccess(sIndex);
		}
	}

	private function onZoomBtnClick(e:Object):Void
	{
		zoomBtn.visible = false;
		bgBtn.visible = false;

		oldDisInfo.x = loader.content._x;
		oldDisInfo.y = loader.content._y;
		oldDisInfo.width = loader.content._width;
		oldDisInfo.height = loader.content._height;

		var ratio:Number = Math.min(visibleRect.height / oldDisInfo.height, visibleRect.width / oldDisInfo.width);
		var toWidth:Number = oldDisInfo.width * ratio;
		var toHeight:Number = oldDisInfo.height * ratio;

		var toX:Number = visibleRect.width - toWidth >> 1;
		var toY:Number = visibleRect.height - toHeight >> 1;

		var point:Object = {x:toX, y:toY};
		loader.globalToLocal(point);

		TweenMax.to(loader.content,0.1,{_x:point.x, _y:point.y, _width:toWidth, _height:toHeight, ease:Cubic.easeOut, onComplete:Delegate.create(this, onImgZoomComplete)});

		setResizeModal();
		modal.visible = true;
	}

	private function onImgZoomComplete():Void
	{
		closeBtn.visible = true;

		var toX:Number = loader.content._x + loader.content._width;
		var toY:Number = loader.content._y;

		var point:Object = {x:toX, y:toY};
		loader.localToGlobal(point);
		this.globalToLocal(point);
		closeBtn._x = point.x;
		closeBtn._y = point.y;

		ExternalInterface.call("screenShot_OnZoomInComplete");
	}

	private function onCloseBtnClick():Void
	{
		setImgZoomOut();
	}

	private function setImgZoomOut():Void
	{
		TweenMax.to(loader.content,0.1,{_x:oldDisInfo.x, _y:oldDisInfo.y, _width:oldDisInfo.width, _height:oldDisInfo.height, ease:Cubic.easeIn});
		oldDisInfo = {};

		bgBtn.visible = true;

		closeBtn.visible = false;
		modal.visible = false;

		ExternalInterface.call("screenShot_OnZoomOutComplete");
	}

	private function onCtrlBtnRollOver():Void
	{
		zoomBtn.visible = true;
		removeBtn.visible = true;
		if (tileList_picture.selectedIndex == 0)
		{
			prevBtn.visible = false;
			nextBtn.visible = true;
		}
		else if (tileList_picture.selectedIndex == tileList_picture.dataProvider.length - 1)
		{
			prevBtn.visible = true;
			nextBtn.visible = false;
		}
		else
		{
			prevBtn.visible = true;
			nextBtn.visible = true;
		}
		if (tileList_picture.dataProvider.length == 1)
		{
			prevBtn.visible = false;
			nextBtn.visible = false;
		}
		if (!inputFocused)
		{
			fileNameBtn.visible = true;
			fileNameInput.visible = true;
			fileNameEditBtn.visible = true;
			//|| _root.LanguageIndex == "KOR"
			btnFacebookShot.visible = (_root.NowBranch == "ROOT"|| _root.LanguageIndex == "KOR"|| _root.LanguageIndex == "IDN") ? true : false;
		}
	}

	private function onCtrlBtnRollOut():Void
	{
		zoomBtn.visible = false;
		removeBtn.visible = false;
		prevBtn.visible = false;
		nextBtn.visible = false;
		if (!inputFocused)
		{
			fileNameBtn.visible = false;
			fileNameInput.visible = false;
			fileNameEditBtn.visible = false;
			btnFacebookShot.visible = false;
		}
	}

	private function onPrevBtnClick(e:Object):Void
	{
		tileList_picture.selectedIndex = tileList_picture.selectedIndex - 1;
		listIndex = tileList_picture.selectedIndex;
		tileList_picture.dataProvider.requestItemAt(tileList_picture.selectedIndex,this,"onSetImageFileName");
		ExternalInterface.call("screenShot_OnThumbListItemClick",listIndex);
	}

	private function onNextBtnClick(e:Object):Void
	{
		tileList_picture.selectedIndex = tileList_picture.selectedIndex + 1;
		listIndex = tileList_picture.selectedIndex;
		tileList_picture.dataProvider.requestItemAt(tileList_picture.selectedIndex,this,"onSetImageFileName");
		ExternalInterface.call("screenShot_OnThumbListItemClick",listIndex);
	}

	private function onFileNameInputFocusIn(e:Object):Void
	{
		tileList_picture.dataProvider.requestItemAt(tileList_picture.selectedIndex,this,"onSetFileNameFocusEnd");
		inputFocused = true;
		inputChanged = false;
		canceled = false;
		ExternalInterface.call("screenShot_OnNameInputFocusIn");
	}

	private function onFileNameInputFocusOut(e:Object):Void
	{
		fileNameBtn.visible = true;
		fileNameEditBtn.visible = true;
		fileNameEditDummy.visible = false;

		if (inputChanged && !canceled)
		{
			ExternalInterface.call("screenShot_OnNameInputChange",tileList_picture.selectedIndex,e.target.text);
			if (_root.designMode)
			{
				setFileName(e.target.text);
			}
		}
		if (canceled || !inputChanged)
		{
			tileList_picture.dataProvider.requestItemAt(tileList_picture.selectedIndex,this,"onSetFileName");
		}

		inputFocused = false;
		ExternalInterface.call("screenShot_OnNameInputFocusOut");
	}

	private function onFileNameInputTextChange():Void
	{
		inputChanged = true;
	}

	private function onFileNameEditStartClick(e:Object):Void
	{
		fileNameBtn.visible = false;
		Selection.setFocus(fileNameInput.textField);
		Selection.setSelection(fileNameInput.textField.length,fileNameInput.textField.length);
		e.target.visible = false;
		fileNameEditDummy.visible = true;
	}

	private function onFolderBtnClick():Void
	{
		ExternalInterface.call("screenShot_OnFolderBtnClick");
	}

	private function onListItemClick(e:Object):Void
	{
		if (e.index == listIndex)
		{
			return;
		}
		listIndex = e.index;
		loadScreenShot(e.item.url);
		setFileName(e.item.fileName);
		ExternalInterface.call("screenShot_OnThumbListItemClick",listIndex);
	}

	private function onListItemSelectedSetData(e:Object):Void
	{
		loadScreenShot(e.data.url);
		setFileName(e.data.fileName);
	}

	private function handleInputs(event:Object):Void
	{
		if (event.details.code == Key.ESCAPE)
		{
			canceled = true;
			Selection.setFocus(null);
			FocusHandler.instance.onSetFocus(null);

		}
		else if (event.details.code == Key.ENTER)
		{
			Selection.setFocus(null);
			FocusHandler.instance.onSetFocus(null);

		}
	}

}