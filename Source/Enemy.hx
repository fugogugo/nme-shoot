import nme.display.Sprite;

using Lambda;

// 敵クラス
class Enemy extends Mover {

  public var score (default, null) : Int;

  public var isCollisionWithBullet (default, null) : Bool;

  function new (initX:Float, initY:Float, graphic:Sprite) {
    
    score = 0;

    this.graphic = graphic;

    super (initX, initY, graphic);
    visible = false;
    active = false;
    isCollisionWithBullet = true;
  }

}


// 複数の敵をまとめて処理するクラス
class EnemyFormation extends Mover {

  var enemies (default, null) : Array<Enemy>;
  var nonCollisionEnemies (default, null) : Array<Enemy>;
  var appearanceSec (default, null) : Float;

  function new () {
    enemies = new Array<Enemy> ();
    nonCollisionEnemies = new Array<Enemy> ();
    graphic = new Sprite ();
    appearanceSec = 0.0;
    super (0.0, 0.0, graphic);
    active = false;
    visible = false;
  }

  override public function update (scene : Scene) {
    super.update (scene);

    if (appearanceSec <= Common.perFrameRate (frameCount ())) {
      var enemyUpdate = function (enemy : Enemy) {
        enemy.visible = true;
        enemy.active = true;
        enemy.update (scene);
      };

      enemies.iter (enemyUpdate);
      nonCollisionEnemies.iter (enemyUpdate);
      active = true;
      visible = true;
    }
    else {
      visible = false;
      var visibleFalse = function (enemy : Enemy) { enemy.visible = false; };
      enemies.iter (visibleFalse);
      nonCollisionEnemies.iter (visibleFalse);
    }
  }

  public function detectCollisionWithBullet (scene : Scene, bullet:Bullet) {
    for (enemy in enemies) {
      if (enemy.isCollisionWithBullet && enemy.isCollision (bullet)) {
        enemy.hp -= bullet.power;
        enemy.collisionEffect (scene);
        bullet.collisionEffect (scene);
        GameObjectManager.removeBullet (scene, bullet);
        if (enemy.hp <= 0) {
          enemy.active = false;
          enemy.removeEffect (scene);
          removeEnemy (enemy);
          GameObjectManager.totalScore += enemy.score;
        }
      }
    }
    if (enemies.length <= 0 && nonCollisionEnemies.length <= 0) {
      active = false;
      GameObjectManager.removeEnemyFormation (scene, this);
    }
  }

  public function detectCollisionWithMyShip (scene : Scene) {
    var collisionProcedure = function (enemy : Enemy) {
      if (GameObjectManager.myShip.isCollision (enemy)) {
        GameObjectManager.myShip.hp -= enemy.power;
        GameObjectManager.myShip.collisionEffect (scene);
        if (GameObjectManager.myShip.hp <= 0) {
          GameObjectManager.myShip.active = false;
          GameObjectManager.myShip.removeEffect (scene);
          if (scene.contains (GameObjectManager.myShip))
            scene.removeChild (GameObjectManager.myShip);
        }
      }
    }

    enemies.iter (collisionProcedure);
    nonCollisionEnemies.iter (collisionProcedure);
  }

  public function deleteOutsideEnemy (scene : Scene) {

    var outsideLength = 100.0;
    var deleteEnemy = function (enemy : Enemy) {
      if ( enemy.x < -outsideLength || enemy.x > Common.WIDTH + outsideLength
           || enemy.y < -outsideLength || enemy.y > Common.HEIGHT + outsideLength )
        removeEnemy (enemy);
    }

    enemies.iter (deleteEnemy);
    nonCollisionEnemies.iter (deleteEnemy);

    if (enemies.length <= 0 && nonCollisionEnemies.length <= 0)
      GameObjectManager.removeEnemyFormation (scene, this);
  }

  public function addEnemy (enemy : Enemy) {
    if (enemy.isCollisionWithBullet)
      enemies.push (enemy);
    else
      nonCollisionEnemies.push (enemy);
    addChild (enemy);
  }

  public function removeEnemy (enemy : Enemy) {
    nonCollisionEnemies.remove (enemy);
    enemies.remove (enemy);
    if (contains (enemy))
      removeChild (enemy);
  }
}
