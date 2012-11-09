import nme.display.Sprite;

using Lambda;

// 敵クラス
class Enemy extends Mover {

  var appearanceSec (default, null) : Float;
  public var score (default, null) : Int;
  public var isCollisionWithBullet (default, null) : Bool;
  var updateProcedure : Void -> Void;

  public function new (initX:Float, initY:Float, graphic:Sprite, appearanceSec : Float, update : Void -> Void) {
    
    score = 0;
    this.graphic = graphic;
    this.updateProcedure = update;

    super (initX, initY, graphic);
    visible = false;
    active = false;
    isCollisionWithBullet = true;
    this.appearanceSec = appearanceSec;
  }


  override public function update (scene : Scene) {
    super.update (scene);

    if (appearanceSec <= Common.perFrameRate (frameCount ())) {
      visible = true;
      active = true;
      updateProcedure ();
    }
    else {
      visible = false;
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