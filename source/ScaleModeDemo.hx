package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class ScaleModeDemo extends Sprite 
{
	var gameWidth:Int = 320; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 240; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = PlayState; // The FlxState the game starts with.
	var zoom:Float = -1; //2; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	
	// You can pretty much ignore everything from here on - your code should go in your states.
	
/*	public static function main():Void
	{	
		Lib.current.addChild(new Main());
	}*/
	
	public function new() 
	{
		super();
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		setupGame();
	}
	
	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
			trace("stageWidth = " + stageWidth);
			trace("gameWidth = " + gameWidth);
		var stageHeight:Int = Lib.current.stage.stageHeight;
			trace("stageHeight = " + stageHeight);
			trace("gameHeight = " + gameHeight);

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
				trace("ratioX = " + ratioX);
			var ratioY:Float = stageHeight / gameHeight;
				trace("ratioY = " + ratioY);
			zoom = Math.min(ratioX, ratioY);
				trace("zoom = " + zoom);

			gameWidth = Math.ceil(stageWidth / zoom);
				trace("gameWidth recalc = " + gameWidth);			
			gameHeight = Math.ceil(stageHeight / zoom);
				trace("gameHeight recalc = " + gameHeight);			
		}

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
}