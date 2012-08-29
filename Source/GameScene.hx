import nme.display.Sprite;
import Scene;

import nme.Lib;
import com.eclecticdesignstudio.control.KeyBinding;
import nme.ui.Keyboard;

// ゲームのシーンクラス
class GameScene extends Scene {

  var myShip : MyShip;
  var bullets : Array<Bullet>;
  var windowWidth :Float;
  var windowHeight : Float;

  var frameCountForBullet : Float;
  var pressedFireButton : Bool;

	public function new (windowWidth : Float, windowHeight : Float) {
		super ();

    this.windowWidth = windowWidth; this.windowHeight = windowHeight;
    myShip = new MyShip( this.windowWidth, this.windowHeight );
    addChild ( myShip );

    bullets = new Array<Bullet>();

    frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;


    pressedFireButton = false;

    KeyBinding.addOnPress (Keyboard.UP, myShip.keyboard_onPressUp);
    KeyBinding.addOnPress (Keyboard.DOWN, myShip.keyboard_onPressDown);
    KeyBinding.addOnRelease (Keyboard.UP, myShip.keyboard_onReleaseUp);
    KeyBinding.addOnRelease (Keyboard.DOWN, myShip.keyboard_onReleaseDown);
    KeyBinding.addOnPress (Keyboard.LEFT, myShip.keyboard_onPressLeft);
    KeyBinding.addOnPress (Keyboard.RIGHT, myShip.keyboard_onPressRight);
    KeyBinding.addOnRelease (Keyboard.LEFT, myShip.keyboard_onReleaseLeft);
    KeyBinding.addOnRelease (Keyboard.RIGHT, myShip.keyboard_onReleaseRight);

    KeyBinding.addOnPress ("z", keyboard_onPressFireButton);
    KeyBinding.addOnRelease ("z", keyboard_onReleaseFireButton);
  }

  override public function update () {
    myShip.update ();
    createBullet ();
    deleteBullet ();

    return Remaining;
  }

  function keyboard_onPressFireButton () : Void { pressedFireButton = true; }
  function keyboard_onReleaseFireButton () : Void { pressedFireButton = false; }

  // 
  function createBullet () {
    if (pressedFireButton && frameCountForBullet >= Lib.stage.frameRate / MyShip.BULLET_RATE) {
      frameCountForBullet = 0;
      var bullet = new Bullet (myShip.cx, myShip.cy - myShip.height / 2.0);
      
      bullets.push (bullet);
      addChild (bullet);
    }
    if (!pressedFireButton) frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;
    frameCountForBullet++;

    for (bullet in bullets) { bullet.update (); }
  }

  function deleteBullet () {
    for (bullet in bullets) {
      if ( bullet.cx < -10.0 || bullet.cx > windowWidth + 10.0
           || bullet.cy < -10.0 || bullet.cy > windowHeight + 10.0 ) {
        bullets.remove (bullet);
        removeChild (bullet);
        bullet = null;
      }
    }
  }
}