import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Assets;
import com.eclecticdesignstudio.control.KeyBinding;
import nme.ui.Keyboard;

// 自機クラス
class MyShip extends Mover {

  static inline var SPEED = 5.0;

  var windowHeight : Float;
  var windowWidth : Float;

  // キーの状態
  private var pressedUp : Bool;
  private var pressedDown : Bool;
  private var pressedLeft : Bool;
  private var pressedRight : Bool;

  public function new ( windowWidth : Float, windowHeight : Float ) {
    this.windowHeight = windowHeight; this.windowWidth = windowWidth;

    var bitmap = new Bitmap (Assets.getBitmapData ("images/MyShip.png"));
    var graphic = new Sprite ();
    graphic.addChild (bitmap);

    super (windowWidth / 2.0, windowHeight - 100.0, graphic);

    pressedUp = false;
    pressedDown = false;
    pressedLeft = false;
    pressedRight = false;


    KeyBinding.addOnPress (Keyboard.UP, keyboard_onPressUp);
    KeyBinding.addOnPress (Keyboard.DOWN, keyboard_onPressDown);
    KeyBinding.addOnRelease (Keyboard.UP, keyboard_onReleaseUp);
    KeyBinding.addOnRelease (Keyboard.DOWN, keyboard_onReleaseDown);
    KeyBinding.addOnPress (Keyboard.LEFT, keyboard_onPressLeft);
    KeyBinding.addOnPress (Keyboard.RIGHT, keyboard_onPressRight);
    KeyBinding.addOnRelease (Keyboard.LEFT, keyboard_onReleaseLeft);
    KeyBinding.addOnRelease (Keyboard.RIGHT, keyboard_onReleaseRight);
  }

  private function keyboard_onPressUp () : Void { pressedUp = true; }
  private function keyboard_onPressDown () : Void { pressedDown = true; }
  private function keyboard_onReleaseUp () : Void { pressedUp = false; }
  private function keyboard_onReleaseDown () : Void { pressedDown = false; }
  private function keyboard_onPressLeft () : Void { pressedLeft = true; }
  private function keyboard_onPressRight () : Void { pressedRight = true; }
  private function keyboard_onReleaseLeft () : Void { pressedLeft = false; }
  private function keyboard_onReleaseRight () : Void { pressedRight = false; }

  override public function update () {
    if (pressedUp && cy >= 0.0) setY (cy - SPEED);
    if (pressedDown && cy <= windowHeight) setY (cy + SPEED);
    if (pressedLeft && cx >= 0.0) setX (cx - SPEED);
    if (pressedRight && cx <= windowWidth) setX (cx + SPEED);
  }
}