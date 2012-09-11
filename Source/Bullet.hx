
class Bullet extends Mover {
  static inline var SPEED_PER_SECOND = 500.0;

  public function new (x:Float, y:Float, rotation:Float) {
    
    setGraphic ("images/Bullet01.png");
    super (x, y, graphic);

    hp = 0;
    power = 1;
    hitRange = 10.0;
    this.rotation = rotation;
  }

  override public function update (scene : Scene) {
    x += Math.sin (Common.degToRad (this.rotation)) * Common.perFrameRate (SPEED_PER_SECOND);
    y -= Math.cos (Common.degToRad (this.rotation)) * Common.perFrameRate (SPEED_PER_SECOND);
  }

  public function deleteOutsideBullet (scene : Scene) {
    if (x < -50.0 || x > Common.WIDTH + 50.0
        || y < -50.0 || y > Common.HEIGHT + 50.0 ) {
      GameObjectManager.removeBullet (scene, this);
    }
  }
}
