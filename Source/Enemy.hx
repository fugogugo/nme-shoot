import nme.display.Sprite;
import nme.Lib;

// 敵クラス
class Enemy extends Mover {

  public var score (default, null) : Int;

  public var isCollisionWithBullet : Bool;
  public var isCollisionWithMyShip : Bool;

  function new (initX:Float, initY:Float, graphic:Sprite) {
    
    score = 0;

    this.graphic = graphic;

    super (initX, initY, graphic);
    visible = false;
    active = false;
    isCollisionWithBullet = true;
    isCollisionWithMyShip = true;
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

  override public function update (scene : Scene) {

    if (appearanceSec <= Common.perFrameRate (frameCount)) {

      for (enemy in enemies) {
        enemy.visible = true;
        enemy.active = true;
        enemy.update (scene);
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

  public function detectCollisionWithBullet (scene : Scene, bullet:Bullet) {
    for (enemy in enemies) {
      if (enemy.isCollisionWithBullet && enemy.isCollision (bullet)) {
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

  public function detectCollisionWithMyShip (scene : Scene) {
    for (enemy in enemies) {
      if (enemy.isCollisionWithMyShip && GameObjectManager.myShip.isCollision (enemy)) {
        GameObjectManager.myShip.hp -= power;
        if (GameObjectManager.myShip.hp <= 0) {
          GameObjectManager.myShip.active = false;
          scene.removeChild (GameObjectManager.myShip);
        }
      }
    }
  }

  public function deleteOutsideEnemy (scene : Scene) {
    for (enemy in enemies) {
      if ( enemy.x < -100.0 || enemy.x > Common.width + 100.0
           || enemy.y < -100.0 || enemy.y > Common.height + 100.0 ) {
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
