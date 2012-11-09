import Enemy;

class GameObjectManager {
    
  public static var myShip : MyShip;
  
  public static var bullets : Array<Bullet> = new Array<Bullet> ();
  public static var enemies : Array<Enemy> = new Array<Enemy> ();
  
  public static var totalScore : Int = 0;

  static var totalFrameCount : Int = 0;
  static var frameCountForBullet : Int = 0;

  public static function initialize () {
    myShip = new MyShip ();
  }

  public static function update (scene : Scene) {
    if (myShip != null && bullets != null && enemies != null) {
      detectCollision (scene);
      myShip.update (scene);
      fireBullet (scene);
      for (bullet in bullets) { bullet.update (scene); }
      deleteOutsideObject (scene);
      for (enemy in enemies) { enemy.update (scene); }
    }
    ++frameCountForBullet;
  }

  public static function updateTotalFrameCount () { ++totalFrameCount; }

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
    for (enemy in enemies) {
      enemy.deleteOutsideEnemy (scene);
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

  public static function addEnemy (scene : Scene, enemy : Enemy) {
    enemies.push (enemy);
    scene.addChild (enemy);
  }

  public static function removeEnemy (scene : Scene, enemy : Enemy) {
    enemies.remove (enemy);
    if (scene.contains (enemy))
      scene.removeChild (enemy);
  }

  public static function removeAllEnemies (scene : Scene) {
    for (enemy in enemies)
      if (scene.contains (enemy))
        scene.removeChild (enemy);
    enemies = new Array<Enemy> ();
  }

  // 当たり判定の処理
  public static function detectCollision (scene : Scene) {
    for (bullet in bullets) {
      for (enemy in enemies) {
        enemy.detectCollisionWithBullet (scene, bullet);
      }
    }
    if (myShip.active) {
      for (enemy in enemies) {
        enemy.detectCollisionWithMyShip (scene);
      }
    }
  }

  public static function getTotalFrameCount () { return totalFrameCount; }
  public static function getFrameCountForBullet () { return frameCountForBullet; }
  public static function resetFrameCountForBullet () { frameCountForBullet = 0; }
  public static function setFrameCountForBullet (count : Int) {
    frameCountForBullet =  count;
  }
}