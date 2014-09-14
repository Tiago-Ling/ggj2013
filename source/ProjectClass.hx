package;

import nme.Lib;
import org.flixel.FlxGame;
	
class ProjectClass extends FlxGame
{	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 1024;
		var ratioY:Float = stageHeight / 600;
		var ratio:Float = Math.min(ratioX, ratioY);
		//super(Math.floor(stageWidth / ratio), Math.floor(stageHeight / ratio), MenuState, ratio, 60, 60);
		//super(1024, 600, GameState, 1, 30, 30);
		super(1024, 600, IntroState, 1, 30, 30);
		//forceDebugger = true;
	}
}
