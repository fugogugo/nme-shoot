import nme.display.Sprite;
import nme.Lib;

// 敵クラス
class Enemy extends Mover {

  public var score (default, null) : Int;

  function new (initX:Float, initY:Float, graphic:Sprite) {
    
    score = 0;

    this.graphic = graphic;

    super (initX, initY, graphic);
    visible = false;
    active = false;
  }
}

// 複数の敵をまとめて処理するクラス
class EnemyFormation extends Enemy {

  public var enemies (default, null) : Array<Enemy>;
  var appearanceSec (default, null) : Float;
  var frameCount : Int;

  function new () {
    enemies = new Array<Enemy> ();
    graphic = new Sprite ();
    appearanceSec = 0.0;
    frameCount = 0;
    super (0.0, 0.0, graphic);
    active = false;
    visible = false;
  }

  override public function update () {

    if (appearanceSec <= frameCount / Lib.stage.frameRate) {

      for (enemy in enemies) {
        enemy.visible = true;
        enemy.active = true;
        enemy.update ();
        if (!enemy.active) removeEnemy (enemy);
      }
      active = true;
      visible = true;
    }
    else {
      visible = false;
      for (enemy in enemies)
        enemy.visible = false;
    }
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
