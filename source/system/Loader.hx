package source.system;

import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.net.URLLoader;
import nme.net.URLRequest;
import Type;

/**
 * @author Tiago Ling Alexandre
 */

class Loader extends Sprite
{
	private var uLoader:URLLoader;
	private var filesToLoad:Array<String>;
	private var currentFile:Int;
	private var totalFiles:Int;
	private var loadCallback:Void->Void;
	
	public function new(files:Array<String>, callBack:Void->Void) 
	{
		super();
		filesToLoad = files;
		loadCallback = callBack;
		currentFile = 0;
		totalFiles = filesToLoad.length;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		var req:URLRequest = new URLRequest(filesToLoad[currentFile]);
		uLoader = new URLLoader();
		uLoader.addEventListener(Event.COMPLETE, onComplete);
		uLoader.load(req);
	}
	
	private function onComplete(e:Event):Void {
		//trace("currentFile : " + currentFile);
		if (Std.is(e.target.data, String) == true) {
			if (AssetRegister.maps == null) {
				AssetRegister.maps = new Array<String>();
			}
			AssetRegister.maps.push(e.target.data);
		}
		
		currentFile++;
		
		if (currentFile < totalFiles) {
			var req:URLRequest = new URLRequest(filesToLoad[currentFile]);
			uLoader.load(req);
		} else {
			removeEventListener(Event.COMPLETE, onComplete);
			loadCallback();
		}
	}
	
}