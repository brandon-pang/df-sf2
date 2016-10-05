/**
 * ...
 * @author 
 */

import gfx.core.UIComponent;
 
class com.scaleform.udk.dialogs.EventDialogDetailContListCont extends UIComponent
{	
	private var arrangPosY:Number = 0;
	private var contArr:Array = [];
	
	private var txtColor:String = "#000000";
	
	public function EventDialogDetailContListCont()
	{         
		super();
	}
    
    public function initContents():Void
    {
    	removeAllList();
    }
    
    public function setContents(data:Array):Void
    {
    	removeAllList();
    	
    	for (var i:Number=0; i<data.length; i++)
    	{
    		switch (data[i].type)
    		{
    			case "explain":
    		
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsExplain", "eventDialogListContentsExplain"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			cont.titleTxt.noTranslate = true;
	    			if (data[i].percent >= 0 && data[i].percent < 20) { txtColor = "#a64000"; }
					else if (data[i].percent >= 20 && data[i].percent < 60) { txtColor = "#2da601"; }
					else if (data[i].percent >= 60 && data[i].percent < 100) { txtColor = "#0066a6"; }
					else if (data[i].percent == 100) { txtColor = "#2c2c2c"; }
					else if (data[i].percent == -1) { txtColor = "#000000"; }
	    			cont.titleTxt.htmlText = "<font color='"+txtColor+"' size='18'>"+data[i].title.slice(0,1)+"</font>"+"<font color='"+txtColor+"' size='14'>"+data[i].title.slice(1);+"</font>";
	    			cont.contentTxt.autoSize = true;
	    			cont.contentTxt.noTranslate = true;
	    			cont.contentTxt.htmlText = data[i].contents;
	    			cont.bg._height = cont.contentTxt._y + Math.round(cont.contentTxt._height) + 12;
	    			
	    			contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
	    			
	    			break;
    		
    			case "progress":
    			
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsProgress", "eventDialogListContentsProgress"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			cont.titleTxt.autoSize = true;
	    			cont.contentTxt.autoSize = true;
	    			cont.contentTxt.noTranslate = true;
	    			cont.contentTxt.text = data[i].contents;
	    			cont.titleTxt._x = cont.bg._width - (cont.titleTxt._width + cont.contentTxt._width) >> 1;
	    			cont.contentTxt._x = cont.titleTxt._x + Math.round(cont.titleTxt._width);
	    			
	    			contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
    				
    				break;
    			case "gauge":
    			
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsGauge", "eventDialogListContentsGauge"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			cont.totalTxt.verticalAlign = "center";
	    			cont.totalTxt.noTranslate = true;
	    			cont.totalTxt.textAutoSize="shrink";
	    			cont.totalTxt.text = data[i].total.toString();
	    			cont.mask._width = cont.bar._width * data[i].score / data[i].total;
	    			cont.score.textField.verticalAlign = "center";
	    			cont.score.textField.noTranslate = true;
	    			cont.score.textField.textAutoSize="shrink";
	    			cont.score.textField.text = data[i].score.toString();
	    			cont.score._x = cont.mask._x + cont.mask._width;
	    			
	    			contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
    				
    				break;
    			
    			case "attendance":
    				
    				if (data[i].data == null || data[i].data.length == 0) { return; }
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsAttendance", "eventDialogListContentsAttendance"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			
	    			var column:Number = 5;
	    			
	    			for (var m:Number=0; m<data[i].data.length; m++)
					{
						var row:Number = Math.floor(m/column);
						var btn:MovieClip = cont.attachMovie(
																"eventDialogListContentsAttendanceBtn",
																"eventDialogListContentsAttendanceBtn"+m,
																cont.getNextHighestDepth()
															);
						if (row%2 == 0)
						{
							btn._x = 35+39*(m%column);
							btn.arrow._rotation = 0;
						}
						else
						{
							btn._x = 35+39*((column-1)-(m%column));
							btn.arrow._rotation = 180;
						}
						btn._y = 29+41*row;
						if (m%column == column-1) { btn.arrow._rotation = 90; }
						if (m == data[i].data.length-1) { btn.arrow._visible = false; }
						
						if (data[i].data[m].complete == true)
						{
							btn.ok.gotoAndStop("show");
						}
						else
						{
							if (data[i].data[m].gift == true) { btn.gift.gotoAndStop("show"); }
							
							if (m == 0 || data[i].data[m-1].complete == true)
							{
								btn.select.gotoAndStop("show");
							}
						}
						
						if (data[i].data[m].tooltip != "" && data[i].data[m].tooltip != null) { btn.tooltip = data[i].data[m].tooltip; }
					}
	    			
	    			cont.start.textField.autoSize = "center";
	    			cont.start.textField.verticalAlign = "center";
	    			cont.start.textField.textAutoSize="shrink";
	    			cont.start.textField.text = "_eventSystem_start";
	    			cont.start.bg._width = cont.start.textField._width + 12;
	    			cont.start.swapDepths(cont.getNextHighestDepth());
	    			
	    			cont.inframe._height = cont._height - 7;
	    			cont.frame._height = cont._height + 14;
	    			cont.bg._height = cont._height + 13;
	    			
	    			contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
	    			
	    			break;
    				
    			case "attendanceLink":
    			
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsAttendanceLink", "eventDialogListContentsAttendanceLink"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			
	    			contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
	    			
	    			break;
    			
    			case "character":
    			
	    			if (data[i].data == null || data[i].data.length == 0) { return; }
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsChar", "eventDialogListContentsChar"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			
					var column:Number = 4;
					var row:Number = Math.ceil(data[i].data.length/column);
					var itemLength:Number = column * row;
					
					for (var l:Number=0; l<itemLength; l++)
					{
						var char:MovieClip = cont.attachMovie(
																"eventDialogListContentsCharMC",
																"eventDialogListContentsCharMC"+l,
																cont.getNextHighestDepth(),
																{
																	_x:24+53*(l%column),
																	_y:34+52*(Math.floor(l/column))
																}
															);
						char.titleTxt.verticalAlign = "center";
						char.titleTxt.textAutoSize="shrink";
						char.titleTxt.noTranslate = true;
						if (data[i].data[l] != null)
						{
							if (data[i].data[l].complete)
							{
								char.titleTxt.textColor = 0x502903;
								char.bg.gotoAndStop(3);
							}
							else
							{
								char.bg.gotoAndStop(2);
							}
							char.titleTxt.text = data[i].data[l].title;
						}
					}
	    			
	    			cont.frame._height = cont._height + 31;
	    			cont.bg._height = cont._height + 13;
	    			
	    			contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
	    			
	    			break;
    			
    			case "item":
    			
	    			if (data[i].data == null || data[i].data.length == 0) { return; }
	    			var cont:MovieClip = this.attachMovie("eventDialogListContentsItem", "eventDialogListContentsItem"+i, this.getNextHighestDepth(), {_y:arrangPosY});
	    			
					var column:Number = 3;
					var row:Number = Math.ceil(data[i].data.length/column);
					var itemLength:Number = column * row;
					
					for (var k:Number=0; k<itemLength; k++)
					{
						var item:MovieClip = cont.attachMovie(
																"eventDialogRewardItem",
																"eventDialogRewardItem"+k,
																cont.getNextHighestDepth(),
																{
																	_x:11+77*(k%column),
																	_y:24+59*(Math.floor(k/column))
																}
															);
						if (data[i].data[k] != null) { item.data = data[i].data[k]; }
						else { item.disabled = true; }
					}
					
					cont.bg._height = cont._height + 8;
					
					contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
	    			
	    			break;
	    		
	    		case "attendanceCheck":
    				
    				if (data[i].data == null || data[i].data.length == 0) { return; }
    				var cont:MovieClip = this.attachMovie("eventDialogListContentsAttendanceCheck", "eventDialogListContentsAttendanceCheck"+i, this.getNextHighestDepth(), {_y:arrangPosY});
    				
    				var column:Number = 3;
					var row:Number = Math.ceil(data[i].data.length/column);
					var itemLength:Number = column * row;
					
					for (var l:Number=0; l<itemLength; l++)
					{
						var item:MovieClip = cont.attachMovie(
																"eventDialogContentsAttendanceItem",
																"eventDialogContentsAttendanceItem"+l,
																cont.getNextHighestDepth(),
																{
																	_x:10+77*(l%column),
																	_y:7+81*(Math.floor(l/column))
																}
															);
						
						if (data[i].data[l] != null)
						{
							item.data = data[i].data[l];
							
							if (Math.floor(l/column)%2 == 0) { item.bg.gotoAndStop(2); }
							else { item.bg.gotoAndStop(3); }
							
							if (data[i].data[l].Complete)
							{
								item.stamp.gotoAndStop(2);
							}
							else
							{
								if (l != 0 && data[i].data[l-1].Complete == true)
								{
									cont["eventDialogContentsAttendanceItem"+(l-1)].stamp.gotoAndStop(3);
								}
							}
						}
						else
						{
							item.disabled = true;
							item.bg.gotoAndStop(1);
						}
						
					}
    				
	    			cont.frame._height = cont._height + 6;
	    			cont.bg._height = cont._height + 13;
    				
    				contArr.push(cont);
	    			arrangPosY = cont._y + cont._height - 6;
    				
    				break;
    		}
    	}
    	
    	dispatchEvent({type:"resizeContents"});
    }
    
    private function configUI():Void
    {
    	super.configUI();
	}
	
	private function removeAllList():Void
	{
    	for (var i:Number=0; i<contArr.length; i++)
    	{
    		contArr[i].removeMovieClip();
    	}
    	arrangPosY = 0;
    	contArr = [];
    	this._y = 0;
    	dispatchEvent({type:"resizeContents"});
	}
}