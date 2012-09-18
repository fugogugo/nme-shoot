package ;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.hamcrest.MatchersBase;
import Common;

/**
* Auto generated MassiveUnit Test Class  for Common 
*/
class CommonTest extends MatchersBase
{
	var instance:Common; 
	
	public function new() 
	{
		super ();
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
    Common.initialize ();
    Common.setSlow (1.0);
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	
	@Test
	public function testRadToDeg():Void
	{
		assertThat (Common.radToDeg (0.0), equalTo (0.0));
    assertThat (Common.radToDeg (Math.PI), equalTo (180.0));
    assertThat (Common.radToDeg (2.0 * Math.PI), equalTo (360.0));
    assertThat (Common.radToDeg (3.0 * Math.PI), equalTo (540.0));
    assertThat (Common.radToDeg (-Math.PI), equalTo (-180.0));
	}

  @Test
	public function testDegToRad():Void
	{
		assertThat (Common.degToRad (0.0), equalTo (0.0));
    assertThat (Common.degToRad (180.0), equalTo (Math.PI));
    assertThat (Common.degToRad (360.0), equalTo (2.0 * Math.PI));
    assertThat (Common.degToRad (540.0), equalTo (3.0 * Math.PI));
    assertThat (Common.degToRad (-180.0), equalTo (-Math.PI));
	}

  @Test
	public function testFrameRate():Void
	{
    assertThat (Common.getFrameRate (), equalTo (60.0));
    Common.setSlow (2.0);
    assertThat (Common.getFrameRate (), equalTo (120.0));
  }

  @Test
	public function testPerFrameRate():Void
	{
    assertThat (Common.perFrameRate (60.0), equalTo (1.0)); 
    assertThat (Common.perFrameRate (30.0), equalTo (0.5));
    assertThat (Common.perFrameRate (0.0), equalTo (0.0));
  }
}