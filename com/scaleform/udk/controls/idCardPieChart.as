import gfx.motion.Tween;
import mx.transitions.easing.*;

class com.scaleform.udk.controls.idCardPieChart extends MovieClip
{
	static var item:Array;
	static var itemLen:Number;
	static var totalVal:Number;
	static var totalNum:Number;
	static var plan:Object;
	static var baseColor:Array;
	static var baseColorLen:Number;
	static var nowMemo:Number = NaN;	
	static var tia:Number = 0;
	static var tcolor:Array = ['0xf25a29','0x878680','0x97beb9','0xf2ae4f'];	
	var num:Number;
	var m_back:MovieClip;
	var m_img:MovieClip;
	var myTween:Tween;
	
	public function idCardPieChart ()
	{
		num = Number(this._name);
		//trace("뭐시다냐"+num);
		this._x = plan.x;
		this._y = plan.y;
		this.createEmptyMovieClip('m_back', 1);	
		Draw (m_back);
	}	
	
	function WedgePoint (x:Number, y:Number, ang:Number, arc:Number, xradi:Number, yradi:Number):Array{
		if (arguments.length<5) return;
		var angleMid:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number;
		var points:Array = new Array;		
		if (!yradi) yradi = xradi;
		if (Math.abs(arc)>360) arc = 360;
		var segs = Math.ceil(Math.abs(arc)/45);
		var segAng = arc/segs;
		var theta = -(segAng/180)*Math.PI;
		var angle = -(ang/180)*Math.PI;		
		points.push([x, y]);
		if (segs>0) {
			ax = x+Math.cos(ang/180*Math.PI)*xradi;
			ay = y+Math.sin(-ang/180*Math.PI)*yradi;
			points.push([ax, ay]);
			for (var i = 0; i<segs; i++) {
				angle += theta;
				angleMid = angle-(theta/2);
				bx = x+Math.cos(angle)*xradi;
				by = y+Math.sin(angle)*yradi;
				cx = x+Math.cos(angleMid)*(xradi/Math.cos(theta/2));
				cy = y+Math.sin(angleMid)*(yradi/Math.cos(theta/2));
				points.push([cx, cy, bx, by]);
			}
		}
		return points;
	}
	

	static function Create (d1:Number,d2:Number,d3:Number,d4:Number):Void
	{
		// 초기화
		if (item) delete item;
		item = new Array;
		if (plan) delete plan;
		plan = new Object;
		itemLen = 0;
		totalVal = 0;
		totalNum = 0;
		if (_root.manager.MyInfoContainer.MyInfo.m_pie) removeMovieClip(_root.manager.MyInfoContainer.MyInfo.m_pie);
		_root.manager.MyInfoContainer.MyInfo.createEmptyMovieClip ('m_pie', 1);
		
//		trace("경로"+targetPath(_root));	
//		
		// 생성관련정보
		plan.x = 670
		plan.y = 562		
		plan.xsize = 48;
		plan.ysize = 48;
		plan.maxsize = Math.max(plan.xsize, plan.ysize);		
		plan.ang = 130;
		plan.dang = 3;
		plan.color = ['f2ae4f','97beb9','878680','f25a29'];
		plan.value = [d1,d2,d3,d4];		
		plan.colorLen = plan.color.length;			
		// xml정보 객체화
		itemLen = plan.value.length;
		var per = 0;
		for (var i in plan.value){
			item.unshift ({
				name:plan.name[i],				
				val:plan.value[i],
				per:NaN,
				color:parseInt(plan.color[Number(i)%plan.colorLen], 16)
			});			
			totalVal += plan.value[i];			
		}
		if (per != 100){
			var per = 0;
			for (var i in item){
				item[i].per = Math.round(((item[i].val*100)/totalVal)*100)/100;
				per += item[i].per;
			}
			if (per != 100) item[i].per = ((item[i].per*100)+(10000-(per*100)))/100;
		}		
		// 항목생성
		var temp;
		var tDep;
		var tAng = 0;
		for (var i in item){
			item[i].ang = tAng+plan.ang;
			if (item[i].ang>360) item[i].ang %= 360;
			item[i].arc = item[i].per*3.6;
			if (item[i].arc>360) item[i].arc %= 360;
			item[i].center = (item[i].arc/2)+tAng+plan.ang;
			if (item[i].center>360) item[i].center %= 360;
			item[i].point = com.scaleform.udk.controls.idCardMath.Point ([0,0], (360-item[i].center), plan.maxsize*plan.eDistance);
			if (plan.xsize!=plan.ysize){
				var tper = (plan.ysize/plan.xsize)*100;
				item[i].point[1] = (item[i].point[1]/100)*tper;
			}
			tAng += item[i].arc;
			temp = Math.round(item[i].center);
			if (temp<90) tDep = Number((90-temp)+'1');
			else if (temp<180) tDep = Number((temp-90)+'2');
			else if (temp<270) tDep = Number((temp)+'1');
			else tDep = Number((360-temp+180)+'2');
			temp = Number(i);
			_root.manager.MyInfoContainer.MyInfo.m_pie.attachMovie ('link_pieChart', temp, tDep);
			if (plan.dang) _root.manager.MyInfoContainer.MyInfo.m_pie[temp]._y -= Math.round(plan.dang/2);
		}

	}
	
	
	

