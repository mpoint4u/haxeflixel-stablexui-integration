package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
//import flixel.math.FlxMath;
import flixel.util.FlxMath;
//import flixel.math.FlxRandom;
import flixel.util.FlxRandom;


import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.text.FlxText;
import flixel.util.FlxColor;

import openfl.Lib;


class PlayState extends FlxState
{
	private var currentPolicy:FlxText;
	private var scaleModes:Array<ScaleMode> = [RATIO_DEFAULT, RATIO_FILL_SCREEN, FIXED, RELATIVE, FILL];
	private var scaleModeIndex:Int = 0;

	override public function create():Void
	{
		add(new FlxSprite(0, 0, "assets/bg.png"));
		
		for (i in 0...20)
		{
			//add(new Ship(FlxG.random.int(50, 100), FlxG.random.int(0, 360)));

			add(new Ship(FlxRandom.intRanged(50,100),FlxRandom.intRanged(0,360)));

		}
		
		currentPolicy = new FlxText(0, 10, FlxG.width, ScaleMode.RATIO_DEFAULT);
		//currentPolicy.alignment = CENTER;
		currentPolicy.alignment = "CENTER";


		currentPolicy.size = 16;
		add(currentPolicy);
		
		var info:FlxText = new FlxText(0, FlxG.height - 40, FlxG.width, "Press space or click to change the scale mode");
		//info.setFormat(null, 14, FlxColor.WHITE, CENTER);
		info.setFormat(null, 14, FlxColor.WHITE,"CENTER");

		info.alpha = 0.75;
		add(info);
	}
	
	override public function update():Void
	{
		if (FlxG.keys.justPressed.SPACE || FlxG.mouse.justPressed)
			
			{
								//trace("scaleModeIndex before = " + scaleModeIndex);
				scaleModeIndex = FlxMath.wrapValue(scaleModeIndex, 1, scaleModes.length);
				trace("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+");				
				trace("scaleModeIndex after recalc = " + scaleModeIndex);

				//setting the next ScaleMode... 				
				setScaleMode(scaleModes[scaleModeIndex]);

				// some calcs for understanding resolutions in HaxeFlixel ...  
				trace("-------------------------------------");
				trace("openfl.Lib.current.stage.stageWidth : " + Lib.current.stage.stageWidth + " px");
				trace("openfl.Lib.current.stage.stageHeight : " + Lib.current.stage.stageHeight + " px");
				trace("-------------------------------------");				
				//trace("FlxG.stage.stageWidth : " + FlxG.stage.stageWidth + " px");												
				//trace("FlxG.stage.stageHeight : " + FlxG.stage.stageHeight + " px");
				//trace("-------------------------------------");												
				trace("FlxG.game.width : " + FlxG.game.width + " px");
				trace("FlxG.game.height : " + FlxG.game.height + " px");
				trace("-------------------------------------");

				var ratioX:Float = FlxMath.roundDecimal (
												//100*(Lib.current.stage.stageWidth / FlxG.game.width),

												100*(FlxG.game.width / Lib.current.stage.stageWidth),

												 4 );
					trace("ratioX = " + ratioX + " %");

				var ratioY:Float = FlxMath.roundDecimal (
												//100*(Lib.current.stage.stageHeight / FlxG.game.height),

												100*(FlxG.game.height / Lib.current.stage.stageHeight),


												 4 );
					trace("ratioY = " + ratioY + " %");

				trace("-------------------------------------");

				var newzoom:Float = FlxMath.roundDecimal (
												Math.min(ratioX, ratioY), 2 
														   );
					trace("effective zoom now = " + newzoom + " %");
			}
		
		super.update();
	}
	
	private function setScaleMode(scaleMode:ScaleMode)
	{
		currentPolicy.text = scaleMode;
		
		FlxG.scaleMode = switch (scaleMode)
		{
			case ScaleMode.RATIO_DEFAULT:
				trace("going to ScaleMode.RATIO_DEFAULT");
				new RatioScaleMode();
				
			case ScaleMode.RATIO_FILL_SCREEN:
				trace("going to ScaleMode.RATIO_FILL_SCREEN");
				new RatioScaleMode();

			case ScaleMode.FIXED:
				trace("going to ScaleMode.FIXED");
				new FixedScaleMode();

			case ScaleMode.RELATIVE:
				trace("going to ScaleMode.RELATIVE");
				new RelativeScaleMode(0.75, 0.75);
				
			case ScaleMode.FILL:
				trace("going to ScaleMode.FILL");
				new FillScaleMode();
		}
	}
}

@:enum
abstract ScaleMode(String) to String
{
	var RATIO_DEFAULT = "ratio";
	var RATIO_FILL_SCREEN = "ratio (screenfill)";
	var FIXED = "fixed";
	var RELATIVE = "relatvive 75%";
	var FILL = "fill";
}