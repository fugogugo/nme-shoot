import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

class Bullet extends Mover {
  static inline var SPEED_PER_SECOND = 500.0;

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

  public function deleteOutsideBullet (scene : GameScene) {
    if (cx < -50.0 || cx > Common.width + 50.0
        || cy < -50.0 || cy > Common.height + 50.0 ) {
      GameObjectManager.removeBullet (scene, this);
    }
  }
}