	function Draw (pMc:MovieClip, pColor:String):Void
	{		
		//----------------------------------  각 텍스트(헤드샷,킬,도움,사망)의 선 연결위치
		var tx:Array=[-50,-50,35,55];
		var ty:Array=[-51,56,61,-39];			
		pMc._xscale = pMc._yscale = 0;		
		pMc._alpha = 0;
		pMc._rotation = -90;
		Tween.init();
		pMc.tweenTo(0.5,{_alpha:100,_rotation:0,_xscale:100, _yscale:100},Strong.easeOut);		
		var tColor = item[num].color;
		var points = WedgePoint (0, 0, item[num].ang, item[num].arc, plan.xsize, plan.ysize);
		var len = points.length-1;
		if (plan.dang>0){						
			var tDang = plan.dang;
			var tColor2 = tColor-0x111111;				
			pMc.moveTo (points[0][0], points[0][1]+tDang);
			pMc.beginFill(tColor2);
			pMc.lineTo (points[1][0], points[1][1]+tDang);
			for (var i=2; i<=len; i++){
				pMc.curveTo (points[i][0], points[i][1]+tDang, points[i][2], points[i][3]+tDang);
			}
			pMc.lineTo (points[0][0], points[0][1]+tDang);			
			pMc.endFill();				
			pMc.moveTo (points[0][0], points[0][1]);
			pMc.beginFill(tColor2);
			pMc.lineTo (points[0][0], points[0][1]+tDang);
			pMc.lineTo (points[1][0], points[1][1]+tDang);
			pMc.lineTo (points[1][0], points[1][1]);
			pMc.lineTo (points[0][0], points[0][1]);
			pMc.lineTo (points[1][0], 0);
			pMc.endFill();			
			pMc.beginFill(tColor2);
			pMc.moveTo (points[0][0], points[0][1]);
			pMc.lineTo (points[0][0], points[0][1]+tDang);
			pMc.lineTo (points[len][2], points[len][3]+tDang);
			pMc.lineTo (points[len][2], points[len][3]);
			pMc.lineTo (points[0][0], points[0][1]);
			pMc.endFill();			
			var sa = item[num].ang;
			var ca = item[num].center;
			var ea = item[num].ang+item[num].arc;
			if (sa<0) sa += 360;
			if (ea<0) ea += 360;
			if (sa<180&&ea>180) var sp = com.scaleform.udk.controls.idCardMath.Point ([0,0], 180, plan.xsize);
			if (ea>360) var ep = com.scaleform.udk.controls.idCardMath.Point ([0,0], 0, plan.xsize);
			if (sp||ep){
				if (!sp) var sp = [0,0];
				if (!ep) var ep = [0,0];
				pMc.moveTo (0, 0);
				pMc.beginFill(tColor2);
				pMc.lineTo (sp[0], sp[1]);
				pMc.lineTo (sp[0], tDang);
				pMc.lineTo (ep[0], tDang);
				pMc.lineTo (ep[0], ep[1]);
				pMc.endFill();
			}
		}
		pMc.moveTo (points[0][0], points[0][1]);
		pMc.beginFill(tColor);
		pMc.lineTo (points[1][0], points[1][1]);
		for (var i=2; i<=len; i++){
			pMc.curveTo (points[i][0], points[i][1], points[i][2], points[i][3]);
		}
		pMc.lineTo (points[0][0], points[0][1]);
		pMc.endFill();
		
		
		//-------------------------------------- 파이의 값과 해당 정보와의 선 연결하기
		//-------------------------------------- 2012-7-23
		//-------------------------------------- 파이의 중심점을 찾아서 연결하여야 됨
				
		/*pMc.lineStyle(1, tcolor[tia],100);
		pMc.moveTo (Number(points[1][0]), Number(points[1][1])); //값의 경계 위치
		//pMc.moveTo (Number(points[0][0]), Number(points[0][1])); //파이의 중심 위치
		pMc.lineTo (tx[tia], ty[tia]);
		pMc.endFill();
		tia += 1;*/		
	}
	
	
	static function setDeleteChart(){
		tia = 0;
		removeMovieClip(_root.manager.MyInfoContainer.MyInfo.m_pie);		 
	}
}

