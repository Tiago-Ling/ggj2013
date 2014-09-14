package ;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;

/**
 * @author Tiago Ling Alexandre
 */

class CreditState extends FlxState
{

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
	{
		var screen:FlxSprite = new FlxSprite(0, 0);
		screen.loadGraphic("assets/credits.png");
		add(screen);
	}
	
	override public function update():Void {
		if (FlxG.keys.justPressed("ESCAPE")) {
			//FlxG.switchState(new MenuState());
			FlxG.fade(0xff000000, 0.5, false, changeState);
		}
	}
	
	private function changeState():Void {
		FlxG.switchState(new MenuState());
	}
	
}