import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Assets;
import nme.Lib;

// 自機クラス
class MyShip extends Mover {

  static inline var SPEED_PER_SECOND = 180.0;
  public static inline var BULLET_RATE = 10.0;

  var windowWidth : Float;
  var windowHeight : Float;

  public function new () {
    
    setGraphic ("images/MyShip.png");
    
    windowWidth = Common.width; windowHeight = Common.height;
    
    super (windowWidth / 2.0, windowHeight - 100.0, graphic);
    hp = 100;
    hitRange = 20.0;
  }

  override public function update () {
    if (KeyboardInput.pressedUp && cy >= 0.0)
      setY (cy - SPEED_PER_SECOND / Lib.stage.frameRate);
    if (KeyboardInput.pressedDown && cy <= windowHeight)
      setY (cy + SPEED_PER_SECOND / Lib.stage.frameRate);
    if (KeyboardInput.pressedLeft && cx >= 0.0)
      setX (cx - SPEED_PER_SECOND / Lib.stage.frameRate);
    if (KeyboardInput.pressedRight && cx <= windowWidth)
      setX (cx + SPEED_PER_SECOND / Lib.stage.frameRate);
    
  }
}