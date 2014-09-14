package ;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;

/**
 * @author Tiago Ling Alexandre
 */

class HowToState extends FlxState
{
	private var background:FlxSprite;
	
	public function new() 
	{
		super();
		
	}
	
	override public function create():Void {
		background = new FlxSprite(0, 0);
		background.loadGraphic("assets/howToPlay.png");
		add(background);
	}
	
	override public function update():Void {
		super.update();
		
		if (FlxG.keys.justPressed("ESCAPE")) {
			FlxG.fade(0xFF000000, 1, false, goToMenu);
		}
	}
	
	private function goToMenu():Void {
		FlxG.switchState(new MenuState());
	}
	
	override public function destroy():Void {
		super.destroy();
		
		background = null;
	}
	
}