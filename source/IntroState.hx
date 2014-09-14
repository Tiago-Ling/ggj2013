package ;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.plugin.photonstorm.FlxDelay;

/**
 * @author Tiago Ling Alexandre
 */

class IntroState extends FlxState
{
	private var delay:FlxDelay;
	private var currentImg:Int;
	
	private var background:FlxSprite;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void {
		currentImg = 0;
		
		background = new FlxSprite(0, 0);
		background.loadGraphic("assets/intro/intro2.jpg");
		add(background);
		delay = new FlxDelay(2000);
		delay.callbackFunction = changeBackground;
		delay.start();
	}
	
	private function changeBackground():Void {
		switch (currentImg) {
			case 0:
				background.loadGraphic("assets/intro/intro3.jpg");
			case 1:
				background.loadGraphic("assets/intro/intro4.jpg");
			case 2:
				background.loadGraphic("assets/intro/intro5.jpg");
			case 3:
				background.loadGraphic("assets/intro/intro6.jpg");
			case 4:
				background.loadGraphic("assets/intro/intro7.jpg");
		}
		
		if (currentImg < 5) {
			delay.reset(2000);
			//delay.callbackFunction = fadeBackground;
			delay.callbackFunction = changeBackground;
			currentImg++;
			delay.start();
		} else {
			FlxG.switchState(new MenuState());
		}
	}
	
	private function fadeBackground():Void {
		FlxG.fade(0xff000000, 1, false, changeBackground);
	}
	
}