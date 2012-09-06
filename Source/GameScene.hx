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

  var continueTextField : TextField;

  var windowWidth : Float;
  var windowHeight : Float;

  public function new () {
    super ();
    initialize ();
  }

  // 初期化
  function initialize () {
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
    continueTextField = new TextField ();
    continueTextField.visible = false;
    addChild (continueTextField);

    windowWidth = Common.WIDTH; windowHeight = Common.HEIGHT;
  }

  override public function update () : NextScene {
    super.update ();
    GameObjectManager.update (this);

    // スコアの表示
    updateTextField (scoreTextField,
                     "Score:" + Std.string (GameObjectManager.totalScore), 0.0, 0.0, 300.0, 20.0);
    return Remaining;
  }

  // テキストフィールドの更新
  function updateTextField (textField : TextField, text : String,
                            x:Float, y:Float, w:Float, h:Float,
                            ?fontSize:Float=20) {
    textField.x = x;
    textField.y = y;
    textField.width = w;
    textField.text = text;
    textField.selectable = false;

    var tf = new TextFormat ("_sans", fontSize, 0x333333);
    tf.align = TextFormatAlign.LEFT;
    textField.setTextFormat (tf);
    textField.alpha = 30;
  }


  // コンティニュー
  function gameContinue (sceneClass : Class<Dynamic>) {
    if (!GameObjectManager.myShip.active) {
      updateTextField (continueTextField, "Press 'x' to Continue!",
                       200.0, Common.HEIGHT/2.0, 300.0, 30.0);
      continueTextField.visible = true;
    }

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