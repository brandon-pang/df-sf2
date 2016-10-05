import gfx.controls.ButtonBar;
class com.scaleform.udk.controls.UnitButtonBar extends ButtonBar
{
	// Initialization:
	public function UnitButtonBar()
	{
		super();
	}

	private function draw():Void
	{
		if (!reflowing) {
			// Update current buttons
			var l:Number = _dataProvider.length;
			while (renderers.length>l)
			{
				var r:MovieClip = MovieClip(renderers.pop());
				r.group.removeButton(r);
				r.removeMovieClip();
			}
			while (renderers.length<l)
			{
				renderers.push(createRenderer(renderers.length));
			}

			populateData();
			reflowing = true;
			invalidate();
			return;
		}
		if (drawLayout() && _selectedIndex != -1) {
			selectItem(_selectedIndex);
		}
		renderers.label = itemToLabel(_dataProvider[l]);
		renderers.labelTwo = itemToLabel(_dataProvider[l].labelTwo);
		renderers.data = _dataProvider[l];
		renderers.disabled = _disabled;
	}
}