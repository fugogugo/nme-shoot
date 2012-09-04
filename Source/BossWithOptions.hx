import Enemy;
import nme.Lib;

class BossBody extends Enemy {

  static inline var graphicPath = "images/BossBody.png";
  static inline var movingWidth = 100.0;
  static inline var movingHeight = 120.0;
  static inline var slideStartSec = 8.0;
  static inline var movingYSec = 6.0;

  var frameCount : Int;

  public function new (initX : Float, initY : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 95.0;
    hp = 1000;
    score = 10000;
    frameCount = 0;

    x = Common.width / 2.0;
  }

  override public function update (scene : Scene) {
    if (Common.perFrameRate (frameCount) <= movingYSec)
      y += Common.perFrameRate (movingHeight / movingYSec);
    else if (Common.perFrameRate (frameCount) >= slideStartSec)
      x = Math.sin (Common.perFrameRate (frameCount) - slideStartSec)
        * movingWidth + Common.width / 2.0;

    frameCount++;

  }
}

class BossOption extends Enemy {
  static inline var maxAngleRate : Float = 40.0;
  static inline var SPEED_PER_SECOND = 240.0;
  
  static inline var graphicPath = "images/BossOption.png";

  var frameCount : Int;

  public function new (initX : Float, initY : Float, initAngle : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 15.0;
    hp = 5;
    score = 10;
    frameCount = 0;
    isCollisionWithBullet = false;
    setAngle (initAngle);
  }

  override public function update (scene : Scene) {
    var angle = -Common.radToDeg (Math.atan2 (GameObjectManager.myShip.x - x, GameObjectManager.myShip.y - y));

    if (angle - this.angle < Common.perFrameRate (-maxAngleRate))
      angle = this.angle - Common.perFrameRate (maxAngleRate);
    else if (angle - this.angle > Common.perFrameRate (maxAngleRate))
      angle = this.angle + Common.perFrameRate (maxAngleRate);

    setAngle (angle);
    x -= Math.sin (Common.degToRad (this.angle)) * Common.perFrameRate (SPEED_PER_SECOND);
    y += Math.cos (Common.degToRad (this.angle)) * Common.perFrameRate (SPEED_PER_SECOND);
  }
}


// 旋回弾
class SpiralBullet extends Enemy {
  static inline var SPEED_PER_SECOND = 200.0;
  var directionAngle : Float;
  
  static inline var graphicPath = "images/SpiralBullet.png";

  static var frameCount = 0;

  public function new (initX : Float, initY : Float, directionAngle : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 15.0;
    isCollisionWithBullet = false;
    this.directionAngle = directionAngle;
  }

  override public function update (scene : Scene) {

    x -= Math.sin (Common.degToRad (this.directionAngle)) * Common.perFrameRate (SPEED_PER_SECOND);
    y += Math.cos (Common.degToRad (this.directionAngle)) * Common.perFrameRate (SPEED_PER_SECOND);
  }
}


// ボスの誘導弾の攻撃
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

// ボスの旋回弾の攻撃
class SpiralBulletFormation extends EnemyFormation {

  public function new (initX:Float, initY:Float, directionAngle : Float) {
    super ();
    
    addEnemy (new SpiralBullet (initX, initY, directionAngle));
  }
}

// ボス
class BossWithOptions extends EnemyFormation {

  var bossBody : BossBody;
  var weaponChange : Bool;

  public function new () {
    super ();
    bossBody = new BossBody (0.0, 0.0);
    addEnemy (bossBody);

    frameCount = 0;
    weaponChange = false;
  }

  override public function update (scene : Scene) {
    super.update (scene);
    // HPが500までは誘導弾での攻撃、500以下になったら旋回弾の攻撃に変更
    if (bossBody.active && GameObjectManager.myShip.active && bossBody.hp > 500) {
      if (frameCount % (2.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0));
      if (frameCount % (3.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 20.0));

      if (frameCount % (5.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 40.0));

      if (frameCount % (10.0 * Common.frameRate) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 60.0));

    }
    else if (bossBody.active && GameObjectManager.myShip.active) {
      if (!weaponChange) {
        GameObjectManager.removeAllEnemyFormations (scene);
        GameObjectManager.addEnemyFormation (scene, this);
        weaponChange = true;
      }
      var perAngle = 6.0;
      if (frameCount % (2/60 * Common.frameRate) == 0) {
      
        var directionAngle = (frameCount % (360 * perAngle / Common.frameRate * 60.0)) * perAngle * Common.perFrameRate (60);
      GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x + 30.0, bossBody.y, directionAngle - 20.0));
      
      GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x - 30.0, bossBody.y, -directionAngle + 20.0));
      }

      if (frameCount %  (Common.frameRate * 50/60) == 0) {
        GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x + 50.0, bossBody.y + bossBody.graphic.height / 2.0, -10.0));
        GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x - 50.0, bossBody.y + bossBody.graphic.height / 2.0, -10.0));
        GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x + 50.0, bossBody.y + bossBody.graphic.height / 2.0, 10.0));
        GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x - 50.0, bossBody.y + bossBody.graphic.height / 2.0, 10.0));
      }
    }

    
    if (bossBody.hp <= 0 && GameObjectManager.myShip.active)
      GameObjectManager.removeAllEnemyFormations (scene);
  }
}