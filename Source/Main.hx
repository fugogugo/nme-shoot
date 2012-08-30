import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

import StageScene;

// ゲームを管理するクラス
class Main extends Sprite {

  private var currentScene : Scene;

	public function new () {
		super ();
		addEventListener ( Event.ENTER_FRAME, this_onEnterFrame );

    currentScene = new Stage1Scene ();
    Lib.current.addChild (currentScene);
	}

  // メインループのメソッド
	private function this_onEnterFrame (event:Event):Void {
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