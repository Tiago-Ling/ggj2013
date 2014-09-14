package entities;
import org.flixel.FlxG;
import org.flixel.FlxSprite;

/**
 * @author Tiago Ling Alexandre
 */

class Rock extends FlxSprite
{

	public function new() 
	{
		super();
		init();
	}
	
	private function init():Void {
		loadGraphic("assets/pedra.png", true, false, 134, 134);
		addAnimation("IDLE", [0], 12, true);
		addAnimation("BREAK", [1, 1, 2, 2], 12, false);
		play("IDLE");
		//maxVelocity.x = 300;
		//maxVelocity.y = 800;
		//acceleration.y = 800;
		//drag.x = maxVelocity.x * 4;
		
		//drag.x = 1500;
	}
	
	override public function update():Void {
		super.update();
		
		velocity.y = 200;
		
		if (this.x < FlxG.camera.scroll.x) {
			trace("OFF SCREEN");
			exists = false;
		}
	}
}