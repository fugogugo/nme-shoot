import Enemy;

// ボス本体
class BossBody extends Enemy {

  static inline var GRAPHIC_PATH = "images/BossBody.png";
  static inline var MOVING_WIDTH = 100.0;
  static inline var MOVING_HEIGHT = 120.0;
  static inline var SLIDE_START_SEC = 8.0;
  static inline var MOVING_Y_SEC = 6.0;

  var weaponChange : Bool;

  public function new (initX : Float, initY : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic, 0.0);
    hitRange = 95.0;
    hp = 1000;
    score = 10000;

    x = Common.WIDTH / 2.0;
    weaponChange = false;
  }

  override function appearedUpdate (scene : Scene) {
    super.appearedUpdate (scene);
    if (Common.perFrameRate (frameCount ()) <= MOVING_Y_SEC)
      y += Common.perFrameRate (MOVING_HEIGHT / MOVING_Y_SEC);
    else if (Common.perFrameRate (frameCount ()) >= SLIDE_START_SEC)
      x = Math.sin (Common.perFrameRate (frameCount ()) - SLIDE_START_SEC)
        * MOVING_WIDTH + Common.WIDTH / 2.0;

    // HPが500までは誘導弾での攻撃、500以下になったら旋回弾の攻撃に変更
    if (active && GameObjectManager.myShip.active && hp > 500) {
      if ((frameCount () + 1) % (2.0 * Common.getFrameRate ()) == 0)
        BossOptionsPattern.addEnemies (scene, x, y + graphic.height/2.0);
      if ((frameCount () + 1) % (3.0 * Common.getFrameRate ()) == 0)
        BossOptionsPattern.addEnemies (scene, x, y + graphic.height/2.0 - 20.0);

      if ((frameCount () + 1) % (5.0 * Common.getFrameRate ()) == 0)
        BossOptionsPattern.addEnemies (scene, x, y + graphic.height/2.0 - 40.0);

      if ((frameCount () + 1) % (10.0 * Common.getFrameRate ()) == 0)
        BossOptionsPattern.addEnemies (scene, x, y + graphic.height/2.0 - 60.0);

    }
    else if (active && GameObjectManager.myShip.active) {
      if (!weaponChange) {
        GameObjectManager.removeAllEnemies (scene);
        GameObjectManager.addEnemy (scene, this);
        weaponChange = true;
      }
      var anglePerBullet = 6.0;
      if (frameCount () % (2/60 * Common.getFrameRate ()) == 0) {
      
        var directionAngle = (frameCount () % (360 * anglePerBullet / Common.getFrameRate () * 60.0)) * anglePerBullet * Common.perFrameRate (60);
        SpiralBulletsPattern.addEnemies (scene, x + 30.0, y, directionAngle - 20.0);
      
        SpiralBulletsPattern.addEnemies (scene, x - 30.0, y, -directionAngle + 20.0);
      }
    }

    if (hp <= 0 && GameObjectManager.myShip.active)
      GameObjectManager.removeAllEnemies (scene);
  }
}

// ボスの誘導弾
class BossOption extends Enemy {
  static inline var MAX_ANGLE_RATE : Float = 40.0;
  static inline var SPEED_PER_SECOND = 240.0;
  
  static inline var GRAPHIC_PATH = "images/BossOption.png";

  public function new (initX : Float, initY : Float, initRotation : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic, 0.0);
    hitRange = 15.0;
    hp = 5;
    score = 10;
    isCollisionWithBullet = false;
    rotation = initRotation;
  }

  override function appearedUpdate (scene : Scene) {
    super.appearedUpdate (scene);
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

  public function new (initX : Float, initY : Float,
                       directionAngle : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic, 0.0);
    hitRange = 15.0;
    isCollisionWithBullet = false;
    this.directionAngle = directionAngle;
  }

  override function appearedUpdate (scene : Scene) {
    super.appearedUpdate (scene);
    x -= Math.sin (Common.degToRad (this.directionAngle)) * Common.perFrameRate (SPEED_PER_SECOND);
    y += Math.cos (Common.degToRad (this.directionAngle)) * Common.perFrameRate (SPEED_PER_SECOND);
  }
}


// ボスの誘導弾の攻撃
class BossOptionsPattern {
  public static function addEnemies (scene : Scene, initX : Float, initY : Float) {
    GameObjectManager.addEnemy (scene, new BossOption (initX-50.0, initY-10.0, 50.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX-40.0, initY-10.0, 30.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX-20.0, initY-10.0, 15.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX, initY-10.0, 0.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX+20.0, initY-10.0, -15.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX+40.0, initY-10.0, -30.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX+50.0, initY-10.0, -50.0));
    
    GameObjectManager.addEnemy (scene, new BossOption (initX-50.0, initY-50.0, 70.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX-50.0, initY-40.0, 60.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX-50.0, initY-30.0, 55.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX+50.0, initY-30.0, -55.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX+50.0, initY-40.0, -60.0));
    GameObjectManager.addEnemy (scene, new BossOption (initX+50.0, initY-50.0, -70.0));
  }
}

// ボスの旋回弾の攻撃
class SpiralBulletsPattern {
  public static function addEnemies (scene : Scene, initX : Float, initY : Float, directionAngle : Float) {
    GameObjectManager.addEnemy (scene, new SpiralBullet (initX, initY, directionAngle));
  }
}