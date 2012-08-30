import KiteEnemy;
import Scene;
import nme.Lib;

// Stage1
class Stage1Scene extends GameScene {

  var frameCount : Int;
  static var stageEndSec = 17.0;

  public function new () {
    super ();

    frameCount = 0;
    
    addEnemyFormation (new KiteEnemyFormation (150.0, 0.0, 2.0));
    addEnemyFormation (new KiteEnemyFormation (300.0, 0.0, 2.0));
    addEnemyFormation (new KiteEnemyFormation (250.0, 0.0, 5.0));
    addEnemyFormation (new KiteEnemyFormation (200.0, 0.0, 6.0));
    addEnemyFormation (new KiteEnemyFormation (150.0, 0.0, 7.0));
    addEnemyFormation (new KiteEnemyFormation (250.0, 0.0, 8.0));
    addEnemyFormation (new KiteEnemyFormation (150.0, 0.0, 9.0));
    addEnemyFormation (new KiteEnemyFormation (300.0, 0.0, 10.0));
  }

  override public function update () :NextScene {
    super.update ();
    frameCount++;
    if (frameCount == stageEndSec * Lib.stage.frameRate) {
      var nextStage = new Stage2Scene (myShip, score, pressedFireButton);
      return Next (nextStage);
    }
    return Remaining;
  }
}


// Stage2
class Stage2Scene extends GameScene {
  public function new (myShip:MyShip, score:Int, pressedFireButton:Bool) {
    super (myShip, score, pressedFireButton);

    addEnemyFormation (new KiteEnemyFormation (130.0, 0.0, 1.0));
    addEnemyFormation (new KiteEnemyFormation (200.0, 0.0, 1.0));
    addEnemyFormation (new KiteEnemyFormation (300.0, 0.0, 1.0));
    addEnemyFormation (new KiteEnemyFormation (150.0, 0.0, 2.0));
    addEnemyFormation (new KiteEnemyFormation (300.0, 0.0, 2.0));
    addEnemyFormation (new KiteEnemyFormation (250.0, 0.0, 4.0));
    addEnemyFormation (new KiteEnemyFormation (200.0, 0.0, 5.0));
    addEnemyFormation (new KiteEnemyFormation (150.0, 0.0, 6.0));
    addEnemyFormation (new KiteEnemyFormation (250.0, 0.0, 7.0));
    addEnemyFormation (new KiteEnemyFormation (150.0, 0.0, 8.0));
    addEnemyFormation (new KiteEnemyFormation (200.0, 0.0, 9.0));
    addEnemyFormation (new KiteEnemyFormation (300.0, 0.0, 10.0));
  }
}