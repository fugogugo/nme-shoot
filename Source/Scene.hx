import nme.display.Sprite;

// 次のシーン
enum NextScene {
  Remaining;
  Next (s:Scene);
}


// シーンクラス
class Scene extends Sprite {

  public function update () { return Remaining; }
}