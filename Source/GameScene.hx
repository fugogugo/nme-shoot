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
  var touchContinue : Bool;

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


  // コンティニュー
  function gameContinue (sceneClass : Class<Dynamic>) {
    #if (ios || android || webos)
    if (!GameObjectManager.myShip.active) {
      updateTextField (continueTextField, "touch to Continue!",
                       200.0, Common.HEIGHT/2.0, 300.0, 30.0);
      continueTextField.visible = true;
    }


    if (!GameObjectManager.myShip.active && Input.touch && touchContinue ) {
      GameObjectManager.myShip = new MyShip ();
      GameObjectManager.removeAllBullets (this);
      GameObjectManager.removeAllEnemyFormations (this);
      // スコアを半分にする
      GameObjectManager.totalScore = Std.int (GameObjectManager.totalScore / 2.0);
      return Next (Type.createInstance (sceneClass, []));
    }
    if (!Input.touch)
      touchContinue = true;

    #else
    if (!GameObjectManager.myShip.active) {
      updateTextField (continueTextField, "Press 'x' to Continue!",
                       200.0, Common.HEIGHT/2.0, 300.0, 30.0);
      continueTextField.visible = true;
    }

    if (!GameObjectManager.myShip.active && Input.pressedX) {
      GameObjectManager.myShip = new MyShip ();
      GameObjectManager.removeAllBullets (this);
      GameObjectManager.removeAllEnemyFormations (this);
      // スコアを半分にする
      GameObjectManager.totalScore = Std.int (GameObjectManager.totalScore / 2.0);
      return Next (Type.createInstance (sceneClass, []));
    }
    #end

    return Remaining;
  }
}