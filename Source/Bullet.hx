import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

class Bullet extends Mover {
  static inline var SPEED_PER_SECOND = 500.0;

  public function new (x:Float, y:Float, angle:Float) {
    
    setGraphic ("images/Bullet01.png");
    super (x, y, graphic);

    hp = 0;
    power = 1;
    hitRange = 10.0;
    setAngle (angle);
  }

  override public function update (scene : Scene) {
    x += Math.sin (Common.degToRad (this.angle)) * Common.perFrameRate (SPEED_PER_SECOND);
    y -= Math.cos (Common.degToRad (this.angle)) * Common.perFrameRate (SPEED_PER_SECOND);
  }

  public function deleteOutsideBullet (scene : Scene) {
    if (x < -50.0 || x > Common.width + 50.0
        || y < -50.0 || y > Common.height + 50.0 ) {
      GameObjectManager.removeBullet (scene, this);
    }
  }
}
