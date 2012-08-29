import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Assets;
import nme.Lib;

class Bullet extends Mover {
  private static inline var SPEED_PER_SECOND = 500.0;

  public function new (x:Float, y:Float) {
    
    var bitmap = new Bitmap (Assets.getBitmapData ("images/Bullet01.png"));
    var graphic = new Sprite ();
    graphic.addChild (bitmap);

    super (x, y, graphic);
  }

  override public function update () {
    setY(cy - SPEED_PER_SECOND / Lib.stage.frameRate);
  }
}