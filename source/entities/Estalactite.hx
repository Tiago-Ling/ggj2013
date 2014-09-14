package entities;
import org.flixel.FlxSprite;

/**
 * @author Tiago Ling Alexandre
 */

class Estalactite extends FlxSprite
{

	public function new(X:Float = 0, Y:Float = 0, SimpleGraphic:Dynamic = null) 
	{
		super(X, Y, SimpleGraphic);
		
		init();
	}
	
	private function init():Void {
		loadGraphic("assets/backgroundB/estalactite.png");
		
	}
	
	override public function update():Void {
		super.update();
		
		velocity.y = 300;
		
		if (this.y > 800) {
			exists = false;
		}
	}
	
}