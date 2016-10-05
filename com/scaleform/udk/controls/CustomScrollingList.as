import gfx.controls.ScrollingList;

class com.scaleform.udk.controls.CustomScrollingList extends ScrollingList {
   var boo:Boolean;
    public function CustomScrollingList() {
        super();
    }

    public function updateDisabled() {
        for (var i:Number = 0; i < renderers.length; i++) {
			trace (typeof(dataProvider[i].isDisabled))
			
			if(dataProvider[i].isDisabled=="1"){
				boo=true
			}else{
				boo=false
			}
			
            getRendererAt(i).disabled  = boo
        }
    }

    public function draw()
    {
        super.draw();
        updateDisabled();         
    }
}