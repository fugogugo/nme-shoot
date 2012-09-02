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

  var myShipHpTextField : TextField;
  var scoreTextField : TextField;

  var windowWidth : Float;
  var windowHeight : Float;

  public function new () {
    super ();
    initialize ();
  }

  public function initialize () {
    GameObjectManager.frameCountForBullet = Lib.stage.frameRate / MyShip.BULLET_RATE;

    if (GameObjectManager.myShip == null) {
      GameObjectManager.myShip = new MyShip ();
    }
    addChild ( GameObjectManager.myShip );
    for (bullet in GameObjectManager.bullets)
      addChild (bullet);

    for (enemyFormation in GameObjectManager.enemyFormations)
      addChild (enemyFormation);
    

    myShipHpTextField = new TextField ();
    addChild (myShipHpTextField);

    scoreTextField = new TextField ();
    addChild (scoreTextField);

    windowWidth = Common.width; windowHeight = Common.height;
  }

  override public function update () : NextScene {

    GameObjectManager.myShip.update ();
    GameObjectManager.fireBullet (this);
    for (bullet in GameObjectManager.bullets) { bullet.update (); }
    GameObjectManager.deleteOutsideObject (this);
    for (enemyFormation in GameObjectManager.enemyFormations) { enemyFormation.update (); }

    // 自機のHPとスコアの表示
    var hp = GameObjectManager.myShip.hp;
    updateTextField (myShipHpTextField, "HP:" + Std.string (hp), 0.0, 20.0, 300.0, 20.0);
    updateTextField (scoreTextField,
                     "Score:" + Std.string (GameObjectManager.totalScore), 0.0, 0.0, 300.0, 20.0);

    GameObjectManager.detectCollision (this);

    return Remaining;
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