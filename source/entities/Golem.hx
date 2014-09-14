package source.entities;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;

/**
 * @author Tiago Ling Alexandre
 */

class Golem extends FlxSprite
{
	public var onAir:Bool;
	public var isPunching:Bool;
	public var isStomping:Bool;
	private var screenCenter:Int;
	
	public function new(X:Float = 0, Y:Float = 0, SimpleGraphic:Dynamic = null) 
	{
		super(X, Y, SimpleGraphic);
		
		init();
	}
	
	private function init():Void {
		//makeGraphic(32, 32, 0xff0000ff);
		loadGraphic("assets/golem/golem_sheet.png", true, true, 134, 170);
		addAnimation("WALK", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 12, true);
		addAnimation("JUMP", [12, 13, 14, 15, 15], 12, false);
		addAnimation("STOMP", [16, 16, 17, 17, 18, 18], 12, false);
		addAnimation("STUN", [19, 19, 20, 20, 21, 21, 22, 22], 12, false);
		addAnimation("PUNCH", [23, 23, 24, 24, 25, 25, 25], 12, false);
		addAnimationCallback(animCallback);
		maxVelocity.x = 300;
		maxVelocity.y = 800;
		acceleration.y = 800;
		drag.x = maxVelocity.x * 4;
		play("WALK");
		onAir = false;
		isPunching = false;
		isStomping = false;
		offset.x = 50;
		width -= 100;
		offset.y = 70;
		height -= 80;
		screenCenter = Std.int((FlxG.width / 2) - (this.width / 2));
		
		FlxG.play("assets/walk_v4.mp3", 0.1, true);
	}
	
	public function handleMovement():Void {
/*		if (FlxG.keys.A) {
			setFacing(FlxObject.LEFT);
			acceleration.x = -maxVelocity.x * 4;
		}*/
		
		if (FlxG.keys.justPressed("D") && !isPunching) {
			//setFacing(FlxObject.RIGHT);
			isPunching = true;
			velocity.x = 100;
			play("PUNCH");
		}
		
		if (FlxG.keys.W && isTouching(FlxObject.FLOOR)) {
			velocity.y = -maxVelocity.y / 1.5;
			onAir = true;
			play("JUMP");
		}
		
		if (FlxG.keys.S && onAir && !isStomping) {
			play("STOMP");
			velocity.y = maxVelocity.y;
			isStomping = true;
		}
	}
	
	override public function update():Void {
		super.update();
		
		if (velocity.y == 0 && onAir) {
			play("WALK");
			onAir = false;
		}
		
		if (this.x < screenCenter) {
			velocity.x = 80;
		} else {
			velocity.x = 0;
		}
		
	}
	
/*	public function returnToCenter():Void {
		FlxG.tween(this, { x:(FlxG.width / 2) - (this.width / 2) }, 2);
	}*/
	
	#if (neko || cpp)
	private function animCallback(name:String, fNumber:Int, fIndex:Int):Void {
	#else
	private function animCallback(name:String, fNumber:UInt, fIndex:UInt):Void {
	#end
		if (name == "STOMP" && fNumber == 5) {
			play("WALK");
			//onAir = false;
			//isStomping = false;
		}
		
		if (name == "PUNCH" && fNumber == 6) {
			play("WALK");
			//trace("TEST");
			isPunching = false;
		}
		
		if (name == "STUN" && fNumber == 7) {
			play("WALK");
		}
		
/*		if (name == "JUMP" && velocity.y == 0) {
			play("WALK");
			onAir = false;
		}*/
	}
}