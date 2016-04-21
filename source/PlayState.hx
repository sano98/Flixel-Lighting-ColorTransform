package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxRect;
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
import flixel.tile.FlxTilemap;
import flixel.FlxCamera;
import flixel.tile.FlxTilemapBuffer;
import flixel.system.FlxAssets.FlxTilemapGraphicAsset;



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
	
	public var brickTilemap:FlxTilemap;
	public var brickTilemap2:FlxTilemap;
	public var brickTilemapText:FlxText;
	public var lightGlow:FlxSprite;
	
	
	public var couchSprite:FlxSprite;
	public var couchSprite2:FlxSprite;
	public var brickSpriteText:FlxText;
	public var lightGlow2:FlxSprite;
	
	
	public var girlSprite:FlxSprite;
	public var girlSpriteText:FlxText;
	public var girlSprite2:FlxSprite;
	public var lightGlow3:FlxSprite;
	
	public var test:FlxSprite;
	
	
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		
		
		FlxG.worldBounds.set( 0, 0, 640, 480); 
		FlxG.camera.setScrollBoundsRect(0, 0, 640, 480, true);
		
		//////////////////////////////////////////////////////
		////	FlxTilemap Lighting
		///////////////////////////////////////////////////////
		
		
		this.brickTilemap = new FlxTilemap();
		this.brickTilemap.loadMapFrom2DArray([[0, 1, 0], [2, 3, 2]], "assets/images/ZiegelUnregV1.png", 64, 64, 0, 0, 0);
		this.add(brickTilemap);
		
		this.brickTilemap2 = new FlxTilemap();
		this.brickTilemap2.loadMapFrom2DArray([[0, 1, 0], [2, 3,2 ]], "assets/images/ZiegelUnregV1.png", 64, 64, 0, 0, 0);
		this.brickTilemap2.y = 250;
		this.add(brickTilemap2);
		
		this.brickTilemapText = new FlxText(20, 200, 0, "FlxTilemap");
		this.add(brickTilemapText);
		
		
		this.brickTilemap.color = 0x00FFFF;
		
		this.lightGlow = new FlxSprite(24, 24);
		this.lightGlow.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		//this.lightGlow.loadGraphic("assets/images/greenbox.png", false, 128, 128, true);
		//this.add(this.lightGlow);
		
		
		this.lightingTileHandler(this.lightGlow, this.brickTilemap, "assets/images/ZiegelUnregV1.png");
		
		
		
		
		//////////////////////////////////////////////////////
		////	Static FlxSprite Lighting
		///////////////////////////////////////////////////////
		
		
		
		this.couchSprite = new FlxSprite(250, 30);
		this.couchSprite.pixels = FlxAssets.getBitmapData("assets/images/gameObject_armchairB.png");
		//this.brickSprite.loadGraphic("assets/images/ZiegelUnregV1.png", false, 128, 128, true);
		this.add(this.couchSprite);
		
		
		
		var testColorTransform:ColorTransform = new ColorTransform(0.2, 0.2, 0.2, 1.0, 0, 0, 0, 0);
		this.couchSprite.framePixels.colorTransform(this.couchSprite.getHitbox().copyToFlash(), testColorTransform);
		this.couchSprite.pixels = this.bitmapColorTransform(couchSprite.pixels, testColorTransform);
		
		
		//For some reason, when coloring the sprite with one of those two methods, the lighting will not work
		//Reason is propably that the color transformation is applied after the lighting, during the draw call.
		//this.brickSprite.setColorTransform(0.2, 0.2, 0.2, 1.0, 0, 0, 0, 0);
		//this.brickSprite.color = 0xFF333333;

		
		
		this.brickSpriteText = new FlxText(270, 200, 0, "FlxSprite");
		this.add(brickSpriteText);
		
		this.couchSprite2 = new FlxSprite(250, 250);
		this.couchSprite2.loadGraphic("assets/images/gameObject_armchairB.png", false, 59, 45, true);
		this.add(this.couchSprite2);
		
		this.lightGlow2 = new FlxSprite(240, 24);
		this.lightGlow2.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		//this.add(this.lightGlow2);
		

		
		this.lightingHandler(this.lightGlow2, this.couchSprite, "assets/images/gameObject_armchairB.png");
		
		
		
		//////////////////////////////////////////////////////
		////	Animated FlxSprite Lighting
		///////////////////////////////////////////////////////
		
		
		
		
		this.lightGlow3 = new FlxSprite(450, 24);
		this.lightGlow3.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		//this.lightGlow.loadGraphic("assets/images/greenbox.png", false, 128, 128, true);
		this.add(this.lightGlow3);
		
		//this.test = new FlxSprite(100, 100);
		//this.test.loadGraphic("assets/images/ZiegelUnregV1.png", false, 128, 128, true);
		//this.test.pixels = FlxAssets.getBitmapData("assets/images/ZiegelUnregV1.png");
		//this.add(this.test);
		
		this.girlSprite = new FlxSprite(450, 20);
		
		
		girlSprite.loadGraphic("assets/images/arron jes cycle.png", true, 48, 61, false);
		//this.girl.pixels = this.bitmapColorTransform(girl.pixels, testColorTransform);
		girlSprite.animation.add("running", [0, 1, 2, 3, 4, 5, 6, 7], 2);
		this.add(girlSprite);
		girlSprite.animation.play("running");
		this.girlSprite.color = 0x00FFFF;
		this.girlSprite.drawFrame(true);
		
		this.girlSpriteText = new FlxText(470, 200, 0, "Animated FlxSprite");
		this.add(girlSpriteText);
		
		//this.girl.framePixels.colorTransform(this.girl.getHitbox().copyToFlash(), testColorTransform);
		//trace (this.girl.framePixels.colorTransform);
		
		//this.girl.framePixels = this.bitmapColorTransform(girl.framePixels, testColorTransform);

		
		this.girlSprite2 = new FlxSprite(450, 250);
		girlSprite2.loadGraphic("assets/images/arron jes cycle.png", true, 48, 61, false);
		girlSprite2.animation.add("running", [0, 1, 2, 3, 4, 5, 6, 7], 16);
		this.add(girlSprite2);
		girlSprite2.animation.play("running");
		
		this.lightingAnimationHandler(this.lightGlow3, this.girlSprite, this.girlSprite.framePixels);
		
		super.create();
		
		
	}
	
	
	
	
	
	
	
	/**
	 * Checks if light is hitting a FlxTilemap; and if yes, handles the lighting of it.
	 * For now, it basically creates a new FlxSprite with the graphic of the intersection and placed that in front of the Tilemap.
	 * @param	Light	A FlxSprite of a light cone. Should be white/colored on the inside and transparent on the outside.
	 * @param	Target	The FlxTilemap that should be illuminated. Illumination works by negating a prior colorTransformation of the target.
	 * 
	 * The original, uncolored pixels of the target object are copied at the position where the light cone hits it. 
	 * Here, those pixels are copied into the bitmapdata of a newly created FlxSprite.
	 */
	public function lightingTileHandler(Light:FlxSprite, Target:FlxTilemap, TargetSource:String):Void
	{
		var intersectionRect:Rectangle = (Light.getHitbox().intersection(Target.getHitbox())).copyToFlash();		
		
		if ((intersectionRect != null) && (intersectionRect.width > 0) && (intersectionRect.height > 0))
		{
			get2DArrayOfTilemapOverlap(Target, 64, 64, intersectionRect);
			var overlaySprite:FlxSprite = _puzzleItTogether(get2DArrayOfTilemapOverlap(Target, 64, 64, intersectionRect), Target.frames.parent.bitmap, 64, 64);
			this.add(overlaySprite);
			
			var testColorTransform:ColorTransform = new ColorTransform(0.2, 0.2, 0.2, 1.0, 0, 0, 0, 0);
			overlaySprite.framePixels.colorTransform(overlaySprite.getHitbox().copyToFlash(), testColorTransform);
			overlaySprite.pixels = this.bitmapColorTransform(overlaySprite.pixels, testColorTransform);
			
			
			var sourceRectLocal = new Rectangle(intersectionRect.x - Target.x, intersectionRect.y - Target.y, intersectionRect.width, intersectionRect.height);
			var targetPointLocal = new Point(intersectionRect.x - Target.x, intersectionRect.y - Target.y);
			
			var maskRectBitmap = new BitmapData(Std.int(intersectionRect.width), Std.int(intersectionRect.height));
			maskRectBitmap.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), new Point());
			
			overlaySprite = lightMask(overlaySprite, TargetSource, maskRectBitmap, sourceRectLocal, targetPointLocal);
			
		}
		
		


			
			
			
			//I have manually inserted the link to the asset file here.
			//I could operate on a childclass of FlxSprite which has this link as a static class attribute
			//But ir would be more elegant if I could somehow access the original, unmodified bitmapdata, which must be stored somewhere - just haven't found it yet.
			
		
		
		/*
		
		//Creates the intersection Rectangle between the Light and the Target (if existent) and transforms it from FlxRect to flash.geom.Rectangle
		var intersectionRect:Rectangle = (Light.getHitbox().intersection(Target.getHitbox())).copyToFlash();		
		
		if ((intersectionRect != null) && (intersectionRect.width > 0) && (intersectionRect.height > 0))
		{
			trace("intersect not null");
			
			//The area on the source bitmap from which the unmodified pixels are to be copied from. In local coordinates, as it operates on the bitmap.
			var sourceRectLocal = new Rectangle(intersectionRect.x - Target.x, intersectionRect.y - Target.y, intersectionRect.width, intersectionRect.height);
			
			//The target point where that rectangle is to be located on the target bitmap.
			var targetPointLocal = new Point(intersectionRect.x - Target.x, intersectionRect.y - Target.y);
			
			//The mask to apply. This is the bitmap of that part of the light cone graphic that intersects with the target.
			var maskRectBitmap = new BitmapData(Std.int(intersectionRect.width), Std.int(intersectionRect.height));
			
			
			trace("sourceRectLocal top left: " + sourceRectLocal.x + "/" + sourceRectLocal.y);
			trace("sourceRectLocal bottom right: " + sourceRectLocal.bottomRight.x + "/" + sourceRectLocal.bottomRight.y);
			trace("target point: " + targetPointLocal.x + "/" + targetPointLocal.y);
			
			//this.brickSprite.pixels.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), targetPointLocal);
			
			maskRectBitmap.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), new Point(0, 0));
			
			//The new sprite with the graphic of the lightened tielmap, placed axactly over the tilemap at the corresponding position
			var overlaySprite:FlxSprite = new FlxSprite(intersectionRect.x, intersectionRect.y);
			overlaySprite.makeGraphic(Std.int(intersectionRect.width), Std.int(intersectionRect.height),0x00000000);
			//overlaySprite.pixels = maskRectBitmap;
			
		
			
			
			
			//Actually, here I am cheating: I am loading the original assets of the tilemap. But this only works because they are already in the right order;
			//Something which normally cannot be expected for a Tilemap.
			//To make this work, I would need access to the Bitmapdata of the tilemap!
			//overlaySprite = lightMask(overlaySprite, "assets/images/ZiegelUnregV1.png", maskRectBitmap, sourceRectLocal, new Point(0, 0));
			//overlaySprite = lightMask(overlaySprite, buffer.pixels, maskRectBitmap, sourceRectLocal, new Point(0, 0));
			//this.add(overlaySprite);
			//overlaySprite.y = 400;
		}
		*/
	}
	
	
	
	
	
	
	
	
	/**
	 * Checks if light is hitting a FlxObject; and if yes, handles the lighting of this object
	 * @param	Light	A FlxSprite of a light cone. Should be white/colored on the inside and transparent on the outside.
	 * @param	Target	The FlxSprite that should be illuminated. Illumination works by negating a prior colorTransformation of the target.
	 * 
	 * The original, uncolored pixels of the target object are copied at the position where the light cone hits it.
	 */
	public function lightingHandler(Light:FlxSprite, Target:FlxSprite, TargetSource:String):Void
	{
		//Creates the intersection Rectangle between the Light and the Target (if existent) and transforms it from FlxRect to flash.geom.Rectangle
		var intersectionRect:Rectangle = (Light.getHitbox().intersection(Target.getHitbox())).copyToFlash();		
		
		if ((intersectionRect != null) && (intersectionRect.width > 0) && (intersectionRect.height > 0))
		{
			trace("intersect not null");
			
			var sourceRectLocal = new Rectangle(intersectionRect.x - Target.x, intersectionRect.y - Target.y, intersectionRect.width, intersectionRect.height);
			var targetPointLocal = new Point(intersectionRect.x - Target.x, intersectionRect.y - Target.y);
			
			var maskRectBitmap = new BitmapData(Std.int(intersectionRect.width), Std.int(intersectionRect.height));
			maskRectBitmap.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), new Point());
			
			//I have manually inserted the link to the asset file here.
			//I could operate on a childclass of FlxSprite which has this link as a static class attribute
			//But ir would be more elegant if I could somehow access the original, unmodified bitmapdata, which must be stored somewhere - just haven't found it yet.
			Target = lightMask(Target, TargetSource, maskRectBitmap, sourceRectLocal, targetPointLocal);
		}
	}
	
	
	
	/**
	 * Checks if light is hitting a FlxObject; and if yes, handles the lighting of this object
	 * @param	Light	A FlxSprite of a light cone. Should be white/colored on the inside and transparent on the outside.
	 * @param	Target	The animated FlxSprite that should be illuminated. Illumination works by negating a prior colorTransformation of the target.
	 * 
	 * The original, uncolored pixels of the target object are copied at the position where the light cone hits it.
	 */
	public function lightingAnimationHandler(Light:FlxSprite, Target:FlxSprite, TargetBitmap:BitmapData):Void
	{
		//Creates the intersection Rectangle between the Light and the Target (if existent) and transforms it from FlxRect to flash.geom.Rectangle
		var intersectionRect:Rectangle = (Light.getHitbox().intersection(Target.getHitbox())).copyToFlash();		
		
		trace ("Target width: " + Target.getHitbox().width);
		
		
		if ((intersectionRect != null) && (intersectionRect.width > 0) && (intersectionRect.height > 0))
		{
			trace("intersect not null");
			
			var sourceRectLocal = new Rectangle(intersectionRect.x - Target.x, intersectionRect.y - Target.y, intersectionRect.width, intersectionRect.height);
			var targetPointLocal = new Point(intersectionRect.x - Target.x, intersectionRect.y - Target.y);
			
			var maskRectBitmap = new BitmapData(Std.int(intersectionRect.width), Std.int(intersectionRect.height));
			maskRectBitmap.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), new Point());
			
			Target.framePixels = animationLightMask(Target.framePixels, TargetBitmap, maskRectBitmap, sourceRectLocal, targetPointLocal);
		}
	}
	
	
	/**
	 * A modified version of FlxSpriteUtil.alphaMask.
	 * Used to negate a colorTransformation on a Sprite or Tilemap when hit by a light source.
	 * 
	 * @param	output		The FlxSprite you wish the resulting image to be placed in (the darkened sprite you want the light cone to shine on)
	 * @param	source		The source image. The uncolored, unmodified graphic of the output, before it was tinted.
	 * @param	mask		The mask to apply. This is the bitmap of that part of the light cone graphic that intersects with the target.
	 * @param	rectangle	The area on the source bitmap from which the unmodified pixels are to be copied from. In local coordinates, as it operates on the bitmap.
	 * @param	targetPoint	The target point where that rectangle is to be located on the target bitmap.
	 * @return 	The FlxSprite for chaining
	 */
	public static function animationLightMask(target:BitmapData, source:Dynamic, mask:Dynamic, rectangle:Rectangle, targetPoint:Point):BitmapData
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
		
		trace("rectangle top left: " + rectangle.x + "/" + rectangle.y);
		trace("rectangle bottom right: " + rectangle.bottomRight.x + "/" + rectangle.bottomRight.y);
		trace("target point: " + targetPoint.x + "/" + targetPoint.y);
		
		target.copyPixels(data, rectangle, targetPoint, maskData, null, true);
		return target;
	}
	
	
	
	
	
	
	/*
	 Provides a fast routine to perform pixel manipulation between images with no stretching, rotation, or color effects. 
	 This method copies a rectangular area of a source image to a rectangular area of the same size at the destination point of the destination BitmapData object.

	If you include the alphaBitmap and alphaPoint parameters, you can use a secondary image as an alpha source for the source image. 
	If the source image has alpha data, both sets of alpha data are used to composite pixels from the source image to the destination image. 
	The alphaPoint parameter is the point in the alpha image that corresponds to the upper-left corner of the source rectangle. 
	Any pixels outside the intersection of the source image and alpha image are not copied to the destination image.
	The mergeAlpha property controls whether or not the alpha channel is used when a transparent image is copied onto another transparent image. 
	To copy pixels with the alpha channel data, set the mergeAlpha property to true. By default, the mergeAlpha property is false.

	Parameters
	
	
	sourceBitmapData:BitmapData — The input bitmap image from which to copy pixels. The source image can be a different BitmapData instance, or it can refer to the current BitmapData instance.
 
	sourceRect:Rectangle — A rectangle that defines the area of the source image to use as input.
 
	destPoint:Point — The destination point that represents the upper-left corner of the rectangular area where the new pixels are placed.
 
	alphaBitmapData:BitmapData (default = null) — A secondary, alpha BitmapData object source.
 
	alphaPoint:Point (default = null) — The point in the alpha BitmapData object source that corresponds to the upper-left corner of the sourceRect parameter.
 
	mergeAlpha:Boolean (default = false) — To use the alpha channel, set the value to true. To copy pixels with no alpha channel, set the value to false.
	*/

	

	
	
	/**
	 * Function that performs color tinting through a direct bitmap operation instead of letting the draw()-function taking care of it.
	 * Prevents Sprite bitmap manipulation to be overwritten by draw.
	 * Basically, we do lots of fancy lighting stuff, and draw() would overwrite it all in the end.
	 * @param	CurrentBitmapData		The bitmapdata of the current object which should be colored through the colorTransformation.
	 * @param	CurrentColorTransform	A ColorTransform-Object to be applied to the current object.
	 * @return
	 */
	public function bitmapColorTransform(CurrentBitmapData:BitmapData, CurrentColorTransform:ColorTransform):BitmapData
	{
		var data:BitmapData = CurrentBitmapData;
		data.colorTransform(new Rectangle(0, 0, data.width, data.height), CurrentColorTransform);
		return data;
	}
	

	/**
	 * Helper funtion for getting a flash.geom.Rectangle, representing the intersection between light and target hit by the light.
	 * @param	Light
	 * @param	Target
	 * @return
	 */
	public function overlapCheck(Light:FlxObject, Target:FlxObject):Rectangle
	{
		var intersectionRect:FlxRect = Light.getHitbox().intersection(Target.getHitbox());
		return intersectionRect.copyToFlash();
	}
	
	
	
	
	
	/**
	 * A modified version of FlxSpriteUtil.alphaMask.
	 * Used to negate a colorTransformation on a Sprite or Tilemap when hit by a light source.
	 * 
	 * @param	output		The FlxSprite you wish the resulting image to be placed in (the darkened sprite you want the light cone to shine on)
	 * @param	source		The source image. The uncolored, unmodified graphic of the output, before it was tinted.
	 * @param	mask		The mask to apply. This is the bitmap of that part of the light cone graphic that intersects with the target.
	 * @param	rectangle	The area on the source bitmap from which the unmodified pixels are to be copied from. In local coordinates, as it operates on the bitmap.
	 * @param	targetPoint	The target point where that rectangle is to be located on the target bitmap.
	 * @return 	The FlxSprite for chaining
	 */
	public static function lightMask(target:FlxSprite, source:Dynamic, mask:Dynamic, rectangle:Rectangle, targetPoint:Point):FlxSprite
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
		
		trace("rectangle top left: " + rectangle.x + "/" + rectangle.y);
		trace("rectangle bottom right: " + rectangle.bottomRight.x + "/" + rectangle.bottomRight.y);
		trace("target point: " + targetPoint.x + "/" + targetPoint.y);
		
		target.pixels.copyPixels(data, rectangle, targetPoint, maskData, null, true);
		return target;
	}
	
	
	
	
	public function get2DArrayOfTilemapOverlap(Tilemap:FlxTilemap, TileWidth:Int, TileHeight:Int, OverlapRect: Rectangle):Array<Array<Int>>
	{
		//get upper left tile that overlaps with the Light source Rectangle
		var rowNumber:Int = Std.int(OverlapRect.y / TileHeight);//first row numer is zero
		var colNumber:Int = Std.int(OverlapRect.x / TileWidth);
		
		//As we will go through the tiles and add them to the _tileArray, we'll need a pointer to the current position in tiles
		var rowPointer:Int = rowNumber;
		var colPointer:Int = colNumber;
		
		var _tileArray:Array<Array<Int>> = [];
		
		var cornerPoint:Point = new Point(OverlapRect.topLeft.x, OverlapRect.topLeft.y);
		
		
		
		while (cornerPoint.y <= OverlapRect.bottom)
		{
			_tileArray.push([]);
			recAddTiles(Tilemap, _tileArray[rowPointer], rowPointer, cornerPoint, TileWidth, colPointer, OverlapRect);
			colPointer = colNumber;
			cornerPoint.y += TileHeight;
			cornerPoint.x = OverlapRect.left;
			rowPointer ++;
		}
		

		trace(_tileArray);
		return _tileArray;
		
		
		
		
	}
	
	private function recAddTiles(Tilemap:FlxTilemap, RowArray:Array<Int>, RowPointer:Int, Cornerpoint:Point, TileWidth:Int, ColPointer:Int, OverlapRect:Rectangle):Void
	{
		//trace("recAddTiles called");
		var i:Int = (RowPointer * (Tilemap.widthInTiles - 1) + ColPointer);
		RowArray.push(Tilemap._tileObjects[i].index);
		Cornerpoint.x += TileWidth;
		ColPointer ++;
		if (Cornerpoint.x <= OverlapRect.right)
		{
			recAddTiles(Tilemap, RowArray, RowPointer, Cornerpoint, TileWidth, ColPointer, OverlapRect);
		}
		
	}
	
	private function _puzzleItTogether(MapData:Array<Array<Int>>, TileGraphic:FlxTilemapGraphicAsset, TileWidth:Int = 0, TileHeight:Int = 0):FlxSprite
	{
		
		
		var leSprite:FlxSprite = new FlxSprite(0, 0);
		//leSprite.width = MapData.length * TileWidth;
		//leSprite.height = MapData[0].length * TileHeight;
		leSprite.makeGraphic(MapData.length * TileWidth, MapData[0].length * TileHeight);
		
		for (i in 0...MapData[0].length)
		{
			for (j in 0...MapData.length)
			{
				var _bitmap = new BitmapData(TileWidth, TileHeight);
				leSprite.pixels.copyPixels(TileGraphic, new Rectangle(j * TileWidth, i * TileHeight, TileWidth, TileHeight), new Point (j * TileWidth, i * TileHeight), null, null, true);
			}
		}
		return leSprite;
	}
	
	
	
	/*
	public function getBitmapDataOfTilemap(Tilemap:FlxTilemap):BitmapData
	{
		// don't try to render a tilemap that isn't loaded yet
			if (Tilemap.graphic == null)
			{
				trace("getBitmapDataOfTilemap-Error: Tilemap.graphic == null");
				return null;
			}
			
			var camera:FlxCamera;
			var buffer:FlxTilemapBuffer = null;
			var l:Int = Tilemap.cameras.length;
			
			for (i in 0...l)
			{
				camera = Tilemap.cameras[i];
				
				if (!camera.visible || !camera.exists)
				{
					continue;
				}
				
				if (Tilemap._buffers[i] == null)
				{
					trace("new buffer created");
					Tilemap._buffers[i] = createBuffer(Tilemap, camera);
				}
				
				buffer = Tilemap._buffers[i];
				trace("buffer " + i + " created.");
			}
			
			if (FlxG.renderBlit)
			{
				getScreenPosition(_point, camera).subtractPoint(offset).add(buffer.x, buffer.y);
				buffer.dirty = buffer.dirty || _point.x > 0 || (_point.y > 0) || (_point.x + buffer.width < camera.width) || (_point.y + buffer.height < camera.height);
				
				if (buffer.dirty)
				{
					drawTilemap(buffer, camera);
				}
				
				getScreenPosition(_point, camera).subtractPoint(offset).add(buffer.x, buffer.y).copyToFlash(_flashPoint);
				buffer.draw(camera, _flashPoint, scale.x, scale.y);
			}
			
			
			
			
			
			
			
			
			return buffer.pixels;
	}
	*/
	
	
	
	
	
	private inline function createBuffer(Tilemap:FlxTilemap, camera:FlxCamera):FlxTilemapBuffer
	{
		var buffer = new FlxTilemapBuffer(64, 64, Tilemap.widthInTiles, Tilemap.widthInTiles, camera, Tilemap.scale.x, Tilemap.scale.y);
		buffer.pixelPerfectRender = Tilemap.pixelPerfectRender;
		return buffer;
	}
	
	
	
	
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
		//this.lightingAnimationHandler(this.lightGlow, this.girlSprite, this.girlSprite.framePixels);
		//this.girlSprite.drawFrame(true);
	}	
	


	
}