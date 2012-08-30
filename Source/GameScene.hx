import nme.display.Sprite;
import Scene;

import nme.Lib;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import com.eclecticdesignstudio.motion.Actuate;

import Enemy;

// ゲームのシーンクラス
class GameScene extends Scene {
    
  public static var myShip : MyShip;
  
  public static var bullets : Array<Bullet> = new Array<Bullet> ();
  public static var enemyFormations : Array<EnemyFormation> = new Array<EnemyFormation> ();
  
  public static var totalScore : Int = 0;

  public static var myShipHpTextField : TextField = new TextField ();
  public static var scoreTextField : TextField = new TextField ();

  private var frameCountForBullet : Float;

	public function new () {
		super ();
    frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;

    initialize ();
  }

  public function initialize () {

    if (myShip == null) {
      myShip = new MyShip ();
    }
    addChild ( myShip );
    for (bullet in bullets)
      addChild (bullet);
    
		addChild (GameScene.myShipHpTextField);
    addChild (GameScene.scoreTextField);
  }

  override public function update () : NextScene {
    GameScene.myShip.update ();
    fireBullet ();
    deleteOutsideBullet ();
    for (bullet in GameScene.bullets) { bullet.update (); }
    deleteOutsideEnemy ();
    for (enemyFormation in GameScene.enemyFormations) { enemyFormation.update (); }

    var hp = GameScene.myShip.hp;
    if (hp < 0) hp = 0;
    updateTextField (GameScene.myShipHpTextField, "HP:" + Std.string (hp), 20.0);
    updateTextField (GameScene.scoreTextField, "Score:" + Std.string (totalScore), 0.0);

    detectCollision ();
    
    return Remaining;
  }

  function fireBullet () {
    if (KeyboardInput.pressedZ && frameCountForBullet >= Lib.stage.frameRate / MyShip.BULLET_RATE
        && GameScene.myShip.active) {
      frameCountForBullet = 0;
      var bullet = new Bullet (GameScene.myShip.cx, GameScene.myShip.cy - myShip.height / 2.0);
      
      GameScene.bullets.push (bullet);
      addChild (bullet);
    }
    if (!KeyboardInput.pressedZ) frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;
    frameCountForBullet++;
  }

  function deleteOutsideBullet () {
    for (bullet in GameScene.bullets) {
      if ( bullet.cx < 0.0 || bullet.cx > Lib.current.width
           || bullet.cy < 0.0 || bullet.cy > Lib.current.height ) {
        removeBullet (bullet);
      }
    }
  }

  function deleteOutsideEnemy () {
    for (enemyFormation in GameScene.enemyFormations) {
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
    GameScene.bullets.remove (bullet);
    removeChild (bullet);
  }

  function addEnemyFormation (enemyFormation : EnemyFormation) {
    GameScene.enemyFormations.push (enemyFormation);
    addChild (enemyFormation);
  }

  function removeEnemyFormation (enemyFormation : EnemyFormation) {
    GameScene.enemyFormations.remove (enemyFormation);
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
          totalScore += enemy.score;
          if (enemyFormation.enemies.length == 0) {
            removeEnemyFormation (enemyFormation);
          }
        }
      }
    }

    for (bullet in GameScene.bullets) {
      for (enemyFormation in GameScene.enemyFormations) {
        for (enemy in enemyFormation.enemies) {
          compute (enemy, enemyFormation, bullet);
        }
      }
    }
  }

  function collisionWithEnemyAndMyShip () {
    var compute = function (enemy:Enemy) {
      if (enemy.isHit (GameScene.myShip)) {
        myShip.hp -= enemy.power;
        if (GameScene.myShip.hp <= 0) {
          GameScene.myShip.active = false;
          removeChild (GameScene.myShip);
        }
      }
    }
    
    if (myShip.active) {
      for (enemyFormation in GameScene.enemyFormations) {
        for (enemy in enemyFormation.enemies) {
          compute (enemy);
        }
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