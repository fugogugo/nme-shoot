import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

// 次のシーン
enum NextScene {
  Remaining;
  Next (s:Scene);
}


// シーンクラス
class Scene extends Sprite {

  var startFrameCount : Null<Int>;
  var scoreTextField : TextField;

  public function new () {
    super ();
    startFrameCount = null;
  }

  public function update () {
    if (startFrameCount == null)
      startFrameCount = GameObjectManager.getTotalFrameCount ();
    return Remaining;
  }

  function frameCount () {
    return GameObjectManager.getTotalFrameCount () - startFrameCount;
  }

  // テキストフィールドの更新
  function updateTextField (textField : TextField, text : String,
                            x:Float, y:Float, w:Float, h:Float,
                            ?fontSize:Float=20) {
    textField.x = x;
    textField.y = y;
    textField.width = w;
    textField.text = text;
    textField.selectable = false;

    var tf = new TextFormat ("_sans", fontSize, 0x333333);
    tf.align = TextFormatAlign.LEFT;
    textField.setTextFormat (tf);
    textField.alpha = 30;
  }
}