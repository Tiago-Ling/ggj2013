package;

import addons.FlxTilemapExt;
import entities.Estalactite;
import entities.Rock;
import nme.display.BitmapData;
import nme.Assets;
import nme.geom.Rectangle;
import nme.net.SharedObject;
import org.flixel.FlxAssets;
import org.flixel.FlxButton;
import org.flixel.FlxCamera;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxPath;
import org.flixel.FlxRect;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.FlxU;
import org.flixel.plugin.photonstorm.FlxMath;
import org.flixel.system.FlxTile;
import org.flixel.system.layer.Atlas;
import org.flixel.tweens.FlxTween;
import org.flixel.tweens.util.Ease;
import source.entities.Golem;
import source.entities.Warrior;
import source.system.AssetRegister;

class GameState extends FlxState
{
	private var warrior:Warrior;
	private var golem:Golem;
	private var camA:FlxCamera;
	private var camB:FlxCamera;
	private var tilemapA:FlxTilemapExt;
	private var tilemapB:FlxTilemapExt;
	
	private var skyA:FlxSprite;
	private var skyB:FlxSprite;
	private var rocksA:FlxSprite;
	private var rocksB:FlxSprite;
	
	private var caveBackA:FlxSprite;
	private var caveBackB:FlxSprite;
	private var caveMiddleA:FlxSprite;
	private var caveMiddleB:FlxSprite;
	private var caveFrontA:FlxSprite;
	private var caveFrontB:FlxSprite;
	
	private var golemCounter:FlxText;
	private var gCounter:Float;
	private var rGroup:RockGroup;
	
	private var lives:Array<FlxSprite>;
	
	private var rockSpawnCounter:Int;
	private var heart:FlxSprite;
	private var waterfall:FlxSprite;
	
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0xFFFFFF, a: 0xff};
		#end
		
		FlxG.setBgColor(0xFFFFFFFF);
		
		FlxG.mouse.hide();
		
		skyA = new FlxSprite(0, -200);
		skyA.loadGraphic("assets/backgroundA/backgroundA_sky.jpg");
		skyA.solid = false;
		
		skyB = new FlxSprite(1024, -200);
		skyB.loadGraphic("assets/backgroundA/backgroundA_sky.jpg");
		skyB.solid = false;
		
		rocksA = new FlxSprite(0, -200);
		rocksA.loadGraphic("assets/backgroundA/backgroundA_ground.png");
		rocksA.solid = false;
		
		rocksB = new FlxSprite(1024, -200);
		rocksB.loadGraphic("assets/backgroundA/backgroundA_ground.png");
		rocksB.solid = false;
		
		add(skyA);
		add(skyB);
		add(rocksA);
		add(rocksB);
		
		caveBackA = new FlxSprite(0, 300);
		caveBackA.loadGraphic("assets/backgroundB/fundo.jpg");
		caveBackA.solid = false;
		//caveBackA.scrollFactor.x = 0.2;
		caveBackA.scrollFactor.x = 0;
		caveBackB = new FlxSprite(1024, 300);
		caveBackB.loadGraphic("assets/backgroundB/fundo.jpg");
		caveBackB.solid = false;
		//caveBackB.scrollFactor.x = 0.2;
		caveBackB.scrollFactor.x = 0;
		caveMiddleA = new FlxSprite(0, 300);
		caveMiddleA.loadGraphic("assets/backgroundB/meio.png");
		caveMiddleA.solid = false;
		//caveMiddleA.scrollFactor.x = 0.5;
		caveMiddleA.scrollFactor.x = 0;
		caveMiddleB = new FlxSprite(1024, 300);
		caveMiddleB.loadGraphic("assets/backgroundB/meio.png");
		caveMiddleB.solid = false;
		//caveMiddleB.scrollFactor.x = 0.5;
		caveMiddleB.scrollFactor.x = 0;
		caveFrontA = new FlxSprite(0, 300);
		caveFrontA.loadGraphic("assets/backgroundB/frente.png");
		caveFrontA.solid = false;
		//caveFrontA.scrollFactor.x = 0.7;
		caveFrontA.scrollFactor.x = 0;
		caveFrontB = new FlxSprite(1024, 300);
		caveFrontB.loadGraphic("assets/backgroundB/frente.png");
		caveFrontB.solid = false;
		//caveFrontB.scrollFactor.x = 0.7;
		caveFrontB.scrollFactor.x = 0;
		
		add(caveBackA);
		add(caveBackB);
		add(caveMiddleA);
		add(caveMiddleB);
		add(caveFrontA);
		add(caveFrontB);
		//FlxG.visualDebug = true;
		
		tilemapA = new FlxTilemapExt();
		tilemapA.x = 0;
		tilemapA.y = -180;
		var mapA:String = AssetRegister.maps[0];
		tilemapA.loadMap(mapA, "assets/tile_sheet_ladoA.png", 32, 32, 0, 1);
		tilemapA.setTileProperties(2, FlxObject.ANY, stomp, null, 15);
		tilemapA.setSlopes([13], [12]);
		add(tilemapA);
		
		tilemapB = new FlxTilemapExt();
		//tilemapB.widthInTiles = 60;
		//tilemapB.heightInTiles = 15;
		var mapB:String = AssetRegister.maps[1];
		tilemapB.loadMap(mapB, "assets/TS_B.png", 64, 64, 0, 1, 1);
		tilemapB.setTileProperties(46, FlxObject.ANY, moelaHit);
		tilemapB.setTileProperties(47, FlxObject.ANY, warriorHit);
		//tilemapB.setTileProperties(3, FlxObject.ANY);
		//tilemapB.setTileProperties(4, FlxObject.NONE);
		//tilemapB.setSlopes([1, 2, 18, 19], [3, 4, 20, 21]);
		tilemapB.setSlopes([2, 3, 18, 19], [4, 5, 20, 21]);
		tilemapB.y = 300;
		add(tilemapB);
		
		golem = new Golem(0, -52);
		add(golem);
		golem.x = (FlxG.width / 2) - (golem.width / 2);
		
		warrior = new Warrior(256, 358);
		add(warrior);
		
		camA = new FlxCamera(0, 0, 1024, 300);
		camA.follow(golem);
		camA.setBounds(0, -180, tilemapA.width, tilemapA.height, true);
		//trace(tilemapA.width);
		FlxG.addCamera(camA);
		
		camB = new FlxCamera(0, 300, 1024, 300);
		camB.follow(warrior);
		camB.setBounds(0, 300, tilemapB.width, tilemapB.height);
		FlxG.addCamera(camB);
		
