import nme.Lib;

import Enemy;

class GameObjectManager {
    
  public static var myShip : MyShip;
  
  public static var bullets : Array<Bullet> = new Array<Bullet> ();
  public static var enemyFormations : Array<EnemyFormation> = new Array<EnemyFormation> ();
  
  public static var totalScore : Int = 0;

  public static var frameCountForBullet : Float = 0;

  public static function fireBullet (scene : GameScene) {
    myShip.fireBullet (scene);
  }

  public static function deleteOutsideObject (scene : GameScene) {
    deleteOutsideBullet (scene);
    deleteOutsideEnemy (scene);
  }

  static function deleteOutsideBullet (scene : GameScene) {
    for (bullet in bullets) {
      bullet.deleteOutsideBullet (scene);
    }
  }

  static function deleteOutsideEnemy (scene : GameScene) {
    for (enemyFormation in enemyFormations) {
      enemyFormation.deleteOutsideEnemy (scene);
    }
  }

  public static function removeBullet (scene : GameScene, bullet : Bullet) {
    bullets.remove (bullet);
    scene.removeChild (bullet);
  }

  public static function addEnemyFormation (scene : GameScene, enemyFormation : EnemyFormation) {
    enemyFormations.push (enemyFormation);
    scene.addChild (enemyFormation);
  }

  public static function removeEnemyFormation (scene : GameScene, enemyFormation : EnemyFormation) {
    enemyFormations.remove (enemyFormation);
    scene.removeChild (enemyFormation);
  }

  // 当たり判定の処理
  public static function detectCollision (scene : GameScene) {
    for (bullet in bullets) {
      for (enemyFormation in enemyFormations) {
        enemyFormation.detectCollisionWithBullet (scene, bullet);
      }
    }

    if (myShip.active) {
      for (enemyFormation in enemyFormations) {
        for (enemy in enemyFormation.enemies) {
          myShip.detectCollisionWithEnemy (scene, enemy);
        }
      }
    }
  }
}