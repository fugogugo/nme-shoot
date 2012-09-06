import nme.display.Sprite;
import Scene;
import StageScene;

class StartScene extends Scene {
  static inline var TITLE_GRAPHIC_PATH = "images/StartTitle.png";
  static inline var START_TEXT_GRAPHIC_PATH = "images/StartText.png";
  var titleGraphic : Sprite;
  var startTextGraphic : Sprite;

  public function new () {
    super ();

    // タイトル 
    var titleSprite = new Sprite ();
    titleGraphic = GraphicCache.loadGraphic (TITLE_GRAPHIC_PATH);
    titleGraphic.x = - titleGraphic.width / 2.0;
    titleGraphic.y = - titleGraphic.height / 2.0;
    titleGraphic.alpha = 0.0;
    titleSprite.addChild (titleGraphic);
    titleSprite.x = Common.WIDTH / 2.0;
    titleSprite.y = 150.0;
    addChild (titleSprite);

    var startTextGraphicSprite = new Sprite ();
    startTextGraphic = GraphicCache.loadGraphic (START_TEXT_GRAPHIC_PATH);
    startTextGraphic.x = - startTextGraphic.width / 2.0;
    startTextGraphic.y = - startTextGraphic.height / 2.0;
    startTextGraphicSprite.addChild (startTextGraphic);
    startTextGraphicSprite.x = Common.WIDTH / 2.0;
    startTextGraphicSprite.y = Common.HEIGHT / 2.0 + 100.0;
    startTextGraphic.visible = false;
    addChild (startTextGraphicSprite);
  }

  override public function update () {
    super.update ();
    var alphaSec = 2.5;
    if (Common.perFrameRate (frameCount ()) < alphaSec) {
      titleGraphic.alpha = Common.perFrameRate (frameCount ()) / alphaSec;
      startTextGraphic.visible = false;
    }
    else {
      startTextGraphic.visible = true;
      if (KeyboardInput.pressedZ)
        return Next (new Stage1Scene ());
    }

    return Remaining;
  }
}