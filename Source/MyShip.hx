import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

// 自機クラス
class MyShip extends Mover {

  static inline var graphicPath = "images/MyShip.png";

  static inline var SPEED_PER_SECOND = 180.0;
  public static inline var BULLET_RATE = 10.0;

  var windowWidth : Float;
  var windowHeight : Float;

  public function new () {
    
    setGraphic (graphicPath);

    windowWidth = Common.width; windowHeight = Common.height;
    
    super (windowWidth / 2.0, windowHeight - 100.0, graphic);
    hp = 20;
    hitRange = 10.0;
  }

  override public function update () {
    if (KeyboardInput.pressedUp && cy >= 0.0)
      setY (cy - SPEED_PER_SECOND / Lib.stage.frameRate);
    if (KeyboardInput.pressedDown && cy <= windowHeight)
      setY (cy + SPEED_PER_SECOND / Lib.stage.frameRate);
    if (KeyboardInput.pressedLeft && cx >= 0.0)
      setX (cx - SPEED_PER_SECOND / Lib.stage.frameRate);
    if (KeyboardInput.pressedRight && cx <= windowWidth)
      setX (cx + SPEED_PER_SECOND / Lib.stage.frameRate);
   
    if (hp < 0) hp = 0;
  }

  public function fireBullet (scene : GameScene) {
    if (KeyboardInput.pressedZ
        && GameObjectManager.frameCountForBullet >= Lib.stage.frameRate / BULLET_RATE
        && active) {
      GameObjectManager.frameCountForBullet = 0.0;
      var bullet = new Bullet (cx, cy - height / 2.0);
      
      GameObjectManager.bullets.push (bullet);
      scene.addChild (bullet);
    }
    if (!KeyboardInput.pressedZ)
      GameObjectManager.frameCountForBullet = Lib.stage.frameRate / BULLET_RATE;
    GameObjectManager.frameCountForBullet++;
  }

  public function detectCollisionWithEnemy (scene : GameScene, enemy : Enemy) {
    if (isHit (enemy)) {
      hp -= enemy.power;
      if (hp <= 0) {
        active = false;
        scene.removeChild (this);
      }
    }
  }
}