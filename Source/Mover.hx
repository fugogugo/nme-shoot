import nme.display.Sprite;

// ゲームオブジェクトのクラス
class Mover extends Sprite {

  // 当たり判定の範囲
  public var hitRange (default, null) : Float;

  // 角度
  public var angle (default, setAngle) : Float;

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

  var frameCount : Int;



  public function new (x:Float = 0.0, y:Float = 0.0, image:Sprite) {
    super ();

    graphic = image; addChild (graphic);
    active = true;

    hitRange = 0.0;
    active = true;
    hp = 1;
    power = 1;

    setScale (1.0);
    this.x = x; this.y = y;

    graphic.x = - graphic.width / 2.0;
    graphic.y = - graphic.height / 2.0;

    frameCount = 0;
  }

  // フレームごとの処理
  public function update (scene : Scene) : Void {
    ++frameCount;
  }

  // 当たり判定 (半径でのみ判定)
  public function isCollision (mover : Mover) : Bool {
    if (!(active && mover.active)) return false;
    var dx = mover.x - x;
    var dy = mover.y - y;
    var hit = mover.hitRange * mover.scale + hitRange * scale;

    return dx*dx + dy*dy < hit*hit;
  }

  function setGraphic (path:String) {
    graphic = GraphicCache.loadGraphic (path);
    graphic.x = - graphic.width / 2.0;
    graphic.y = - graphic.height / 2.0;
  }

  public function setScale (scale : Float) {
    scaleX = scale; scaleY = scale;
    return this.scale = scale;
  }

  public function setAngle (angle : Float) {
    rotation = angle;
    
    return this.angle = angle;
  }

  // 削除時のエフェクト (サブクラスでオーバーライドする)
  public function removeEffect (scene : Scene) {
  }

  // 衝突時のエフェクト (サブクラスでオーバーライドする)
  public function collisionEffect (scene : Scene) { 
  }
}