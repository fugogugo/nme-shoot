import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;

import nme.Assets;

class GraphicCache {

  static var graphicCache = new Hash <BitmapData> ();
  
  public static function loadGraphic (path:String, cache:Bool = true) {
    
    var bitmap : Bitmap;
    var bitmapData : BitmapData;

    if (cache) {
      
      if (!graphicCache.exists (path))
        graphicCache.set (path, Assets.getBitmapData (path));
      
      bitmap = new Bitmap (graphicCache.get (path));
    }
    else
      bitmap = new Bitmap (Assets.getBitmapData (path));
  
    var sprite = new Sprite ();
    sprite.addChild (bitmap);
    
    return sprite;
  }
}