import nme.Lib;

class Common {
  public static inline var width = 600.0;
  public static inline var height = 700.0;
  public static var frameRate = 60.0;

  private static var slow = 1.0;

  public static function initialize () {
    frameRate = Lib.stage.frameRate;
  }

  public static function setSlow (slow : Float) {
    frameRate = Lib.stage.frameRate * slow;
    Common.slow = slow;
    return slow;
  }


  public static function radToDeg (rad : Float) {
    return rad / Math.PI * 180;
  }

  public static function degToRad (deg : Float) {
    return deg / 180 * Math.PI;
  }

  public static function perFrameRate (num : Float) {
    return num / frameRate;
  }
}