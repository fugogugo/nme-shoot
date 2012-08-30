import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Assets;
import com.eclecticdesignstudio.control.KeyBinding;
import nme.ui.Keyboard;
import nme.Lib;

// 自機クラス
class MyShip extends Mover {

  static inline var SPEED_PER_SECOND = 180.0;
  public static inline var BULLET_RATE = 10.0;

  var windowWidth : Float;
  var windowHeight : Float;

  // キーの状態
  var pressedUp : Bool;
  var pressedDown : Bool;
  var pressedLeft : Bool;
  var pressedRight : Bool;

  
  public function new () {

    setGraphic ("images/MyShip.png");

    #if (html5 || js)
    windowWidth = Lib.current.width; windowHeight = Lib.current.height;
    #else
    windowWidth = Lib.initWidth; windowHeight = Lib.initHeight;
    #end
    super (windowWidth / 2.0, windowHeight - 100.0, graphic);


    pressedUp = false;
    pressedDown = false;
    pressedLeft = false;
    pressedRight = false;

    hp = 100;
    hitRange = 20.0;
  }

  override public function update () {
    if (pressedUp && cy >= 0.0)
      setY (cy - SPEED_PER_SECOND / Lib.stage.frameRate);
    if (pressedDown && cy <= windowHeight)
      setY (cy + SPEED_PER_SECOND / Lib.stage.frameRate);
    if (pressedLeft && cx >= 0.0)
      setX (cx - SPEED_PER_SECOND / Lib.stage.frameRate);
    if (pressedRight && cx <= windowWidth)
      setX (cx + SPEED_PER_SECOND / Lib.stage.frameRate);
  }

  public function keyboard_onPressUp () : Void { pressedUp = true; }
  public function keyboard_onPressDown () : Void { pressedDown = true; }
  public function keyboard_onReleaseUp () : Void { pressedUp = false; }
  public function keyboard_onReleaseDown () : Void { pressedDown = false; }
  public function keyboard_onPressLeft () : Void { pressedLeft = true; }
  public function keyboard_onPressRight () : Void { pressedRight = true; }
  public function keyboard_onReleaseLeft () : Void { pressedLeft = false; }
  public function keyboard_onReleaseRight () : Void { pressedRight = false; }
}