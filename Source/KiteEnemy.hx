import nme.Lib;
import Enemy;

// 凧型の敵
class KiteEnemy extends Enemy {
  private var speedPerSecond : Float;

  private var random : Bool;

  public function new (initX : Float, initY : Float, speedPerSecond : Float) {
    setGraphic ("images/Enemy01.png");
    super (initX, initY, graphic);
    hitRange = 10.0;
    hp = 7;
    score = 10;
    this.speedPerSecond = speedPerSecond;
    random = Std.random (2) == 1;
  }

  override public function update () {
    if (random)
      setX (cx + Math.cos (cy/speedPerSecond) * 2.0);
    else
      setX (cx - Math.cos (cy/speedPerSecond) * 2.0);
    setY (cy + speedPerSecond / Lib.stage.frameRate);
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
    addEnemy ( new KiteEnemy (relativeX + 120.0, relativeY + 10.0, Std.random (50) + 110.0));
  }
}