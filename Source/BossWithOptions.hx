import Enemy;
import nme.Lib;

class BossBody extends Enemy {

  static inline var graphicPath = "images/BossBody.png";

  static var frameCount = 0;

  public function new (initX : Float, initY : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 95.0;
    hp = 1000;
    score = 10000;

    x = Common.width / 2.0;
  }

  override public function update (scene : Scene) {
    var slideStartSec = 8.0;
    if (frameCount / Common.frameRate <= 6.0)
      y = y + 20.0 / Common.frameRate;
    else if (frameCount / Common.frameRate >= slideStartSec)
      x = Math.sin (frameCount / Common.frameRate - slideStartSec)/2.0 * 100.0 + Common.width / 2.0;

    frameCount++;

  }
}

class BossOption extends Enemy {
  static inline var maxAngleRate : Float = 40.0;
  static inline var speed = 4.0;
  
  static inline var graphicPath = "images/BossOption.png";

  static var frameCount = 0;

  public function new (initX : Float, initY : Float, initAngle : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 10.0;
    isCollisionWithBullet = false;
    hp = 5;
    score = 10;
    setAngle (initAngle);
  }

  override public function update (scene : Scene) {
    var angle = - Math.atan2 (GameObjectManager.myShip.x - x, GameObjectManager.myShip.y - y) * 180 / Math.PI;

    if (angle - this.angle < -maxAngleRate / Common.frameRate)
      angle = this.angle - maxAngleRate / Common.frameRate;
    else if (angle - this.angle > maxAngleRate / Common.frameRate)
      angle = this.angle + maxAngleRate / Common.frameRate;

    setAngle (angle);
    x = x - Math.sin (this.angle/ 180 * Math.PI) * speed * 60 / Common.frameRate;
    y = y + Math.cos (this.angle / 180 * Math.PI) * speed * 60 / Common.frameRate;
  }
}

class BossOptionsFormation extends EnemyFormation {

  public function new (initX:Float, initY:Float) {
    super ();
    addEnemy (new BossOption (initX-50.0, initY-10.0, 50.0));
    addEnemy (new BossOption (initX-40.0, initY-10.0, 30.0));
    addEnemy (new BossOption (initX-20.0, initY-10.0, 15.0));
    addEnemy (new BossOption (initX, initY-10.0, 0.0));
    addEnemy (new BossOption (initX+20.0, initY-10.0, -15.0));
    addEnemy (new BossOption (initX+40.0, initY-10.0, -30.0));
    addEnemy (new BossOption (initX+50.0, initY-10.0, -50.0));
    
    addEnemy (new BossOption (initX-50.0, initY-50.0, 70.0));
    addEnemy (new BossOption (initX-50.0, initY-40.0, 60.0));
    addEnemy (new BossOption (initX-50.0, initY-30.0, 55.0));
    addEnemy (new BossOption (initX+50.0, initY-30.0, -55.0));
    addEnemy (new BossOption (initX+50.0, initY-40.0, -60.0));
    addEnemy (new BossOption (initX+50.0, initY-50.0, -70.0));
    
  }
}


class BossWithOptions extends EnemyFormation {

  var bossBody : BossBody;

  public function new () {
    super ();
    bossBody = new BossBody (0.0, 0.0);
    addEnemy (bossBody);

    frameCount = 0;
  }

  override public function update (scene : Scene) {
    super.update (scene);
    if (bossBody.active && GameObjectManager.myShip.active) {
      if (frameCount % (2.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0));
      if (frameCount % (5.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 40.0));

      if (frameCount % (9.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 30.0));

      if (frameCount % (18.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 50.0));

    }

  }
}