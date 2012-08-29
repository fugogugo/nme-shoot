package;

private class TestMover extends Mover {
  
  public function new (x : Float, y : Float, range : Float) {
    super ();
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

  public function testIsHitWithArray () {
    var arr = [castMover (new TestMover (3.0, 4.0, 5.0)), castMover (new TestMover (0.0, 0.0, 0.0))];
    assertFalse ( mover.isHitWithArray (arr) );

    arr = [castMover (new TestMover (3.0, 4.0, 5.1))];
    assertTrue ( mover.isHitWithArray (arr) );
  }

  private function castMover (testMover : TestMover) {
    return cast (testMover, Mover);
  }
}