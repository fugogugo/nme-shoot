import nme.display.Sprite;
import nme.text.TextField;
// 次のシーン
enum NextScene {
  Remaining;
  Next (s:Scene);
}


// シーンクラス
class Scene extends Sprite {

  public var scoreTextField : TextField;
  public function update () { return Remaining; }
}