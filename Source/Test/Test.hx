package;

import nme.Lib;

class Test extends haxe.unit.TestCase {

	public static function main () {
    var r = new haxe.unit.TestRunner ();
    r.add ( new MoverTest () );
    r.add ( new BulletTest () );

    r.run ();
    Lib.exit ();
	}
}