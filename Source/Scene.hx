import nme.display.Sprite;
import nme.text.TextField;
// 次のシーン
enum NextScene {
  Remaining;
  Next (s:Scene);
}


// シーンクラス
class Scene extends Sprite {

  var frameCount : Int;

  var scoreTextField : TextField;
  public function new () {
    super ();
    frameCount = 0;
  }

  public function update () {
    ++frameCount;
    return Remaining;
  }
}