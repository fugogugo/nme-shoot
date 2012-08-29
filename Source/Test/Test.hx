package;

class Test extends haxe.unit.TestCase {

	public static function main () {
    var r = new haxe.unit.TestRunner ();
    r.add ( new MoverTest () );

    r.run ();
	}
}