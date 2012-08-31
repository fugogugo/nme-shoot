import nme.utils.Timer;

class Debug {

  public static function countTime (f:Void -> Void) {
    var timer = new Timer (0.4);
    timer.start ();
    f ();
    timer.stop();
    trace (timer.currentCount);
  }
}