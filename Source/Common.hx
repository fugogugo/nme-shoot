#if (!munit_test)
import nme.Lib;
#end

class Common {
  #if (ios)
  public static inline var WIDTH = 600;
  public static inline var HEIGHT = 960;
  #else
  public static inline var WIDTH = 600.0;
  public static inline var HEIGHT = 700.0;
  #end

  static var frameRate : Float;

  static var slow = 1.0;

  public static function initialize () {
    #if (munit_test)
    frameRate = 60.0;
    #else
    frameRate = Lib.stage.frameRate;
    #end
  }

  public static function setSlow (slow : Float) {
    #if (munit_test)
    frameRate = 60.0 * slow;
    #else
    frameRate = Lib.stage.frameRate * slow;
    #end
    Common.slow = slow;
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