/*		var partition:FlxSprite = new FlxSprite(0, 275);
		partition.solid = false;
		partition.loadGraphic("assets/partition.png");
		add(partition);
		//var camC:FlxCamera = new FlxCamera(0, 275, Std.int(partition.width), Std.int(partition.height));
		var camC:FlxCamera = new FlxCamera(0, 275, 1024, 50);
		camC.follow(partition, FlxCamera.STYLE_NO_DEAD_ZONE);
		FlxG.addCamera(camC);
		partition.cameras = [camC];*/
		
		gCounter = 2400;
		rockSpawnCounter = 0;
		
		FlxG.worldBounds = new FlxRect(0, -1200, 20240, 2400);
		
		#if (cpp || neko)
		var atlas:Atlas = new Atlas("GameAtlas", 2048, 2048);
		warrior.atlas = atlas;
		golem.atlas = atlas;
		tilemapA.atlas = atlas;
		tilemapB.atlas = atlas;
		
		skyA.atlas = atlas;
		skyB.atlas = atlas;
		rocksA.atlas = atlas;
		rocksB.atlas = atlas;
		
		caveBackA.atlas = atlas;
		caveBackB.atlas = atlas;
		caveMiddleA.atlas = atlas;
		caveMiddleB.atlas = atlas;
		caveFrontA.atlas = atlas;
		caveFrontB.atlas = atlas;
		#end
		
		rGroup = new RockGroup();
		add(rGroup);
		
		lives = new Array<FlxSprite>();
		for (i in 0...4) {
			var life:FlxSprite = new FlxSprite(10 + (32 * i), 10);
			life.loadGraphic("assets/coracao_life.png");
			life.scrollFactor.x = 0;
			life.scrollFactor.y = 0;
			life.cameras = [camB];
			life.solid = false;
			//life.scrollFactor.x = 0;
			add(life);
			lives.push(life);
		}
		
		heart = new FlxSprite(15000, 310);
		heart.solid = false;
		heart.loadGraphic("assets/heart_sheet.png", true, false, 250, 250);
		heart.addAnimation("IDLE", [0, 0, 1, 1, 1, 2, 2], 12, true);
		heart.addAnimation("BREAK", [3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9], 12, false);
		heart.play("IDLE");
		add(heart);
		
		waterfall = new FlxSprite(15000, 0);
		waterfall.solid = false;
		waterfall.loadGraphic("assets/backgroundA/cachoeira.png", true, false, 365, 300);
		//waterfall.scrollFactor.x = 0.5;
		waterfall.velocity.x = -180;
		waterfall.addAnimation("IDLE", [0, 0, 1, 1, 2, 2], 12, true);
		waterfall.play("IDLE");
		add(waterfall);
		
		golemCounter = new FlxText(774, 10, 250, "Distance: 10000");
		golemCounter.setFormat(null, 24, 0xFFFFFF, "left", 0x000000, true);
		golemCounter.scrollFactor.x = 0;
		golemCounter.scrollFactor.y = 0;
		golemCounter.cameras = [camA];
		add(golemCounter);
		
		FlxG.playMusic("assets/bgm.mp3", 0.6);
	}
	
	override public function destroy():Void
	{
		super.destroy();
		
		warrior = null;
		golem = null;
		tilemapA = null;
		tilemapB = null;
		
		skyA = null;
		skyB = null;
		rocksA = null;
		rocksB = null;
		
		caveBackA = null;
		caveBackB = null;
		caveMiddleA = null;
		caveMiddleB = null;
		caveFrontA = null;
		caveFrontB = null;
	}

	override public function update():Void
	{
		FlxG.collide();
		
		golem.acceleration.x = 0;
		warrior.acceleration.x = 0;
		
		warrior.handleMovement();
		golem.handleMovement();
		
		super.update();
		
		updateBackgroundA();
		updateBackgroundB();
		
		if (warrior.overlaps(rGroup)) {
			//trace("Overlap!");
			//removeLife();
			if (!warrior.isStunned) {
				warrior.isStunned = true;
				FlxG.tween(warrior, { x:warrior.x - 70, y:warrior.y - 35 }, 0.3, { ease:Ease.quadOut, complete:warrior.doFlicker } );
				warrior.play("HIT");
				
				removeLife();
			}
		}
		
		//FlxG.collide(golem, rGroup, handleGolemRockCol);
		//FlxG.overlap(golem, rGroup, handleGolemRockCol);
		
		//gCounter -= Math.floor(FlxG.elapsed * 10);
		if (gCounter > 0) {
			gCounter -= Math.floor(FlxG.elapsed * 50);
			golemCounter.setText("Distance: " + gCounter);
		} else {
			golemCounter.setText("Distance: " + 0);
			FlxG.fade(0xff000000, 1, false, showGameOverB);
		}
		
		if (warrior.overlaps(heart)) {
			heart.play("BREAK");
			FlxG.fade(0xFF000000, 1, false, showGameOver);
		}
		
/*		//if (rockSpawnCounter < 500) {
		if (rockSpawnCounter < 250) {
			rockSpawnCounter += Std.int(FlxG.elapsed * 50);
		} else {
			for (i in 0...3) {
				var rock:Rock = rGroup.getRockB();
				rock.x = (golem.x + 512) + FlxMath.rand(1, 10) * (rock.width * 2);
				trace("rock pos : " + rock.x);
				rock.y = 50;
				rock.velocity.x = -180;
				rock.play("IDLE");
				//rock.drag.x = -1200;
				rock.exists = true;
			}
			//trace("Spawn!");
			rockSpawnCounter = 0;
		}*/
		
/*		if (golem.overlaps(waterfall))  {
			trace("ENDGAME");
			FlxG.fade(0xFF000000, 1, false, showGameOverB); 
		}*/
	}
	
	private function handleGolemRockCol(obj1:FlxObject, obj2:FlxObject):Void {
		//obj2.drag.x = 1500;
		if (golem.isPunching) {
			cast(obj2, Rock).play("BREAK");
			obj2.solid = false;
			obj2.velocity.y = 0;
		}
	}
	
	private function stomp(tile:FlxObject, obj:FlxObject):Void {
		if (golem.isStomping) {
			golem.onAir = false;
			golem.isStomping = false;
			camB.shake(0.025, 0.75);
			
			for (i in 0...6) {
				var estalac:Estalactite = rGroup.getRock();
				estalac.y = 300;
				estalac.x = (FlxMath.rand(0, 10) * estalac.width) + camB.scroll.x;
				estalac.exists = true;
				//add(estalac);
			}
			
/*			if (warrior.velocity.y != 0) {
				//trace("OK");
				warrior.isStunned = true;
				FlxG.tween(warrior, { x:warrior.x - 70, y:warrior.y - 35 }, 0.3, { ease:Ease.quadOut, complete:warrior.doFlicker } );
				warrior.play("HIT");
				
				for (i in 0...6) {
					var estalac:Estalactite = rGroup.getRock();
					estalac.y = 300;
					estalac.x = (FlxMath.rand(0, 10) * estalac.width) + camB.scroll.x;
					estalac.exists = true;
					//add(estalac);
				}
			}*/
		}
	}
	
	private function moelaHit(tile:FlxObject, obj:FlxObject):Void {
		//trace("HIT");
		if (warrior.isAttacking) {
			//trace("STAB");
			var cTile:FlxTile = cast(tile, FlxTile);
			
			//tilemapB.setTile(Std.int(tile.x / tile.width), Std.int(tile.y / tile.height), 4, true);
			tilemapB.setTileByIndex(cTile.index, 0, true);
			
			//FlxG.tween(golem, { x:golem.x - 200, y:golem.y - 35 }, 1.5, { complete:golem.returnToCenter } );
			FlxG.tween(golem, { x:golem.x - 200, y:golem.y - 35 }, 1.5 );
			
			camA.flash(0x66FF0000, 0.3);
			golem.play("STUN");
		}
	}
	
	private function warriorHit(tile:FlxObject, obj:FlxObject):Void {
		if (!warrior.isStunned) {
			warrior.isStunned = true;
			FlxG.tween(warrior, { x:warrior.x - 70, y:warrior.y - 35 }, 0.3, { ease:Ease.quadOut, complete:warrior.doFlicker } );
			warrior.play("HIT");
			
			removeLife();
		}
	}
	
	private function removeLife():Void {
		//trace("Remove life");
		var numLife:Int = lives.length;
		//trace("lives : " + numLife);
		if (numLife > 0) {
			remove(lives[numLife - 1]);
			lives.pop();
		} else {
			//GAME OVER
			FlxG.fade(0xff000000, 1, false, showGameOverB);
		}
	}
	
	//Warrior wins
	private function showGameOver():Void {
		FlxG.switchState(new GameOverState(0));
	}
	
	private function showGameOverB():Void {
		FlxG.switchState(new GameOverState(1));
	}
	
	private function updateBackgroundA():Void {
		
		if (skyA.x <= -1024) {
			skyA.x = 1024;
		}
		
		if (skyB.x <= -1024) {
			skyB.x = 1024;
		}
		
		if (skyA.x < skyB.x) {
			//skyA.x -= FlxG.elapsed * 20;
			skyA.x -= FlxG.elapsed * 40;
			skyB.x = skyA.x + 1024;
		} else {
			//skyB.x -= FlxG.elapsed * 20;
			skyB.x -= FlxG.elapsed * 40;
			skyA.x = skyB.x + 1024;
		}
		
		if (rocksA.x <= -1024) {
			rocksA.x = 1024;
		}
		
		if (rocksB.x <= -1024) {
			rocksB.x = 1024;
		}
		
		if (rocksA.x < rocksB.x) {
			//rocksA.x -= FlxG.elapsed * 50;
			rocksA.x -= FlxG.elapsed * 100;
			rocksB.x = rocksA.x + 1024;
		} else {
			//rocksB.x -= FlxG.elapsed * 50;
			rocksB.x -= FlxG.elapsed * 100;
			rocksA.x = rocksB.x + 1024;
		}
		
		if (tilemapA.x > ( -tilemapA.width + 1024)) {
			//tilemapA.x -= FlxG.elapsed * 90;
			tilemapA.x -= FlxG.elapsed * 180;
			//tilemapA.velocity.x = -180;
		}
	}
	
	private function updateBackgroundB():Void {
		if (caveBackA.x < -1024) {
			caveBackA.x = 1024;
		}
		
		if (caveBackB.x < -1024) {
			caveBackB.x = 1024;
		}
		
		if (caveMiddleA.x < -1024) {
			caveMiddleA.x = 1024;
		}
		
		if (caveMiddleB.x < -1024) {
			caveMiddleB.x = 1024;
		}
		
		if (caveFrontA.x < -1024) {
			caveFrontA.x = 1024;
		}
		
		if (caveFrontB.x < -1024) {
			caveFrontB.x = 1024;
		}
		
/*		if (caveBackA.x < caveBackB.x) {
			//skyA.x -= FlxG.elapsed * 20;
			caveBackA.x -= FlxG.elapsed * 40;
			caveBackB.x = caveBackA.x + 1024;
		} else {
			//skyB.x -= FlxG.elapsed * 20;
			caveBackB.x -= FlxG.elapsed * 40;
			caveBackA.x = caveBackB.x + 1024;
		}
		
		if (caveMiddleA.x < caveMiddleB.x) {
			//skyA.x -= FlxG.elapsed * 20;
			caveMiddleA.x -= FlxG.elapsed * 40;
			caveMiddleB.x = caveMiddleA.x + 1024;
		} else {
			//skyB.x -= FlxG.elapsed * 20;
			caveMiddleB.x -= FlxG.elapsed * 40;
			caveMiddleA.x = caveMiddleB.x + 1024;
		}
		
		if (caveFrontA.x < caveFrontB.x) {
			//skyA.x -= FlxG.elapsed * 20;
			caveFrontA.x -= FlxG.elapsed * 40;
			caveFrontB.x = caveFrontA.x + 1024;
		} else {
			//skyB.x -= FlxG.elapsed * 20;
			caveFrontB.x -= FlxG.elapsed * 40;
			caveFrontA.x = caveFrontB.x + 1024;
		}*/
	}
}