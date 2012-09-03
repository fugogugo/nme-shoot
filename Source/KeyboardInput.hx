import com.eclecticdesignstudio.control.KeyBinding;
import nme.ui.Keyboard;

class KeyboardInput {
  
  public static var pressedUp : Bool = false;
  public static  var pressedDown : Bool = false;
  public static var pressedLeft : Bool = false;
  public static var pressedRight : Bool = false;

  public static var pressedZ : Bool = false;
  public static var pressedX : Bool = false;

  // キーイベントの登録
  public static function initialize () {
    KeyBinding.addOnPress (Keyboard.UP, keyboard_onPressUp);
    KeyBinding.addOnPress (Keyboard.DOWN, keyboard_onPressDown);
    KeyBinding.addOnRelease (Keyboard.UP, keyboard_onReleaseUp);
    KeyBinding.addOnRelease (Keyboard.DOWN, keyboard_onReleaseDown);
    KeyBinding.addOnPress (Keyboard.LEFT, keyboard_onPressLeft);
    KeyBinding.addOnPress (Keyboard.RIGHT, keyboard_onPressRight);
    KeyBinding.addOnRelease (Keyboard.LEFT, keyboard_onReleaseLeft);
    KeyBinding.addOnRelease (Keyboard.RIGHT, keyboard_onReleaseRight);

    KeyBinding.addOnPress ("z", keyboard_onPressZ);
    KeyBinding.addOnRelease ("z", keyboard_onReleaseZ);
    KeyBinding.addOnPress ("x", keyboard_onPressX);
    KeyBinding.addOnRelease ("x", keyboard_onReleaseX);
  }

  static function keyboard_onPressUp () : Void { pressedUp = true; }
  static function keyboard_onPressDown () : Void { pressedDown = true; }
  static function keyboard_onReleaseUp () : Void { pressedUp = false; }
  static function keyboard_onReleaseDown () : Void { pressedDown = false; }
  static function keyboard_onPressLeft () : Void { pressedLeft = true; }
  static function keyboard_onPressRight () : Void { pressedRight = true; }
  static function keyboard_onReleaseLeft () : Void { pressedLeft = false; }
  static function keyboard_onReleaseRight () : Void { pressedRight = false; }

  static function keyboard_onPressZ () : Void { pressedZ = true; }
  static function keyboard_onReleaseZ () : Void { pressedZ = false; }
  static function keyboard_onPressX () : Void { pressedX = true; }
  static function keyboard_onReleaseX () : Void { pressedX = false; }
}