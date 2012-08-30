import nme.display.Sprite;
import Scene;

import nme.Lib;
import com.eclecticdesignstudio.control.KeyBinding;
import nme.ui.Keyboard;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import com.eclecticdesignstudio.motion.Actuate;

import Enemy;

// ゲームのシーンクラス
class GameScene extends Scene {

  var myShip : MyShip;
  var bullets : Array<Bullet>;
  var enemyFormations : Array<EnemyFormation>;
  var score : Int;

  var windowWidth :Float;
  var windowHeight : Float;

  var myShipHpTextField : TextField;
  var scoreTextField : TextField;

  var frameCountForBullet : Float;
  var pressedFireButton : Bool;

	public function new (?myShip:MyShip, ?score:Int, ?pressedFireButton:Bool, ?bullets:Array<Bullet>) {
		super ();

    if (score == null)
      this.score = 0;
    else
      this.score = score;

    if (myShip == null)
      this.myShip = new MyShip();
    else
      this.myShip = myShip;
    addChild ( this.myShip );

    if (bullets == null)
      this.bullets = new Array<Bullet>();
    else {
      this.bullets = bullets;
      for (bullet in bullets)
        addChild (bullet);
      }

    frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;

    if (pressedFireButton == null)
      this.pressedFireButton = false;
    else
      this.pressedFireButton = pressedFireButton;

    enemyFormations = new Array<EnemyFormation> ();
    
    registerKeyEvents ();

    // 自機のHPの表示
    myShipHpTextField = new TextField ();
		addChild (myShipHpTextField);

    // スコアの表示
    scoreTextField = new TextField ();
    addChild (scoreTextField);
  }

  override public function update () : NextScene {
    myShip.update ();
    fireBullet ();
    deleteOutsideBullet ();
    for (bullet in bullets) { bullet.update (); }
    deleteOutsideEnemy ();
    for (enemyFormation in enemyFormations) { enemyFormation.update (); }

    updateTextField (myShipHpTextField, "HP:" + Std.string (myShip.hp), 20.0);
    updateTextField (scoreTextField, "Score:" + Std.string (score), 0.0);

    detectCollision ();
    
    return Remaining;
  }

  function keyboard_onPressFireButton () : Void { pressedFireButton = true; }
  function keyboard_onReleaseFireButton () : Void { pressedFireButton = false; }

  // キーイベントの登録
  function registerKeyEvents () {
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


  function fireBullet () {
    if (pressedFireButton && frameCountForBullet >= Lib.stage.frameRate / MyShip.BULLET_RATE
        && myShip.active) {
      frameCountForBullet = 0;
      var bullet = new Bullet (myShip.cx, myShip.cy - myShip.height / 2.0);
      
      bullets.push (bullet);
      addChild (bullet);
    }
    if (!pressedFireButton) frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;
    frameCountForBullet++;
  }

  function deleteOutsideBullet () {
    for (bullet in bullets) {
      if ( bullet.cx < 0.0 || bullet.cx > Lib.current.width
           || bullet.cy < 0.0 || bullet.cy > Lib.current.height ) {
        removeBullet (bullet);
      }
    }
  }

  function deleteOutsideEnemy () {
    for (enemyFormation in enemyFormations) {
      for (enemy in enemyFormation.enemies) {
        if ( enemy.cx < -100.0 || enemy.cx > Lib.current.width + 100.0
             || enemy.cy < -100.0 || enemy.cy > Lib.current.height + 100.0 ) {
          enemyFormation.removeEnemy (enemy);
          if (enemyFormation.enemies.length == 0) removeEnemyFormation (enemyFormation);
        }
      }
    }
  }

  function removeBullet (bullet : Bullet) {
    bullets.remove (bullet);
    removeChild (bullet);
  }

  function addEnemyFormation (enemyFormation : EnemyFormation) {
    enemyFormations.push (enemyFormation);
    addChild (enemyFormation);
  }

  function removeEnemyFormation (enemyFormation : EnemyFormation) {
    enemyFormations.remove (enemyFormation);
    removeChild (enemyFormation);
  }

  function detectCollision () {
    collisionWithEnemyAndBullet ();
    collisionWithEnemyAndMyShip ();
  }

  function collisionWithEnemyAndBullet () {
    var compute = function (enemy:Enemy, enemyFormation:EnemyFormation, bullet:Bullet) {
      if (enemy.isHit (bullet)) {
        enemy.hp -= bullet.power;
        removeBullet (bullet);
        if (enemy.hp <= 0) {
          enemy.active = false;
          enemyFormation.removeEnemy (enemy);
          score += enemy.score;
          if (enemyFormation.enemies.length == 0) {
            removeEnemyFormation (enemyFormation);
          }
        }
      }
    }

    for (bullet in bullets) {
      for (enemyFormation in enemyFormations) {
        for (enemy in enemyFormation.enemies) {
          compute (enemy, enemyFormation, bullet);
        }
      }
    }
  }

  function collisionWithEnemyAndMyShip () {
    var compute = function (enemy:Enemy) {
      if (enemy.isHit (myShip)) {
        myShip.hp -= enemy.power;
        if (myShip.hp <= 0) {
          myShip.active = false;
          removeChild (myShip);
        }
      }
    }
    
    for (enemyFormation in enemyFormations) {
      for (enemy in enemyFormation.enemies) {
        compute (enemy);
      }
    }
  }

  // テキストフィールドの更新
  function updateTextField (textField : TextField, text : String, y : Float) {
		textField.y = y;
		textField.text = text;
		textField.selectable = false;
		
		var textFormat:TextFormat = new TextFormat ("_sans", 20, 0x333333);
		textFormat.align = TextFormatAlign.LEFT;
		
		textField.setTextFormat (textFormat);
		textField.alpha = 30;
		Actuate.tween (textField, 1, { alpha: 1 } ).delay (0.4);
  }
}