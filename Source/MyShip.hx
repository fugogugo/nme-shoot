import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

// 自機クラス
class MyShip extends Mover {

  static inline var graphicPath = "images/MyShip.png";

  static inline var SPEED_PER_SECOND = 180.0;
  public static inline var BULLET_RATE = 10.0;

  public function new () {
    
    setGraphic (graphicPath);
    
    super (Common.width / 2.0, Common.height - 100.0, graphic);
    hp = 1;
    hitRange = 5.0;
  }

  override public function update (scene : Scene) {
    
    if (KeyboardInput.pressedUp && y >= 0.0)
      y -= Common.perFrameRate (SPEED_PER_SECOND);
    if (KeyboardInput.pressedDown && y <= Common.height)
      y += Common.perFrameRate (SPEED_PER_SECOND);
    if (KeyboardInput.pressedLeft && x >= 0.0)
      x -= Common.perFrameRate (SPEED_PER_SECOND);
    if (KeyboardInput.pressedRight && x <= Common.width)
      x += Common.perFrameRate (SPEED_PER_SECOND);
    if (hp <= 0) {
      this.removeEffect (scene);
      if (scene.contains (this))
        scene.removeChild (this);
    }
    
  }

  public function fireBullet (scene : Scene) {
    if (KeyboardInput.pressedZ
        && GameObjectManager.frameCountForBullet >= Common.frameRate / BULLET_RATE
        && active) {
      GameObjectManager.frameCountForBullet = 0.0;
      var bullet0 = new Bullet (x, y - height / 2.0, 0.0);
      var bullet1 = new Bullet (x, y - height / 2.0, -22.5);
      var bullet2 = new Bullet (x, y - height / 2.0, 22.5);
      var bullet3 = new Bullet (x, y - height / 2.0, -45.0);
      var bullet4 = new Bullet (x, y - height / 2.0, 45.0);

      GameObjectManager.bullets.push (bullet0);
      GameObjectManager.bullets.push (bullet1);
      GameObjectManager.bullets.push (bullet2);
      GameObjectManager.bullets.push (bullet3);
      GameObjectManager.bullets.push (bullet4);

      scene.addChild (bullet0);
      scene.addChild (bullet1);
      scene.addChild (bullet2);
      scene.addChild (bullet3);
      scene.addChild (bullet4);
    }
    if (!KeyboardInput.pressedZ)
      GameObjectManager.frameCountForBullet = Common.frameRate / BULLET_RATE;
    GameObjectManager.frameCountForBullet++;
  }

}