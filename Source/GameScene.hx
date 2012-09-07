import nme.text.TextField;
import Scene;
import Enemy;

using Lambda;

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
    GameObjectManager.bullets.map (addChild);
    GameObjectManager.enemyFormations.map (addChild);
    
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
  function continueGame <T : Scene> (sceneClass : Class<T>) {
    var func = function (text : String, flag : Bool) {
      if (!GameObjectManager.myShip.active) {
        updateTextField (continueTextField, text,
                         200.0, Common.HEIGHT/2.0, 300.0, 30.0);
        continueTextField.visible = true;
      }

      if (flag) {
        GameObjectManager.myShip = new MyShip ();
        GameObjectManager.removeAllBullets (this);
        GameObjectManager.removeAllEnemyFormations (this);
        // スコアを半分にする
        GameObjectManager.totalScore = Std.int (GameObjectManager.totalScore / 2.0);
        return Next (Type.createInstance (sceneClass, []));
      }

      #if (ios || android || webos)
      if (!Input.touch)
        touchContinue = true;
      #end

      return Remaining;
    }

    #if (ios || android || webos)
    return func ("touch to Continue!",
                 !GameObjectManager.myShip.active && Input.touch && touchContinue);

    #else
    return func ("Press 'x' to Continue!",
                 !GameObjectManager.myShip.active && Input.pressedX);
    #end
  }
}