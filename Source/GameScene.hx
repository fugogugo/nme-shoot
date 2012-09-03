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

  var scoreTextField : TextField;

  var windowWidth : Float;
  var windowHeight : Float;

  public function new () {
    super ();
    initialize ();
  }

  // 初期化
  public function initialize () {
    GameObjectManager.frameCountForBullet = Common.frameRate / MyShip.BULLET_RATE;

    if (GameObjectManager.myShip == null) {
      GameObjectManager.myShip = new MyShip ();
    }
    addChild ( GameObjectManager.myShip );
    for (bullet in GameObjectManager.bullets)
      addChild (bullet);

    for (enemyFormation in GameObjectManager.enemyFormations)
      addChild (enemyFormation);
    
    scoreTextField = new TextField ();
    addChild (scoreTextField);

    windowWidth = Common.width; windowHeight = Common.height;
  }

  override public function update () : NextScene {

    GameObjectManager.myShip.update (this);
    GameObjectManager.fireBullet (this);
    for (bullet in GameObjectManager.bullets) { bullet.update (this); }
    GameObjectManager.deleteOutsideObject (this);
    for (enemyFormation in GameObjectManager.enemyFormations) { enemyFormation.update (this); }

    // スコアの表示
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


  // コンティニュー
  function gameContinue (sceneClass : Class<Dynamic>) {
    if (!GameObjectManager.myShip.active && KeyboardInput.pressedX) {
      GameObjectManager.myShip = new MyShip ();
      GameObjectManager.removeAllBullets (this);
      GameObjectManager.removeAllEnemyFormations (this);
      // スコアを半分にする
      GameObjectManager.totalScore = Std.int (GameObjectManager.totalScore / 2.0);
      return Next (Type.createInstance (sceneClass, []));
    }
    return Remaining;
  }
}