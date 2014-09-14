package source.entities;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.plugin.photonstorm.FlxDelay;

/**
 * @author Tiago Ling Alexandre
 */

class Warrior extends FlxSprite
{
	public var isStunned:Bool;
	public var isJumping:Bool;
	public var isAttacking:Bool;
	
	public function new(X:Float = 0, Y:Float = 0, SimpleGraphic:Dynamic = null)
	{
		super(X, Y, SimpleGraphic);
		isStunned = false;
		isJumping = false;
		isAttacking = false;
		init();
		
	}
	
	private function init():Void {
		maxVelocity.x = 300;
		maxVelocity.y = 500;
		acceleration.y = 500;
		drag.x = maxVelocity.x * 4;
		loadGraphic("assets/warrior/total_sheet3.png", true, true, 100, 104);
		addAnimation("JUMP", [0, 0, 1, 1, 1, 1, 1, 1, 0, 0], 12, false);
		addAnimation("HIT", [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], 12, false); 
		addAnimation("STAB", [3, 3, 4, 4, 5, 5], 12, false);
		addAnimation("STOP", [6, 6, 7, 7], 12, false);
		addAnimation("WALK", [8, 9, 10, 11, 12, 13], 12, true);
		addAnimation("FALL", [0, 0, 0, 0], 12, true);
		addAnimationCallback(animCallback);
		play("STOP");
		
		offset.x = 40;
		width -= 80;
		offset.y = 36;
		height -= 40;
	}
	
	public function handleMovement():Void {
		//if (FlxG.keys.LEFT && !isStunned) {
		if (FlxG.keys.LEFT) {
			acceleration.x = -maxVelocity.x * 4;
			setFacing(FlxObject.LEFT);
			if (!isJumping) {
				play("WALK");
			}
		}
		
		//if (FlxG.keys.RIGHT && !isStunned) {
		if (FlxG.keys.RIGHT) {
			acceleration.x = maxVelocity.x * 4;
			setFacing(FlxObject.RIGHT);
			if (!isJumping) {
				play("WALK");
			}
		}
		
		//if (FlxG.keys.UP && isTouching(FlxObject.FLOOR) && !isStunned) {
		if (FlxG.keys.UP && isTouching(FlxObject.FLOOR)) {
			velocity.y = -maxVelocity.y / 1.5;
			isJumping = true;
			play("JUMP");
		}
		
		if (FlxG.keys.justPressed("SPACE") && velocity.y != 0) {
			play("STAB");
			//velocity.y = -maxVelocity.y / 1.5;
			isAttacking = true;
		}
	}
	
	public function doFlicker():Void {
		//isStunned = false;
		flicker(1.5);
		var delay:FlxDelay = new FlxDelay(1500);
		delay.callbackFunction = resetStun;
		delay.start();
	}
	
	private function resetStun():Void {
		isStunned = false;
	}
	
	override public function update():Void {

		super.update();
		
		if (velocity.y == 0 && isJumping) {
			play("STOP");
			isJumping = false;
		}
	}
	
	#if (neko || cpp)
	private function animCallback(name:String, fNumber:Int, fIndex:Int):Void {
	#else
	private function animCallback(name:String, fNumber:UInt, fIndex:UInt):Void {
	#end
		if (name == "HIT" && fNumber == 11) {
			isStunned = false;
			play("STOP");
			//trace(" sldksjd");
		}
		
		if (name == "WALK" && velocity.x == 0) {
			play("STOP");
		}
		
		if (name == "STAB" && fNumber == 5) {
			play("FALL");
			isAttacking = false;
		}
	}
	
}