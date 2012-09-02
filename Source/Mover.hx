import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;

// ゲームオブジェクトのクラス
class Mover extends Sprite {

  // 中心座標
  public var cx (default, setX) : Float;
  public var cy (default, setY) : Float;

  // 当たり判定の範囲
  public var hitRange (default, null) : Float;

  // 角度
  public var angle (default, null) : Float;

  // スケール
  public var scale (default, null) : Float;

  // アクティブ
  public var active : Bool;

  // 画像
  var graphic : Sprite;

  // HP
  public var hp : Int;

  // 攻撃力
  public var power (default, null) : Int;


  public function new (x:Float = 0.0, y:Float = 0.0, image:Sprite) {
    super ();

    graphic = image; addChild (graphic);
    active = true;

    setX (x); setY (y);

    hitRange = 0.0;
    angle = 0.0;
    scale = 1.0;
    active = true;
    hp = 1;
    power = 1;
  }

  // フレームごとの処理 (サブクラスでオーバーライドする)
  public function update () : Void {}

  // 当たり判定 (半径でのみ判定)
  public function isHit (mover : Mover) : Bool {
    if (!(this.active && mover.active)) return false;
    var dx = mover.cx - this.cx;
    var dy = mover.cy - this.cy;
    var hit = mover.hitRange + this.hitRange;

    return dx*dx + dy*dy < hit*hit;
  }

  public function setX (x : Float) {
    this.x = x - graphic.width / 2.0;
    return cx = x;
  }

  public function setY (y : Float) {
    this.y = y - graphic.height / 2.0;
    return cy = y;
  }

  function setGraphic (path:String) {
    graphic = GraphicCache.loadGraphic (path);
  }
}