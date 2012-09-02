import nme.display.Sprite;
import nme.Lib;

// 敵クラス
class Enemy extends Mover {

  public var score (default, null) : Int;

  function new (initX:Float, initY:Float, graphic:Sprite) {
    
    score = 0;

    this.graphic = graphic;

    super (initX, initY, graphic);
    visible = false;
    active = false;
  }
}

// 複数の敵をまとめて処理するクラス
class EnemyFormation extends Mover {

  public var enemies (default, null) : Array<Enemy>;
  var appearanceSec (default, null) : Float;
  var frameCount : Int;

  function new () {
    enemies = new Array<Enemy> ();
    graphic = new Sprite ();
    appearanceSec = 0.0;
    frameCount = 0;
    super (0.0, 0.0, graphic);
    active = false;
    visible = false;
  }

  override public function update () {

    if (appearanceSec <= frameCount / Lib.stage.frameRate) {

      for (enemy in enemies) {
        enemy.visible = true;
        enemy.active = true;
        enemy.update ();
        if (!enemy.active) removeEnemy (enemy);
      }
      active = true;
      visible = true;
    }
    else {
      visible = false;
      for (enemy in enemies)
        enemy.visible = false;
    }
    frameCount++;
  }

  public function detectCollisionWithBullet (scene : GameScene, bullet:Bullet) {
    for (enemy in enemies) {
      if (enemy.isHit (bullet)) {
        enemy.hp -= bullet.power;
        GameObjectManager.removeBullet (scene, bullet);
        if (enemy.hp <= 0) {
          enemy.active = false;
          removeEnemy (enemy);
          GameObjectManager.totalScore += enemy.score;
        }
      }
    }
    if (enemies.length <= 0) {
      active = false;
      GameObjectManager.removeEnemyFormation (scene, this);
    }
  }

  public function deleteOutsideEnemy (scene : GameScene) {
    for (enemy in enemies) {
      if ( enemy.cx < -100.0 || enemy.cx > Common.width + 100.0
           || enemy.cy < -100.0 || enemy.cy > Common.height + 100.0 ) {
        removeEnemy (enemy);
      }
    }
    if (enemies.length <= 0) {
      GameObjectManager.removeEnemyFormation (scene, this);

    }
  }

  public function addEnemy (enemy : Enemy) {
    enemies.push (enemy);
    addChild (enemy);
  }

  public function removeEnemy (enemy : Enemy) {
    enemies.remove (enemy);
    removeChild (enemy);
  }
}
