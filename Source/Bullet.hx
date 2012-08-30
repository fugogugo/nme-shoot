import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

class Bullet extends Mover {
  private static inline var SPEED_PER_SECOND = 500.0;

  public function new (x:Float, y:Float) {
    
    setGraphic ("images/Bullet01.png");
    super (x, y, graphic);

    hp = 0;
    power = 1;
    hitRange = 10.0;
  }

  override public function update () {
    setY (cy - SPEED_PER_SECOND / Lib.stage.frameRate);
  }
}