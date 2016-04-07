package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxSpriteUtil;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.BlendMode;
import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.effects.FlxFlicker;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	* An invisible dummy sprite which is moved by the mousewheel. It is as an anchor for camera movement.
	*/
	private var dolly:FlxSprite;
	
	/**
	* Helper variable for dolly positioning.
	*/
	private var dollyDestination:Int;
	
	public var brickSprite:FlxSprite;
	public var lightGlow:FlxSprite;
	
	public var test:FlxSprite;
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		
		FlxG.worldBounds.set( 0, 0, 640, 480); 
		FlxG.camera.setScrollBoundsRect(0, 0, 640, 480, true);
		
		
		this.brickSprite = new FlxSprite(250, 150);
		this.brickSprite.loadGraphic("assets/images/ZiegelUnregV1.png", false, 128, 128, true);
		this.add(this.brickSprite);
		//this.brickSprite.color = 0xFF0000;
		
		
		
		this.lightGlow = new FlxSprite(300, 200);
		this.lightGlow.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		this.add(this.lightGlow);
		
		this.test = new FlxSprite(100, 100);
		this.test.pixels = FlxAssets.getBitmapData("assets/images/greenbox.png");
		this.add(this.test);
		
		
		
		this.brickSprite = alphaMask(brickSprite, test.pixels, lightGlow.pixels);
		

		
		super.create();
	}
	
	
	
	/**
	 * Takes two source images (typically from Embedded bitmaps) and puts the resulting image into the output FlxSprite.
	 * Note: It assumes the source and mask are the same size. Different sizes may result in undesired results.
	 * It works by copying the source image (your picture) into the output sprite. Then it removes all areas of it that do not
	 * have an alpha color value in the mask image. So if you draw a big black circle in your mask with a transparent edge, you'll
	 * get a circular image to appear.
	 * May lead to unexecpted results if `source` does not have an alpha channel.
	 * 
	 * @param	output		The FlxSprite you wish the resulting image to be placed in (will adjust width/height of image)
	 * @param	source		The source image. Typically the one with the image / picture / texture in it.
	 * @param	mask		The mask to apply. Remember the non-alpha zero areas are the parts that will display.
	 * @return 	The FlxSprite for chaining
	 */
	public static function alphaMask(output:FlxSprite, source:Dynamic, mask:Dynamic):FlxSprite
	{
		var data:BitmapData = null;
		if (Std.is(source, String))
		{
			data = FlxAssets.getBitmapData(source);
		}
		else if (Std.is(source, Class))
		{
			data = Type.createInstance(source, []).bitmapData;
		}
		else if (Std.is(source, BitmapData))
		{
			trace("source is bitmap data");
			data = cast source;
			data = data.clone();
		}
		else
		{
			return null;
		}
		var maskData:BitmapData = null;
		if (Std.is(mask, String))
		{
			maskData = FlxAssets.getBitmapData(mask);
		}
		else if (Std.is(mask, Class))
		{
			trace("mask data is a class");
			maskData = Type.createInstance(mask, []).bitmapData;
		}
		else if (Std.is(mask, BitmapData))
		{
			maskData = mask;
		}
		else
		{
			return null;
		}
		
		//data.copyChannel(maskData, new Rectangle(0, 0, data.width, data.height), new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		output.pixels.copyPixels(data, new Rectangle(0, 0, 64, 64), new Point(10, 10), maskData, null, true);
		//output.pixels = data;
		return output;
	}
	
	
	
	/**
	 * Takes the image data from two FlxSprites and puts the resulting image into the output FlxSprite.
	 * Note: It assumes the source and mask are the same size. Different sizes may result in undesired results.
	 * It works by copying the source image (your picture) into the output sprite. Then it removes all areas of it that do not
	 * have an alpha color value in the mask image. So if you draw a big black circle in your mask with a transparent edge, you'll
	 * get a circular image appear.
	 * May lead to unexecpted results if `sprite`'s graphic does not have an alpha channel.
	 * 
	 * @param	sprite		The source FlxSprite. Typically the one with the image / picture / texture in it.
	 * @param	mask		The FlxSprite containing the mask to apply. Remember the non-alpha zero areas are the parts that will display.
	 * @param	output		The FlxSprite you wish the resulting image to be placed in (will adjust width/height of image)
	 * @return 	The output FlxSprite for chaining
	 */
	
	 /*
	
	 
	 public static function alphaMaskFlxSprite(sprite:FlxSprite, mask:FlxSprite, output:FlxSprite):FlxSprite
	{
		sprite.drawFrame();
		var data:BitmapData = sprite.pixels.clone();
		data.copyChannel(mask.pixels, new Rectangle(0, 0, sprite.width, sprite.height), new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		output.pixels = data;	
		return output;
	}
	*/
	
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed):Void
	{
		super.update(elapsed);
	}	
	


	
}