package ;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.plugin.photonstorm.FlxButtonPlus;
import org.flixel.plugin.photonstorm.FlxExtendedSprite;

/**
 * @author Tiago Ling Alexandre
 */

class MenuState extends FlxState
{
	private var btnPlay:FlxButtonPlus;
	private var btnHowTo:FlxButtonPlus;
	private var btnCredits:FlxButtonPlus;
	private var logo:FlxSprite;
	private var bobo:FlxSprite;
	
	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
	{
		var bg:FlxSprite = new FlxSprite(0, 0);
		bg.loadGraphic("assets/background_final.jpg");
		add(bg);
		
		logo = new FlxSprite(0, 30);
		logo.loadGraphic("assets/LOGO.png");
		logo.x = (FlxG.width / 2) - logo.width / 2;
		add(logo);
		
		bobo = new FlxSprite(0, 0);
		bobo.loadGraphic("assets/backgroundA/jumpBobo.png", true, false, 1024, 600);
		bobo.addAnimation("IDLE", [0], 12, true);
		bobo.addAnimation("JUMP", [1, 2, 3, 4, 5, 6, 7], 12, false);
		bobo.addAnimationCallback(animCallback);
		add(bobo);
		
		btnPlay = new FlxButtonPlus(0, 250, showBoboAnimation, null, null, 336, 116);
		var bt:FlxExtendedSprite = new FlxExtendedSprite();
		bt.loadGraphic("assets/Button_PLAY.png");
		
		var btO:FlxExtendedSprite = new FlxExtendedSprite();
		btO.loadGraphic("assets/Button_PLAY_Over.png");
		
		btnPlay.loadGraphic(bt, btO);
		add(btnPlay);
		btnPlay.x = Std.int((FlxG.width / 2) - btnPlay.width / 2);
		
		btnHowTo = new FlxButtonPlus(0, 380, fadeToTutorial, null, null, 336, 116);
		bt = new FlxExtendedSprite();
		bt.loadGraphic("assets/Button_HowPlay.png");
		
		btO = new FlxExtendedSprite();
		btO.loadGraphic("assets/Button_HowPlay_Over.png");
		
		btnHowTo.loadGraphic(bt, btO);
		add(btnHowTo);
		btnHowTo.x = Std.int((FlxG.width / 2) - btnHowTo.width / 2);
		
		btnCredits = new FlxButtonPlus(0, 480, fadeToCredits, null, null, 336, 116);
		bt = new FlxExtendedSprite();
		bt.loadGraphic("assets/Button_Credits.png");
		
		btO = new FlxExtendedSprite();
		btO.loadGraphic("assets/Button_Credit_Over.png");
		
		btnCredits.loadGraphic(bt, btO);
		add(btnCredits);
		btnCredits.x = Std.int((FlxG.width / 2) - btnCredits.width / 2);
		
		FlxG.mouse.show();
	}
	
	private function animCallback(name:String, fNumber:UInt, fIndex:UInt):Void {
		if (name == "JUMP" && fNumber == 6) {
			//trace("OK");
			fadeToGame();
			bobo.visible = false;
		}
	}
	
	private function fadeToGame():Void {
		FlxG.fade(0xff000000, 1, false, finallyGoToGame);
	}
	
	private function finallyGoToGame():Void {
		FlxG.switchState(new GameState());
	}
	
	private function showBoboAnimation():Void {
		FlxG.tween(logo, { alpha:0 }, 1, {complete:goToGame});
		btnPlay.visible = false;
		btnHowTo.visible = false;
		btnCredits.visible = false;
	}
	
	private function goToGame():Void {
		bobo.play("JUMP");
	}
	
	private function fadeToTutorial():Void {
		FlxG.fade(0xff000000, 1, false, goToTutorial);
	}
	
	private function fadeToCredits():Void {
		FlxG.fade(0xff000000, 1, false, goToCredits);
	}
	
	private function goToTutorial():Void {
		FlxG.switchState(new HowToState());
	}
	
	private function goToCredits():Void {
		FlxG.switchState(new CreditState());
	}
	
	
	override public function destroy():Void {
		super.destroy();
		
		logo = null;
		btnPlay = null;
		btnHowTo = null;
		btnCredits = null;
	}
	
}