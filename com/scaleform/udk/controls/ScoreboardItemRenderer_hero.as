import gfx.utils.Delegate;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import gfx.controls.Button;
//import com.scaleform.udk.controls.FocusItemRenderer;
import gfx.controls.CoreList;
import gfx.controls.ListItemRenderer;
import mx.transitions.easing.Strong;
import gfx.motion.Tween;
import gfx.utils.Constraints;

[InspectableList("disabled", "visible", "labelID", "disableConstraints")]
class com.scaleform.udk.controls.ScoreboardItemRenderer_hero extends ListItemRenderer
{
	private var levelTxt:TextField;
	private var codename:TextField;
	private var defence:TextField;
	private var offense:TextField;
	private var movement:TextField;
	private var kill:TextField;
	private var beastKill:TextField;
	private var score:TextField;
	private var ping:MovieClip;
	private var _ping:String;
	private var pingTxt:TextField;
	private var iconMeMc:MovieClip;
	private var imgIcon:MovieClip;
	private var deathBg:MovieClip;
	private var respawn:TextField;
	private var _pingTxt:String;
	private var mcLoader:MovieClipLoader;
	private var _imgPathPersonal:String = "img://Imgset_Personal.";
	
	
	public function ScoreboardItemRenderer_hero() {
		super();
		
		mcLoader = new MovieClipLoader();
	}

	public function setData(data:Object):Void {
		if (data == undefined) {
			this._visible = false;
			return;
		}

		this.data = data;
		invalidate();

		this._visible = true;

		super.setData(data);
		_pingTxt=data.PingTxt;

		UpdateTextFields();
	}

	private function lvLoader():Void {
		
		mcLoader.loadClip(_imgPathPersonal+data.ImgSet, imgIcon);
	}

	// This method is fired after the state has changed to allow the component to ensure the state is up-to-date.  For instance, updating the contraints in Button.
	private function updateAfterStateChange():Void {
		if (!initialized) {
			return;
		}

		if (constraints != null) {
			constraints.update(width,height);
		}
		dispatchEvent({type:"stateChange", state:state});
	}


	private function configUI():Void
	{
		constraints = new Constraints(this, true);

		if (!_disableConstraints) {
			constraints.addElement(textField,Constraints.ALL);
		}
		
		this.disableFocus = true;

		if (focusIndicator != null && !_focused && focusIndicator._totalframes == 1) {
			focusIndicator._visible = false;
		}
		focusTarget = owner;
		pingTxt.verticalAlign="center";
		pingTxt.textAutoSize="shrink";
	}

	// Private Methods:    
	private function UpdateTextFields()
	{
		lvLoader();
		
		if (data.MeIcon) { iconMeMc.gotoAndPlay("open"); }
		else { iconMeMc.gotoAndStop(2); }
		
		if (data.MeDeath == "" || data.MeDeath == null)
		{
			deathBg.gotoAndStop(2);
			respawn.text = "";
		}
		else
		{
			deathBg.gotoAndStop("open");
			respawn.text = data.MeDeath;
		}
		
		levelTxt.text = data.Level;
		codename.htmlText = data.CodeName;
		defence.text = data.Defence;
		offense.text = data.Offense;
		movement.text = data.Movement;
		kill.text = data.Kill + " / " + data.Assist + " / " + data.Death;
		beastKill.text = data.BeastKill;
		score.text = data.Score;
		ping.gotoAndStop(Number(data.Ping)+1);
		_ping=data.Ping

		if(_pingTxt==null||_pingTxt==""){
			pingTxt._visible=false;
			pingTxt.text="";
			ping._x=401
			pingTxt._x=364
		}else{
			pingTxt._visible=true;
			pingTxt.text=_pingTxt;
			ping._x=390;
			pingTxt._x=398;

			if(Number(_ping) == 0){
				pingTxt.textColor=0xFF0101;
			}else if(Number(_ping) == 1){
				pingTxt.textColor=0xFF9C00;
			}else if(Number(_ping) >= 2){				
				pingTxt.textColor=0x24F600;
			}
		}
	}
}