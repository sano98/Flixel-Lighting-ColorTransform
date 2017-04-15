package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.GraphicLogo;
import flixel.graphics.frames.FlxFilterFrames;
import flash.filters.BitmapFilter;
import flash.filters.GlowFilter;
import Fruit;
import Apple;

/**
 * Test project for button glow filter.
 * Press "G" on the keyboard to toggle the glow over the flixel icon.
 * Removing the glow without the presence of the buffer sprite causes an Invalid Bitmap Error.
 * Written by sano98.
 * 
 */

 
class PlayState extends FlxState
{
	
	
	override public function create():Void
	{
		
		var myRecipe:FoodRecipe = new FoodRecipe(Apple);
		
		
	}
	
	
	
	public static function juicynessChecker(myFruit:Class<Fruit>):Int
	{
		return (Reflect.field(myFruit, "juicyness"));
	}
	
	
}
