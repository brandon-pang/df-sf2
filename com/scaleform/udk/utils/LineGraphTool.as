
/**
 *  LineGraph.
 *
 *  @author webbug
 */ 
class com.scaleform.udk.utils.LineGraphTool extends MovieClip
{
    
    private var posArray:Array = new Array()	
	private var triangle_mc:MovieClip;
	private var oriData:Array = new Array()
	private var count:Number = 0;
	private var txt_tran:TextField;

	public function LineGraphTool()
	{
		super();
		//로컬화를 위한 텍스트 필드 
		this.createTextField("txt_tran", 1, 100, -1000, 400, 100);
		txt_tran.text="_clanhome_month_rank_no";
	}
	
	
/*arr = [{xName:"12월", value:"20", overText:"January"},
	   {xName:"1월", value:"600", overText:"January"},
	   {xName:"2월", value:"1400", overText:"January"},
	   {xName:"4월", value:"1000", overText:"January"},
	   {xName:"5월", value:"990", overText:"January"},
	   {xName:"6월", value:"1000", overText:"January"}, 
	   {xName:"7월", value:"700", overText:"January"}];*/
	
	public function setMainBox(lineData:Array, boxX:Number, boxY:Number, boxWid:Number, boxHei:Number)
    {
		resetGraph()
		
		//포지션 맞추기 박스그리기
		oriData = lineData			
		posArray = []		
		var data:Array = lineData;	
		var dataMax = chkDataNull(oriData);
		if (dataMax >= 6) {
			data=[]
		}
		var x = boxX;
		var y = boxY;
		var w = boxWid;
		var h = boxHei;
		//5칸으로 나눔
		var vDNo = 20;
		var hDNo = data.length;		
		var dataValue= setDataMax();		
		
		var ymi=5	
		var yMax = Number(dataValue.max);
		var yMin = Number(dataValue.min);
		
		var vDiv = h / (vDNo - 1);
		var hDiv = w / (hDNo - 1);
		

		this.createEmptyMovieClip("triangle_mc",this.getNextHighestDepth());
		triangle_mc._x = x;
		triangle_mc._y = y;
		//lineStyle(thickness:Number, rgb:Number, alpha:Number, pixelHinting:Boolean)
		triangle_mc.lineStyle(2,0x336600,100,true);
		triangle_mc.moveTo(0,0);
		triangle_mc.lineTo(w,0);
		triangle_mc.lineTo(w,h);
		triangle_mc.lineTo(0,h);
		triangle_mc.lineTo(0,0);
		//=============================
		var noneTxt = triangle_mc.attachMovie("noneTxt", "noneTxt", 1000);				
		triangle_mc.noneTxt._visible=false
		triangle_mc.noneTxt._y=-1000
		
		if(data.length==0||data.length==null){		
			triangle_mc.noneTxt._visible = true;
			noneTxt.textField.htmlText=noneTxt.textField.text
			noneTxt.bg._width=noneTxt.textField.textWidth+30
			noneTxt.bg._height=noneTxt.textField.textHeight+20
			noneTxt._x=(w/2)
			noneTxt._y=((h/2)-(noneTxt.bg._height/2))
			
		}
		
		for (var i:Number = 0; i < vDNo; i++)
		{
			var vMc = triangle_mc.createEmptyMovieClip("vLine" + i, 10 + i);
			vMc.lineStyle(1,0x666666,20,true);
			vMc.moveTo(0,vDiv * i);
			vMc.lineTo(0,vDiv * i);
			vMc.lineTo(w,vDiv * i);
		}

		for (var a:Number = 0; a < hDNo; a++)
		{
			var hMc = triangle_mc.createEmptyMovieClip("hLine" + a, 50 + a);
			hMc.lineStyle(1,0x666666,40,true);
			hMc.moveTo(hDiv * a,0);
			hMc.lineTo(hDiv * a,0);
			hMc.lineTo(hDiv * a,h);

			var xTxt = triangle_mc.attachMovie("midText", "xTxt", 850 + a);
			xTxt._x = hDiv * a;
			xTxt._y = h + 12;
			xTxt.textField.text = data[a].xName;
			
			var pBtn = triangle_mc.attachMovie("poBtn", "poz" + a, 500 + a);
			pBtn._x = hDiv * a;
			var valueNo
			if (data[a].value=="-1") {
				valueNo=h
			}else {
				valueNo= (h * ((data[a].value-(yMin-ymi)) / ((yMax+ymi)-(yMin-ymi))))
			}
			pBtn._y =valueNo
			
		
			var overTxt = triangle_mc.attachMovie("overTxt", "overTxt"+a, 900 + a);
			overTxt._x=hDiv*a;
			overTxt._y=-1000
			overTxt.textField.text=data[a].xName + ", "+data[a].value+txt_tran.text			
			
			if (data[a].value!="-1") {
				pBtn.onRollOver = function() {				
					var n = this._name.substr(-1)
					var p:MovieClip = this._parent._parent.triangle_mc
					p["overTxt"+n].bg._width=p["overTxt"+n].textField.textWidth+30
					p["overTxt" + n]._y = this._y - 18;
					trace (p["overTxt" + n]._y )
				}
				pBtn.onRollOut=function(){
					var n = this._name.substr(-1)
					var p:MovieClip = this._parent._parent.triangle_mc
					p["overTxt"+n]._y=-1000
				}
				pBtn.onReleaseOutside=function(){
					var n = this._name.substr(-1)
					var p:MovieClip = this._parent._parent.triangle_mc
					p["overTxt"+n]._y=-1000
				}		
			}
			
			posArray.push({x:pBtn._x, y:pBtn._y});		
		}
		setLine(posArray);
	}

	private function setLine(data:Array)
	{
		var d = data;
		for (var a:Number = 0; a < d.length-1; a++)
		{
			var pLine = triangle_mc.createEmptyMovieClip("poLine" + a, 100 + a);
			pLine.lineStyle(2,0x996600,100,true);
			pLine.moveTo(d[a].x,d[a].y);
			pLine.lineTo(d[a + 1].x,d[a + 1].y);
		}
	}
	
	private function chkDataNull(data):Number {
		var d = data
		for (var a:Number = 0; a < d.length; a++)
		{
			if (d[a].value == "-1") {
				count++
			}
		}		
		return count
		
	}
	private function setDataMax():Object
	{
		var d = oriData;
		var a=[]
		for (var i:Number = 0; i < d.length ; i++) {
			a.push(oriData[i].value)
			trace (oriData[i].value)
		}
		
		a.sort(16);

		var max = a[a.length - 1]
		var min = a[0]
		
		var obj = new Object();
		obj.max = max;
		obj.min = min;
		
		return obj;
	}
	
	private function resetGraph() {
		count=0
		posArray = new Array();
		oriData  = new Array();
		
		for (var i:Number = 0; i < 10; i++)
		{
			triangle_mc["vLine" + i].removeMovieClip()
			triangle_mc["hLine" + i].removeMovieClip()
			triangle_mc["xTxt"].removeMovieClip()
			triangle_mc["poz" + i].removeMovieClip()
			triangle_mc["overTxt" + i].removeMovieClip()
			triangle_mc["poLine" + i].removeMovieClip()
		}
		return;
	}

//setMainBox(arr,100,0,500,400);


	
}
