import nme.display.Sprite;
import Scene;

import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import com.eclecticdesignstudio.motion.Actuate;
import nme.Lib;

// ゲームのシーンクラス
class GameScene extends Scene {

  var myShip : MyShip;
  var windowWidth :Float;
  var windowHeight : Float;

	public function new (windowWidth : Float, windowHeight : Float) {
		super ();

    this.windowWidth = windowWidth; this.windowHeight = windowHeight;
    myShip = new MyShip( this.windowWidth, this.windowHeight );
    addChild ( myShip );
  }

  override public function update () {
    myShip.update ();
    return Remaining;
  }
}