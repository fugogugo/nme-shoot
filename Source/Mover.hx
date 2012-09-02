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
  public var angle (default, setAngle) : Float;

  // スケール
  public var scale (default, setScale) : Float;

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

    hitRange = 0.0;
    active = true;
    hp = 1;
    power = 1;

    setScale (1.0);
    setX (x); setY (y);
  }

  // フレームごとの処理 (サブクラスでオーバーライドする)
  public function update () : Void {
    
  }

  // 当たり判定 (半径でのみ判定)
  public function isHit (mover : Mover) : Bool {
    if (!(active && mover.active)) return false;
    var dx = mover.cx - cx;
    var dy = mover.cy - cy;
    var hit = mover.hitRange * mover.scale + hitRange * scale;

    return dx*dx + dy*dy < hit*hit;
  }

  public function setX (x : Float) {
    this.x = x;
    graphic.x = - graphic.width / 2.0;
    return cx = x;
  }

  public function setY (y : Float) {
    this.y = y;
    graphic.y = - graphic.height / 2.0;
    return cy = y;
  }

  function setGraphic (path:String) {
    graphic = GraphicCache.loadGraphic (path);
  }

  public function setScale (scale : Float) {
    scaleX = scale; scaleY = scale;
    return this.scale = scale;
  }

  public function setAngle (angle : Float) {
    rotation = angle;
    
    return this.angle = angle;
  }
}