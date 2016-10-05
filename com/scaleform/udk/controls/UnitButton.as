import gfx.controls.Button;

class com.scaleform.udk.controls.UnitButton extends Button
{

	// Private Properties:   
	private var _labelTwo:String;

	// UI Elements:
	public var textField2:TextField;// Addiutional text field for CustomButton

	// Initialization
	public function UnitButton()
	{
		super();
	}

	// Public Methods:

	// Set, Get methods for our new label.
	public function get labelTwo():String
	{
		return _label;
	}
	public function set labelTwo(value:String):Void
	{
		_labelTwo = value;
		if (textField2 != null) {
			textField2.text = _labelTwo;
		}
		// Set the text first 
		if (_autoSize && textField2 != null && initialized) {
			__width = _width=calculateWidth();
		}
		updateAfterStateChange();// This helps keep the button up to date.
	}
}