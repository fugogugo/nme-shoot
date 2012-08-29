import nme.display.Sprite;

// ゲームオブジェクトのクラス
class Mover extends Sprite {

  // 中心座標
  public var cx (default, setX) : Float;
  public var cy (default, setY) : Float;

  // 当たり判定の範囲
  public var hitRange : Float;

  // 角度
  public var angle : Float;

  // スケール
  public var scale : Float;

  // アクティブ
  public var active : Bool;

  // 画像
  public var graphic : Sprite;

  public function new (x:Float = 0.0, y:Float = 0.0, image:Sprite) {
    super ();

    graphic = image; addChild (graphic);
    active = true;

    setX (x); setY (y);

    hitRange = 0.0;
    angle = 0.0;
    scale = 1.0;
    active = true;
  }

  // フレームごとの処理 (サブクラスでオーバーライドする)
  public function update () : Void {
  }

  // 当たり判定 (半径でのみ判定)
  public function isHit (mover : Mover) : Bool {
    var dx = mover.cx - this.cx;
    var dy = mover.cy - this.cy;
    var hit = mover.hitRange + this.hitRange;

    return dx*dx + dy*dy < hit*hit;
  }

  public function isHitWithArray (movers : Array<Mover>) : Bool {
    for (mover in movers) {
      if (this.isHit(mover)) return true;
    }
    return false;
  }

  public function setX (x : Float) {
    this.x = x - graphic.width / 2.0;
    return cx = x;
  }

  public function setY (y : Float) {
    this.y = y - graphic.height / 2.0;
    return cy = y;
  }

}