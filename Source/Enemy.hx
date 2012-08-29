import nme.display.Sprite;
import nme.Lib;

// 敵クラス
class Enemy extends Mover {

  public var score (default, null) : Int;

  function new (initX:Float, initY:Float, graphic:Sprite) {
    
    score = 0;

    this.graphic = graphic;

    super (initX, initY, graphic);
  }
}

// 複数の敵をまとめて処理するクラス
class EnemyFormation extends Enemy {

  public var enemies (default, null) : Array<Enemy>;
  var appearSec (default, null) : Float;
  var frameCount : Int;

  function new () {
    enemies = new Array<Enemy> ();
    graphic = new Sprite ();
    appearSec = 0.0;
    frameCount = 0;
    super (0.0, 0.0, graphic);
    visible = false;
  }

  override public function update () {

    if (appearSec <= frameCount / Lib.stage.frameRate) {
      if (!visible) visible = true;
      for (enemy in enemies) {
        enemy.update ();
     
        if (!enemy.active) removeEnemy (enemy);
      }
    }
    else visible = false;
    frameCount++;
  }

  public function addEnemy (enemy : Enemy) {
    enemies.push (enemy);
    addChild (enemy);
  }

  public function removeEnemy (enemy : Enemy) {
    enemies.remove (enemy);
    removeChild (enemy);
  }
}