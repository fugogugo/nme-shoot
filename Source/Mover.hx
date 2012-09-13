import nme.display.Sprite;
import nme.Lib;

// ゲームオブジェクトのクラス
class Mover extends Sprite {

  // 当たり判定の範囲
  public var hitRange (default, null) : Float;

  // スケール
  public var scale (default, setScale) : Float;

  // アクティブ
  public var active : Bool;

  // 画像
  public var graphic : Sprite;

  // HP
  public var hp : Int;

  // 攻撃力
  public var power (default, null) : Int;

  // 処理開始時のフレーム数
  var startFrameCount : Null<Int>;

  public function new (x:Float = 0.0, y:Float = 0.0, image:Sprite) {
    super ();

    graphic = image; addChild (graphic);
    active = true;

    hitRange = 0.0;
    active = true;
    hp = 1;
    power = 1;

    this.scale = 1.0;
    this.x = x; this.y = y;

    graphic.x = - graphic.width / 2.0;
    graphic.y = - graphic.height / 2.0;

    startFrameCount = null;
  }

  // フレームごとの処理
  public function update (scene : Scene) : Void {
    if (startFrameCount == null) {
      startFrameCount = GameObjectManager.getTotalFrameCount ();
    }
  }

  // 当たり判定 (半径でのみ判定)
  public function isCollision (mover : Mover) : Bool {
    if (!(active && mover.active)) return false;
    var dx = mover.x - x;
    var dy = mover.y - y;
    var hit = mover.hitRange * mover.scale + hitRange * scale;

    return dx*dx + dy*dy < hit*hit;
  }

  function setGraphicPath (path:String) {
    graphic = GraphicCache.loadGraphic (path);
    graphic.x = - graphic.width / 2.0;
    graphic.y = - graphic.height / 2.0;
  }

  public function setScale (scale : Float) {
    scaleX = scale; scaleY = scale;
    return this.scale = scale;
  }

  // 削除時のエフェクト (サブクラスでオーバーライドする)
  public function removeEffect (scene : Scene) {
  }

  // 衝突時のエフェクト (サブクラスでオーバーライドする)
  public function collisionEffect (scene : Scene) { 
  }

  // 処理を開始してからのフレーム数
  function frameCount () {
    if (startFrameCount == null)
      return 0;
    else
      return GameObjectManager.getTotalFrameCount () - startFrameCount;
  }
}