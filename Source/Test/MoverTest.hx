package;

import nme.display.Sprite;

private class TestMover extends Mover {
  
  public function new (x : Float, y : Float, range : Float) {
    super (x, y, new Sprite ());
    cx = x; cy = y;
    hitRange = range;
  }
}

class MoverTest extends haxe.unit.TestCase {

  var mover : TestMover;

  public function new () {
    super ();
    mover = new TestMover (0.0, 0.0, 0.0);
  }
  
  public function testIsHit () {

    assertFalse ( mover.isHit (new TestMover (3.0, 4.0, 5.0) ));
    assertTrue ( mover.isHit (new TestMover (3.0, 4.0, 5.1) ));
    assertFalse (mover.isHit (new TestMover (0.0, 0.0, 0.0) ));
    assertTrue (mover.isHit (new TestMover (0.0, 0.0, 0.1) ));
  }
}