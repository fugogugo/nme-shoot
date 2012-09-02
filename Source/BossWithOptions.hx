import Enemy;
import nme.Lib;

class BossBody extends Enemy {

  static inline var graphicPath = "images/BossBody.png";

  static var frameCount = 0;

  public function new (initX : Float, initY : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 30.0;
    hp = 130;
    score = 10000;

    setScale (3.0);
    setX (Common.width / 2.0);
  }

  override public function update () {
    if (frameCount / Lib.stage.frameRate <= 6.0)
      setY (cy + 20.0 / Lib.stage.frameRate);
    else if (frameCount / Lib.stage.frameRate >= 8.0)
      setX (Math.sin (frameCount / Lib.stage.frameRate / 2.0 - 8.0 /2.0) * 100.0 + Common.width / 2.0);

    frameCount++;

  }
}

class BossOption extends Enemy {
  static inline var maxAngleRate : Float = 50.0;
  
  static inline var graphicPath = "images/BossOption.png";

  static var frameCount = 0;

  public function new (initX : Float, initY : Float, initAngle : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 10.0;
    hp = 5;
    score = 10;
    setAngle (initAngle);
  }

  override public function update () {
    var angle = - Math.atan2 (GameObjectManager.myShip.cx - cx, GameObjectManager.myShip.cy - cy) * 180 / Math.PI;

    if (angle - this.angle < -maxAngleRate / Lib.stage.frameRate)
      angle = this.angle - maxAngleRate / Lib.stage.frameRate;
    else if (angle - this.angle > maxAngleRate / Lib.stage.frameRate)
      angle = this.angle + maxAngleRate / Lib.stage.frameRate;

    setAngle (angle);
    setX (cx - Math.sin (this.angle/ 180 * Math.PI) * 2.0 * 60 / Lib.stage.frameRate);
    setY (cy + Math.cos (this.angle / 180 * Math.PI) * 2.0 * 60 / Lib.stage.frameRate);
  }
}

class BossOptionsFormation extends EnemyFormation {

  public function new () {
    super ();
    addEnemy (new BossOption (0.0, -10.0, 50.0));
    addEnemy (new BossOption (100.0, -10.0, 30.0));
    addEnemy (new BossOption (200.0, -10.0, 15.0));
    addEnemy (new BossOption (300.0, -10.0, 0.0));
    addEnemy (new BossOption (400.0, -10.0, -15.0));
    addEnemy (new BossOption (500.0, -10.0, -30.0));
    addEnemy (new BossOption (600.0, -10.0, -50.0));

    addEnemy (new BossOption (50.0, -30.0, 40.0));
    addEnemy (new BossOption (150.0, -30.0, 10.0));
    addEnemy (new BossOption (250.0, -30.0, 5.0));
    addEnemy (new BossOption (350.0, -30.0, -5.0));
    addEnemy (new BossOption (450.0, -30.0, -10.0));
    addEnemy (new BossOption (550.0, -30.0, -40.0));
  }
}

class BossWithOptions extends EnemyFormation {

  public function new () {
    super ();
    addEnemy (new BossBody (0.0, 0.0));

    frameCount = 0;
  }
}