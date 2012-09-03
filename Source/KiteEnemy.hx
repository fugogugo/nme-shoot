import nme.Lib;
import Enemy;

// 凧型の敵
class KiteEnemy extends Enemy {

  static inline var graphicPath = "images/Enemy01.png";

  var speedPerSecond : Float;

  var random : Bool;

  public function new (initX : Float, initY : Float, speedPerSecond : Float) {
    setGraphic (graphicPath);
    super (initX, initY, graphic);
    hitRange = 15.0;
    hp = 3;
    score = 10;
    this.speedPerSecond = speedPerSecond;
    random = Std.random (2) == 1;
  }

  override public function update (scene : Scene) {
    if (random)
      x = x + Math.cos (y/speedPerSecond) * 2.0;
    else
      x = x - Math.cos (y/speedPerSecond) * 2.0;
    y = y + speedPerSecond / Common.frameRate;
  }
}

class KiteEnemyFormation extends EnemyFormation {

  var relativeX : Float;
  var relativeY : Float;
  
  public function new (initX : Float, initY : Float, appearanceSec : Float) {
    super ();

    relativeX = initX;
    relativeY = initY;
    this.appearanceSec = appearanceSec;

    addEnemy ( new KiteEnemy (relativeX, relativeY, Std.random (50) + 100.0));
    addEnemy ( new KiteEnemy (relativeX + 60.0, relativeY + 20.0, Std.random (50) + 130.0));
    addEnemy ( new KiteEnemy (relativeX + 90.0, relativeY + 10.0, Std.random (50) + 90.0));
    addEnemy ( new KiteEnemy (relativeX + 120.0, relativeY + 20.0, Std.random (50) + 130.0));
    addEnemy ( new KiteEnemy (relativeX + 180.0, relativeY, Std.random (50) + 100.0));
  }
}