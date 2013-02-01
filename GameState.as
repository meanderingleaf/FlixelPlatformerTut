package  {
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxG;
	
	import org.flixel.FlxObject;

	public class GameState extends FlxState {

		//game assets
		[Embed(source = 'assets/player.png')] 
		private var playerImg:Class;

		[Embed(source = 'assets/tiles.png')] 
		private var tiles:Class;

		[Embed(source = 'assets/map.txt', mimeType = "application/octet-stream")] 
		private var mapText:Class;


		//
		public var player:FlxSprite;
		
		public var map:FlxTilemap;

		public function GameState() {
			//add tilemap
			var map = new FlxTilemap();
			map.loadMap(new mapText(), tiles);
			add(map);

			
			//make dah player
			player = new FlxSprite(0,0);
			
			player.loadGraphic(playerImg, true, true, 26, 34);
			
			player.addAnimation("jump", [2]);
			player.addAnimation("walk", [0,1], 2);
			player.addAnimation("stand", [1]);
			
			player.acceleration.y = 100;
			player.drag.x = 75;
			player.x = 30;
			player.y = 100;
			
			add(player);
			
			player.play("walk");
		}
	
		override public function update():void {
			super.update();
			FlxG.camera.follow(player);
			FlxG.collide(map, player);
			
			if(player.velocity.y == 0) {
				player.play("walk");
			}
			
			//reset accel
			player.acceleration.x = 0;
			
			if(FlxG.keys.LEFT) {
				//move left
				player.acceleration.x = -90;
				player.facing = FlxObject.LEFT;
			}
			
			if(FlxG.keys.RIGHT) {
				player.acceleration.x = 90;
				player.facing = FlxObject.RIGHT;
			}
			
			if(FlxG.keys.UP && player.velocity.y == 0) {
				player.play("jump", true);
				player.velocity.y = -82;
			}
		}

	}
	
}
