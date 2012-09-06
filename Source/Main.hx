import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.display.FPS;

import StageScene;

// ゲームを実行するクラス
class Main extends Sprite {

  var currentScene : Scene;
  var fpsTextField : FPS;

  public function new () {
    super ();

    // fpsごとに呼び出し
    addEventListener ( Event.ENTER_FRAME, this_onEnterFrame);
    KeyboardInput.initialize ();
    Common.initialize ();
    fpsTextField = new FPS (0.0, Common.HEIGHT - 30.0);
    addChild (fpsTextField);
    Common.setSlow (1.0);
    currentScene = new StartScene ();
    addChild (currentScene);
    Lib.current.addChild (this);
  }

  // メインループのメソッド
  function this_onEnterFrame (event:Event):Void {
    // シーンの更新
    switch (currentScene.update ()) {
    case Remaining :  {};
    case Next (s) : {
      removeChild (currentScene);
      currentScene = s;
      addChild (currentScene);
    };}

    GameObjectManager.updateTotalFrameCount ();

  }
}