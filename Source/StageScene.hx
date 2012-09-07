import KiteEnemy;
import BossWithOptions;
import Scene;
import nme.Lib;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

// Stage1
class Stage1Scene extends GameScene {

  static inline var STAGE_END_SEC = 17.0;

  var titleTextField : TextField;


  public function new () {
    super ();

    titleTextField = new TextField ();
    addChild (titleTextField);
    
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (50.0, 0.0, 5.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (200.0, 0.0, 5.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (250.0, 0.0, 8.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (200.0, 0.0, 9.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (150.0, 0.0, 10.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (250.0, 0.0, 11.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (150.0, 0.0, 12.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (350.0, 0.0, 13.0));
  }


  override public function update () :NextScene {
    super.update ();

    if (titleTextField != null) {
      updateTitleTextField ("New Game Start!", Common.WIDTH / 4.0, Common.WIDTH / 2.0);
    }

    if (frameCount () >= Common.getFrameRate () * 3 && titleTextField != null) {
      removeChild (titleTextField); titleTextField = null;
    }

    if (frameCount () >= STAGE_END_SEC * Common.getFrameRate ()
        && GameObjectManager.myShip.active) {
      var nextStage = new Stage2Scene ();
      return Next (nextStage);
    }
    return continueGame(StartScene);
  }


  function updateTitleTextField (title:String, x:Float, y:Float) {
    titleTextField.text = title;
    titleTextField.selectable = false;
    titleTextField.width = 300.0;

    var tf = new TextFormat ("_sans", 30, 0x333333);

    // jsの場合、TextFieldの幅の設定がうまく行かないので
    // 自力でセンタリングを設定

    var w:Float = Common.WIDTH;
    var h:Float = Common.HEIGHT;

    titleTextField.x = (w - titleTextField.width) / 2;
    titleTextField.y = (h - titleTextField.height) / 2;


    tf.align = TextFormatAlign.CENTER;
    
    titleTextField.setTextFormat (tf);
    titleTextField.alpha = 30;
  }

}


// Stage2
class Stage2Scene extends GameScene {

  static inline var STAGE_END_SEC = 18.0;
  
  public function new () {
    super ();

    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (130.0, 0.0, 3.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (200.0, 0.0, 3.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (300.0, 0.0, 3.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (150.0, 0.0, 5.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (320.0, 0.0, 5.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (250.0, 0.0, 6.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (200.0, 0.0, 7.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (90.0, 0.0, 7.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (400.0, 0.0, 7.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (150.0, 0.0, 8.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (260.0, 0.0, 9.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (120.0, 0.0, 10.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (130.0, 0.0, 10.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (140.0, 0.0, 10.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (150.0, 0.0, 10.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (200.0, 0.0, 11.0));
    GameObjectManager.addEnemyFormation (this, new KiteEnemyFormation (350.0, 0.0, 12.0));
  }

  override public function update () :NextScene {
    super.update ();

    if (frameCount () >= STAGE_END_SEC * Common.getFrameRate ()
        && GameObjectManager.myShip.active) {
      var nextStage = new Stage3Scene ();
      return Next (nextStage);
    }
    return continueGame(StartScene);
  }
}


// Boss Stage
class Stage3Scene extends GameScene {

  var boss : BossWithOptions;
  var bossLifeTextField : TextField;

  public function new () {
    super ();

    boss = new BossWithOptions ();
    GameObjectManager.addEnemyFormation (this, boss);
    bossLifeTextField = new TextField ();
    addChild (bossLifeTextField);
  }


  override public function update () :NextScene {
    super.update ();
    if (boss.active)
      updateTextField (bossLifeTextField, "Boss : " + Std.string (boss.hp),
                       400.0, 0.0, 160.0, 20.0);

    else if (!boss.active && GameObjectManager.myShip.active)
      return Next (new Stage1Scene ());

    return continueGame(StartScene);
  }
}