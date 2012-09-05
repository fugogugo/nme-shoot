import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

import StageScene;

// ゲームを実行するクラス
class Main extends Sprite {

  var currentScene : Scene;

  public function new () {
    super ();

    // fpsごとに呼び出し
    addEventListener ( Event.ENTER_FRAME, this_onEnterFrame );
    KeyboardInput.initialize ();
    Common.initialize ();
    
    Common.setSlow (1.0);
    currentScene = new Stage1Scene ();
    Lib.current.addChild (currentScene);
  }

  // メインループのメソッド
  function this_onEnterFrame (event:Event):Void {
    // シーンの更新
    switch (currentScene.update ()) {
    case Remaining : return;
    case Next (s) : {
      Lib.current.removeChild (currentScene);
      currentScene = s;
      Lib.current.addChild (currentScene);
    };
    }
  }
}