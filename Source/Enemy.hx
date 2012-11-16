import nme.display.Sprite;

using Lambda;

// 敵クラス
class Enemy extends Mover {

  var appearanceSec (default, null) : Float;
  public var score (default, null) : Int;
  public var isCollisionWithBullet (default, null) : Bool;

  public function new (initX:Float, initY:Float, graphic:Sprite, appearanceSec : Float) {
    
    score = 0;
    this.graphic = graphic;

    super (initX, initY, graphic);
    visible = false;
    active = false;
    isCollisionWithBullet = true;
    this.appearanceSec = appearanceSec;
  }

  // appearanceSecで設定された秒数後に実行される
  function appearedUpdate (scene : Scene) {
    visible = true;
    active = true;
  }

  // appearanceSecで設定された秒数前に実行される
  function disappearedUpdate (scene : Scene) {
    visible = false;
  }

  override public function update (scene : Scene) {
    super.update (scene);

    if (appearanceSec <= Common.perFrameRate (frameCount ())) {
      appearedUpdate (scene);
    }
    else {
      disappearedUpdate (scene);
    }
  }

  public function detectCollisionWithBullet (scene : Scene, bullet:Bullet) {
    if (isCollisionWithBullet && isCollision (bullet)) {
      hp -= bullet.power;
      collisionEffect (scene);
      bullet.collisionEffect (scene);
      GameObjectManager.removeBullet (scene, bullet);
      if (hp <= 0) {
        active = false;
        removeEffect (scene);
        GameObjectManager.totalScore += score;
        GameObjectManager.removeEnemy (scene, this);
      }
    }
  }

  public function detectCollisionWithMyShip (scene : Scene) {
    if (GameObjectManager.myShip.isCollision (this)) {
      GameObjectManager.myShip.hp -= power;
      GameObjectManager.myShip.collisionEffect (scene);
      if (GameObjectManager.myShip.hp <= 0) {
        GameObjectManager.myShip.active = false;
        GameObjectManager.myShip.removeEffect (scene);
        if (scene.contains (GameObjectManager.myShip))
          scene.removeChild (GameObjectManager.myShip);
      }
    }
  }

  public function deleteOutsideEnemy (scene : Scene) {
    var outsideLength = 100.0;
    if ( x < -outsideLength || x > Common.WIDTH + outsideLength
           || y < -outsideLength || y > Common.HEIGHT + outsideLength )
      GameObjectManager.removeEnemy (scene, this);
    }
}