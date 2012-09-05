import nme.Lib;

import Enemy;

class GameObjectManager {
    
  public static var myShip : MyShip;
  
  public static var bullets : Array<Bullet> = new Array<Bullet> ();
  public static var enemyFormations : Array<EnemyFormation> = new Array<EnemyFormation> ();
  
  public static var totalScore : Int = 0;

  public static var frameCountForBullet : Float = 0;

  public static function update (scene : Scene) {
    detectCollision (scene);
    myShip.update (scene);
    fireBullet (scene);
    for (bullet in bullets) { bullet.update (scene); }
    deleteOutsideObject (scene);
    for (enemyFormation in enemyFormations) { enemyFormation.update (scene); }
  }

  public static function fireBullet (scene : Scene) {
    myShip.fireBullet (scene);
  }

  public static function deleteOutsideObject (scene : Scene) {
    deleteOutsideBullet (scene);
    deleteOutsideEnemy (scene);
  }

  static function deleteOutsideBullet (scene : Scene) {
    for (bullet in bullets) {
      bullet.deleteOutsideBullet (scene);
    }
  }

  static function deleteOutsideEnemy (scene : Scene) {
    for (enemyFormation in enemyFormations) {
      enemyFormation.deleteOutsideEnemy (scene);
    }
  }

  public static function removeBullet (scene : Scene, bullet : Bullet) {
    bullets.remove (bullet);
    if (scene.contains (bullet))
      scene.removeChild (bullet);
  }

  public static function removeAllBullets (scene : Scene) {
    for (bullet in bullets)
      if (scene.contains (bullet))
        scene.removeChild (bullet);
    bullets = new Array<Bullet> ();
  }

  public static function addEnemyFormation (scene : Scene, enemyFormation : EnemyFormation) {
    enemyFormations.push (enemyFormation);
    scene.addChild (enemyFormation);
  }

  public static function removeEnemyFormation (scene : Scene, enemyFormation : EnemyFormation) {
    enemyFormations.remove (enemyFormation);
    if (scene.contains (enemyFormation))
      scene.removeChild (enemyFormation);
  }

  public static function removeAllEnemyFormations (scene : Scene) {
    for (enemyFormation in enemyFormations)
      if (scene.contains (enemyFormation))
        scene.removeChild (enemyFormation);
    enemyFormations = new Array<EnemyFormation> ();
  }

  // 当たり判定の処理
  public static function detectCollision (scene : Scene) {
    for (bullet in bullets) {
      for (enemyFormation in enemyFormations) {
        enemyFormation.detectCollisionWithBullet (scene, bullet);
      }
    }
    if (myShip.active) {
      for (enemyFormation in enemyFormations) {
        enemyFormation.detectCollisionWithMyShip (scene);
      }
    }
  }
}