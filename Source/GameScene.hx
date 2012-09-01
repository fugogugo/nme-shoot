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

  public static var myShipHpTextField : TextField;
  public static var scoreTextField : TextField;

  var frameCountForBullet : Float;
  var windowWidth : Float;
  var windowHeight : Float;

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

    for (enemyFormation in enemyFormations)
      addChild (enemyFormation);
    
    if (myShipHpTextField == null)
      myShipHpTextField = new TextField ();
    addChild (myShipHpTextField);

    if (scoreTextField == null)
      scoreTextField =new TextField ();
    addChild (scoreTextField);

    windowWidth = Common.width; windowHeight = Common.height;
  }

  override public function update () : NextScene {

    myShip.update ();
    fireBullet ();
    deleteOutsideBullet ();
    for (bullet in bullets) { bullet.update (); }
    deleteOutsideEnemy ();
    for (enemyFormation in enemyFormations) { enemyFormation.update (); }


    // 自機のHPとスコアの表示
    var hp = myShip.hp;
    updateTextField (myShipHpTextField, "HP:" + Std.string (hp), 0.0, 20.0, 300.0, 20.0);
    updateTextField (scoreTextField, "Score:" + Std.string (totalScore), 0.0, 0.0, 300.0, 20.0);

    detectCollision ();

    return Remaining;
  }

  function fireBullet () {
    if (KeyboardInput.pressedZ && frameCountForBullet >= Lib.stage.frameRate / MyShip.BULLET_RATE
        && myShip.active) {
      frameCountForBullet = 0;
      var bullet = new Bullet (myShip.cx, myShip.cy - myShip.height / 2.0);
      
      bullets.push (bullet);
      addChild (bullet);
    }
    if (!KeyboardInput.pressedZ) frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;
    frameCountForBullet++;
  }

  function deleteOutsideBullet () {
    for (bullet in bullets) {
      if ( bullet.cx < -50.0 || bullet.cx > windowWidth + 50.0
           || bullet.cy < -50.0 || bullet.cy > windowHeight + 50.0 ) {
        removeBullet (bullet);
      }
    }
  }

  function deleteOutsideEnemy () {
    for (enemyFormation in enemyFormations) {
      for (enemy in enemyFormation.enemies) {
        if ( enemy.cx < -100.0 || enemy.cx > windowWidth + 100.0
             || enemy.cy < -100.0 || enemy.cy > windowHeight + 100.0 ) {
          enemyFormation.removeEnemy (enemy);
          if (enemyFormation.enemies.length <= 0)
            removeEnemyFormation (enemyFormation);
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

  // 当たり判定の処理
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
          if (enemyFormation.enemies.length <= 0) {
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
    
    if (myShip.active) {
      for (enemyFormation in enemyFormations) {
        for (enemy in enemyFormation.enemies) {
          compute (enemy);
        }
      }
    }
  }

  // テキストフィールドの更新
  function updateTextField (textField : TextField, text : String,
                            x:Float, y:Float, w:Float, h:Float) {
    textField.x = x;
    textField.y = y;
    textField.width = w;
    textField.text = text;
    textField.selectable = false;

    var tf = new TextFormat ("_sans", 20, 0x333333);
    tf.align = TextFormatAlign.LEFT;
    
    textField.setTextFormat (tf);
    textField.alpha = 30;
  }

}