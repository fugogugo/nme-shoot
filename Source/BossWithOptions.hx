import Enemy;

// ボス本体
class BossBody extends Enemy {

  static inline var GRAPHIC_PATH = "images/BossBody.png";
  static inline var MOVING_WIDTH = 100.0;
  static inline var MOVING_HEIGHT = 120.0;
  static inline var SLIDE_START_SEC = 8.0;
  static inline var MOVING_Y_SEC = 6.0;

  public function new (initX : Float, initY : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic);
    hitRange = 95.0;
    hp = 1000;
    score = 10000;

    x = Common.WIDTH / 2.0;
  }

  override public function update (scene : Scene) {
    super.update (scene);
    if (Common.perFrameRate (frameCount ()) <= MOVING_Y_SEC)
      y += Common.perFrameRate (MOVING_HEIGHT / MOVING_Y_SEC);
    else if (Common.perFrameRate (frameCount ()) >= SLIDE_START_SEC)
      x = Math.sin (Common.perFrameRate (frameCount ()) - SLIDE_START_SEC)
        * MOVING_WIDTH + Common.WIDTH / 2.0;
  }
}

// ボスの誘導弾
class BossOption extends Enemy {
  static inline var MAX_ANGLE_RATE : Float = 40.0;
  static inline var SPEED_PER_SECOND = 240.0;
  
  static inline var GRAPHIC_PATH = "images/BossOption.png";

  public function new (initX : Float, initY : Float, initRotation : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic);
    hitRange = 15.0;
    hp = 5;
    score = 10;
    isCollisionWithBullet = false;
    rotation = initRotation;
  }

  override public function update (scene : Scene) {
    super.update (scene);
    var angle = -Common.radToDeg (Math.atan2 (GameObjectManager.myShip.x - x, GameObjectManager.myShip.y - y));

    if (angle - this.rotation < Common.perFrameRate (-MAX_ANGLE_RATE))
      angle = this.rotation - Common.perFrameRate (MAX_ANGLE_RATE);
    else if (angle - this.rotation > Common.perFrameRate (MAX_ANGLE_RATE))
      angle = this.rotation + Common.perFrameRate (MAX_ANGLE_RATE);

    rotation = angle;
    x -= Math.sin (Common.degToRad (this.rotation)) * Common.perFrameRate (SPEED_PER_SECOND);
    y += Math.cos (Common.degToRad (this.rotation)) * Common.perFrameRate (SPEED_PER_SECOND);
  }
}


// 旋回弾
class SpiralBullet extends Enemy {
  static inline var SPEED_PER_SECOND = 200.0;
  var directionAngle : Float;
  
  static inline var GRAPHIC_PATH = "images/SpiralBullet.png";

  public function new (initX : Float, initY : Float, directionAngle : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic);
    hitRange = 15.0;
    isCollisionWithBullet = false;
    this.directionAngle = directionAngle;
  }

  override public function update (scene : Scene) {
    super.update (scene);
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

    weaponChange = false;
  }

  override public function update (scene : Scene) {
    super.update (scene);

    hp = bossBody.hp;

    // HPが500までは誘導弾での攻撃、500以下になったら旋回弾の攻撃に変更
    if (bossBody.active && GameObjectManager.myShip.active && bossBody.hp > 500) {
      if ((frameCount () + 1) % (2.0 * Common.getFrameRate ()) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0));
      if ((frameCount () + 1) % (3.0 * Common.getFrameRate ()) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 20.0));

      if ((frameCount () + 1) % (5.0 * Common.getFrameRate ()) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 40.0));

      if ((frameCount () + 1) % (10.0 * Common.getFrameRate ()) == 0)
        GameObjectManager.addEnemyFormation (scene, new BossOptionsFormation (bossBody.x, bossBody.y + bossBody.graphic.height/2.0 - 60.0));

    }
    else if (bossBody.active && GameObjectManager.myShip.active) {
      if (!weaponChange) {
        GameObjectManager.removeAllEnemyFormations (scene);
        GameObjectManager.addEnemyFormation (scene, this);
        weaponChange = true;
      }
      var anglePerBullet = 6.0;
      if (frameCount () % (2/60 * Common.getFrameRate ()) == 0) {
      
        var directionAngle = (frameCount () % (360 * anglePerBullet / Common.getFrameRate () * 60.0)) * anglePerBullet * Common.perFrameRate (60);
      GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x + 30.0, bossBody.y, directionAngle - 20.0));
      
      GameObjectManager.addEnemyFormation (scene, new SpiralBulletFormation (bossBody.x - 30.0, bossBody.y, -directionAngle + 20.0));
      }
    }

    if (bossBody.hp <= 0 && GameObjectManager.myShip.active)
      GameObjectManager.removeAllEnemyFormations (scene);
  }
}