import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

// ゲームを管理するクラス
class Main extends Sprite {

  static inline var windowWidth = 600.0;
  static inline var windowHeight = 700.0;

  private var currentScene : Scene;

	public function new () {
		super ();
		addEventListener ( Event.ENTER_FRAME, this_onEnterFrame );

    currentScene = new GameScene ( windowWidth, windowHeight );
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