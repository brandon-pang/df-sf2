import gfx.controls.Button;

class com.scaleform.HtmlImgButton extends Button {

	// Private Properties:    
	private var _label:String;

	// UI Elements: 
	public var textField:TextField;// Addiutional text field for CustomButton 
	// Initialization 
	public function HtmlImgButton() {
		super();
	}
	// Public Methods: 
	public function get label():String {
		return _label;
	}
	public function set label(value:String):Void {
		_label = value;
		if (textField != null) {
			textField.htmlText = _label;
		}
		// Set the text first 
		if (_autoSize && textField != null && initialized) {// When the label changes, if autoSize is true, and there is a textField, we want to resize the component to fit the label.  The only exception is when the label is set during initialization.
			__width = _width=calculateWidth();
		}
		updateAfterStateChange();// This helps keep the button up to date.
	}

}