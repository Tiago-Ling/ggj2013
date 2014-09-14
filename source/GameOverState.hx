package ;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;

/**
 * @author Tiago Ling Alexandre
 */

class GameOverState extends FlxState
{
	private var gameOverType:Int;
	private var levelAsset:String;
	private var charName:String;
	
	public function new(type:Int = 0) 
	{
		super();
		gameOverType = type;
	}
	
	override public function create():Void {
		switch (gameOverType) {
			case 0:	//Warrior wins!
				//trace("Warrior Wins!");
				levelAsset = "assets/warriorWin.jpg";
				charName = "Le Bobo";
			case 1:	//Golem wins!
				//trace("Golem Wins!");
				levelAsset = "assets/golemWin.jpg";
				charName = "Golem";
		}
		
		var bg:FlxSprite = new FlxSprite(0, 0);
		bg.loadGraphic(levelAsset);
		add(bg);
		
		var instruction:FlxText = new FlxText(0, 505, 934, charName + " wins!");
		instruction.setFormat("assets/data/GOODGIRL", 52, 0xFFFFFF, "right", 0x000000, true);
		add(instruction);
		
		var textB:FlxText = new FlxText(0, 565, 984, "Press ESC to return to the main menu");
		textB.setFormat(null, 20, 0xffffff, "right", 0x000000, true);
		add(textB);
	}
	
	override public function update():Void {
		super.update();
		
		if (FlxG.keys.justPressed("ESCAPE")) {
			FlxG.switchState(new MenuState());
		}
	}
	
}