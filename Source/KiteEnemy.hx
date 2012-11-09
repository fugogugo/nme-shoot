import Enemy;

// 凧型の敵
class KiteEnemy extends Enemy {

  static inline var GRAPHIC_PATH = "images/Enemy01.png";

  var speedPerSecond : Float;

  var random : Bool;

  function updateProc () {
    if (random)
      x += Math.cos (y/speedPerSecond) * Common.perFrameRate (120.0);
    else
      x -= Math.cos (y/speedPerSecond) * Common.perFrameRate (120.0);
    y += Common.perFrameRate (speedPerSecond);
  }

  public function new (initX : Float, initY : Float, appearanceSec : Float, speedPerSecond : Float) {
    setGraphicPath (GRAPHIC_PATH);
    super (initX, initY, graphic, appearanceSec, updateProc);
    hitRange = 15.0;
    hp = 10;
    score = 10;
    this.speedPerSecond = speedPerSecond;
    random = Std.random (2) == 1;
  }
}

// 凧型の敵を追加するクラス
class KiteEnemiesPattern {
  public static function addEnemies (scene : Scene, initX : Float, initY : Float, appearanceSec : Float) {
    GameObjectManager.addEnemy (scene,
                                new KiteEnemy (initX, initY, appearanceSec, Std.random (50) + 100.0));
    GameObjectManager.addEnemy (scene,
                                new KiteEnemy (initX + 60.0, initY + 20.0, appearanceSec, Std.random (50) + 130.0));
    GameObjectManager.addEnemy (scene,
                                new KiteEnemy (initX + 90.0, initY + 10.0, appearanceSec, Std.random (50) + 90.0));
    GameObjectManager.addEnemy (scene,
                                new KiteEnemy (initX + 120.0, initY + 20.0, appearanceSec, Std.random (50) + 130.0));
    GameObjectManager.addEnemy (scene,
                                new KiteEnemy (initX + 180.0, initY, appearanceSec, Std.random (50) + 100.0));
  }
}