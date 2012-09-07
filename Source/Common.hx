import nme.Lib;

class Common {
  #if (ios)
  public static inline var WIDTH = 640;
  public static inline var HEIGHT = 960;
  #else
  public static inline var WIDTH = 600.0;
  public static inline var HEIGHT = 700.0;
  #end

  static var frameRate : Float;

  static var slow = 1.0;

  public static function initialize () {
    frameRate = Lib.stage.frameRate;
  }

  public static function setSlow (slow : Float) {
    frameRate = Lib.stage.frameRate * slow;
    Common.slow = slow;
    return slow;
  }

  public static function getFrameRate () {
    return frameRate;
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