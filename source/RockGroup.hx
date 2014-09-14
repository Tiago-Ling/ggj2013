package ;
import entities.Estalactite;
import entities.Rock;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;

/**
 * @author Tiago Ling Alexandre
 */

class RockGroup extends FlxGroup
{

	public function new() 
	{
		super();
		init();
	}
	
	private function init():Void {
		for (i in 0...15) {
/*			var rock:FlxSprite = new FlxSprite(0, 0);
			rock.loadGraphic("assets/pedra.png", true, false, 134, 134);
			rock.addAnimation("IDLE", [0], 12, true);
			rock.addAnimation("DESTROY", [1, 1, 1, 1, 2, 2, 2, 2], 12, false);
			rock.exists = false;
			add(rock);*/
			var estalac:Estalactite = new Estalactite(0, 0);
			add(estalac);
			estalac.solid = false;
			estalac.exists = false;
			
			var roc:Rock = new Rock();
			add(roc);
			roc.exists = false;
		}
	}
	
	public function getRock():Estalactite {
		if (getFirstAvailable(Estalactite) != null) {
			return cast(getFirstAvailable(Estalactite), Estalactite);
		}
		return null;
	}
	
	public function getRockB():Rock {
		if (getFirstAvailable(Rock) != null) {
			return cast(getFirstAvailable(Rock), Rock);
		}
		return null;
	}
	
	
}