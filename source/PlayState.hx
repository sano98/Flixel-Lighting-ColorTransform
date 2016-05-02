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
import flixel.graphics.frames.FlxFrame;
import flixel.graphics.FlxGraphic;



/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var objectGroup:FlxTypedGroup<FlxObject>;
	
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
		
		this.objectGroup = new FlxTypedGroup<FlxObject>();
		this.add(this.objectGroup);
		
		//////////////////////////////////////////////////////
		////	FlxTilemap Lighting
		///////////////////////////////////////////////////////
		
		
		this.brickTilemap = new FlxTilemap();
		this.brickTilemap.loadMapFrom2DArray([[0, 1, 0], [2, 3, 2]], "assets/images/Ziegel_numbered.png", 64, 64, 0, 0, 0);
		this.objectGroup.add(brickTilemap);
		
		this.brickTilemap2 = new FlxTilemap();
		this.brickTilemap2.loadMapFrom2DArray([[0, 1, 0], [2, 3, 2]], "assets/images/Ziegel_numbered.png", 64, 64, 0, 0, 0);
		this.brickTilemap2.y = 250;
		this.objectGroup.add(brickTilemap2);
		
		this.brickTilemapText = new FlxText(20, 200, 0, "FlxTilemap");
		this.objectGroup.add(brickTilemapText);
		
		
		this.brickTilemap.color = 0x00FFFF;
		
		this.lightGlow = new FlxSprite(150, 100);
		this.lightGlow.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		//this.add(this.lightGlow);
		
		
		this.lightingTileHandler(this.lightGlow, this.brickTilemap);
		
		
		
		
		//////////////////////////////////////////////////////
		////	Static FlxSprite Lighting
		///////////////////////////////////////////////////////
		
		
		
		this.couchSprite = new FlxSprite(250, 30);
		//this.couchSprite.pixels = FlxAssets.getBitmapData("assets/images/gameObject_armchairB.png");
		this.couchSprite.loadGraphic("assets/images/gameObject_armchairB.png", false, 59, 45, true);
		this.objectGroup.add(this.couchSprite);
		
		
		
		var testColorTransform:ColorTransform = new ColorTransform(0.2, 0.2, 0.2, 1.0, 0, 0, 0, 0);
		this.couchSprite.framePixels.colorTransform(this.couchSprite.getHitbox().copyToFlash(), testColorTransform);
		this.couchSprite.pixels = this.bitmapColorTransform(couchSprite.pixels, testColorTransform);
		
		
		//For some reason, when coloring the sprite with one of those two methods, the lighting will not work
		//Reason is propably that the color transformation is applied after the lighting, during the draw call.
		//this.brickSprite.setColorTransform(0.2, 0.2, 0.2, 1.0, 0, 0, 0, 0);
		//this.brickSprite.color = 0xFF333333;

		
		
		this.brickSpriteText = new FlxText(270, 200, 0, "FlxSprite");
		this.objectGroup.add(brickSpriteText);
		
		this.couchSprite2 = new FlxSprite(250, 250);
		this.couchSprite2.loadGraphic("assets/images/gameObject_armchairB.png", false, 59, 45, true);
		this.objectGroup.add(this.couchSprite2);
		
		this.lightGlow2 = new FlxSprite(240, 24);
		this.lightGlow2.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		//this.add(this.lightGlow2);
		

		
		this.lightingSpriteHandler(this.lightGlow2, this.couchSprite);
		this.lightGlow2.x += 30;
		
		this.lightingSpriteHandler(this.lightGlow2, this.couchSprite);
		
		
		
		
		//////////////////////////////////////////////////////
		////	Animated FlxSprite Lighting
		///////////////////////////////////////////////////////
		
		
		
		this.lightGlow3 = new FlxSprite(450, 24);
		this.lightGlow3.loadGraphic("assets/images/glow-light.png", false, 64, 64, true);
		this.objectGroup.add(this.lightGlow3);
		
		
		this.girlSprite = new FlxSprite(450, 20);
		girlSprite.loadGraphic("assets/images/arron jes cycle.png", true, 48, 61, true);
		//this.girl.pixels = this.bitmapColorTransform(girl.pixels, testColorTransform);
		girlSprite.animation.add("running", [0, 1, 2, 3, 4, 5, 6, 7], 16);
		girlSprite.animation.callback = function(n:String, frameNumber:Int, frameIndex:Int):Void
		{
			trace("FrameNumber: " + frameIndex);
			//var frame:FlxFrame = new FlxFrame(FlxGraphic.fromBitmapData(new BitmapData(48, 61)), 0, true, false);
			//var frame:FlxFrame = new FlxFrame(FlxGraphic.fromBitmapData(girlSprite.frames.getByIndex(frameIndex).parent.bitmap));
			var frame:FlxFrame = girlSprite.frames.getByIndex(frameIndex);
			frame.frame = new FlxRect(0, 0, 48, 61);
			frame.sourceSize.set(frame.frame.width, frame.frame.height);
			frame.offset.set(0, 0);
			girlSprite.frame = frame;
			
			
			
			
			//trace("frame changed");
			//this.lightingAnimationHandler(this.lightGlow3, this.girlSprite, this.girlSprite.framePixels);
			//girlSprite.framePixels = new BitmapData(48, 61, true, (Math.floor(Math.random() * (4294967295 - 0 + 1)) + 0));
			
			//girlSprite.frames.parent.bitmap.fillRect(girlSprite.frames.parent.bitmap.rect, 0xFFFF0000);
			//girlSprite.frames.frames[frameNumber].parent.bitmap = new BitmapData(48, 61);
			
			
			//neither of those work:
			//girlSprite.frame.parent.bitmap = new BitmapData(48, 61);
			//girlSprite.updateFramePixels = new BitmapData(48, 61);
			//girlSprite.frames.getByIndex(animation.curAnim.curFrame).paint(
			//girlSprite.set = new BitmapData(348, 61);
		}
		
		
		this.objectGroup.add(girlSprite);
		this.girlSprite.animation.play("running");
		//this.girlSprite.color = 0x00FFFF;
		this.girlSprite.drawFrame(true);
		
		this.girlSpriteText = new FlxText(470, 200, 0, "Animated FlxSprite");
		this.objectGroup.add(girlSpriteText);
		
		//this.girl.framePixels.colorTransform(this.girl.getHitbox().copyToFlash(), testColorTransform);
		//trace (this.girl.framePixels.colorTransform);
		
		//this.girl.framePixels = this.bitmapColorTransform(girl.framePixels, testColorTransform);

		
		this.girlSprite2 = new FlxSprite(450, 250);
		girlSprite2.loadGraphic("assets/images/arron jes cycle.png", true, 48, 61, true);
		girlSprite2.animation.add("running", [0, 1, 2, 3, 4, 5, 6, 7], 16);
		this.objectGroup.add(girlSprite2);
		girlSprite2.animation.play("running");
		
		//this.lightingAnimationHandler(this.lightGlow3, this.girlSprite, this.girlSprite.framePixels);
		
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
	public function lightingTileHandler(Light:FlxSprite, Target:FlxTilemap):Void
	{
		var intersectionRect:Rectangle = (Light.getHitbox().intersection(Target.getHitbox())).copyToFlash();		
		
		if ((intersectionRect != null) && (intersectionRect.width > 0) && (intersectionRect.height > 0))
		{
			var overlaySprite:FlxSprite = _puzzleItTogether(get2DArrayOfTilemapOverlap(Target, 64, 64, intersectionRect), Target, 64, 64, intersectionRect);
			this.add(overlaySprite);
			
			
			var testColorTransform:ColorTransform = new ColorTransform(0.2, 0.2, 0.2, 1.0, 0, 0, 0, 0);
			overlaySprite.framePixels.colorTransform(overlaySprite.getHitbox().copyToFlash(), testColorTransform);
			overlaySprite.pixels = this.bitmapColorTransform(overlaySprite.pixels, testColorTransform);
			
			
			var sourceRectLocal = new Rectangle(intersectionRect.x - Target.x - (overlaySprite.x - Target.x), intersectionRect.y - Target.y - (overlaySprite.y - Target.y), intersectionRect.width, intersectionRect.height);
			var targetPointLocal = new Point(intersectionRect.x - Target.x - (overlaySprite.x - Target.x), intersectionRect.y - Target.y - (overlaySprite.y - Target.y));
			
			var maskRectBitmap = new BitmapData(Std.int(intersectionRect.width), Std.int(intersectionRect.height));
			maskRectBitmap.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), new Point());
			
			lightMask(overlaySprite, Target.graphic.assetsKey, maskRectBitmap, sourceRectLocal, targetPointLocal);
			
		}
		
	}
	
	
	
	
	
	
	
	
	/**
	 * Checks if light is hitting a FlxObject; and if yes, handles the lighting of this object
	 * @param	Light	A FlxSprite of a light cone. Should be white/colored on the inside and transparent on the outside.
	 * @param	Target	The FlxSprite that should be illuminated. Illumination works by negating a prior colorTransformation of the target.
	 * 
	 * The original, uncolored pixels of the target object are copied at the position where the light cone hits it.
	 */
	public function lightingSpriteHandler(Light:FlxSprite, Target:FlxSprite):Void
	{
		//Creates the intersection Rectangle between the Light and the Target (if existent) and transforms it from FlxRect to flash.geom.Rectangle
		var intersectionRect:Rectangle = (Light.getHitbox().intersection(Target.getHitbox())).copyToFlash();		
		
		if ((intersectionRect != null) && (intersectionRect.width > 0) && (intersectionRect.height > 0))
		{
			//trace("intersect not null");
			
			var sourceRectLocal = new Rectangle(intersectionRect.x - Target.x, intersectionRect.y - Target.y, intersectionRect.width, intersectionRect.height);
			var targetPointLocal = new Point(intersectionRect.x - Target.x, intersectionRect.y - Target.y);
			
			var maskRectBitmap = new BitmapData(Std.int(intersectionRect.width), Std.int(intersectionRect.height));
			maskRectBitmap.copyPixels(Light.pixels, new Rectangle(intersectionRect.x - Light.x, intersectionRect.y - Light.y, intersectionRect.width, intersectionRect.height), new Point());
			
			lightMask(Target, Target.graphic.assetsKey, maskRectBitmap, sourceRectLocal, targetPointLocal);
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
	 * A modified version of FlxSpriteUtil.alphaMask.
	 * Used to negate a colorTransformation on a Sprite or Tilemap when hit by a light source.
	 * 
	 * @param	target		The FlxSprite you wish the resulting image to be placed in (the darkened sprite you want the light cone to shine on)
	 * @param	source		The source image. The uncolored, unmodified graphic of the output, before it was tinted.
	 * @param	mask		The mask to apply. This is the bitmap of that part of the light cone graphic that intersects with the target.
	 * @param	rectangle	The area on the source bitmap from which the unmodified pixels are to be copied from. In local coordinates, as it operates on the bitmap.
	 * @param	targetPoint	The target point where that rectangle is to be located on the target bitmap.
	 * @return 	The FlxSprite for chaining
	 */
	public static function lightMask(target:FlxSprite, source:Dynamic, mask:Dynamic, rectangle:Rectangle, targetPoint:Point):Void
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
		
		//trace("rectangle top left: " + rectangle.x + "/" + rectangle.y);
		//trace("rectangle bottom right: " + rectangle.bottomRight.x + "/" + rectangle.bottomRight.y);
		//trace("target point: " + targetPoint.x + "/" + targetPoint.y);
		
		target.pixels.copyPixels(data, rectangle, targetPoint, maskData, null, true);
		//return target.framePixels;
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
			recAddTiles(Tilemap, _tileArray[_tileArray.length - 1], rowPointer, cornerPoint, TileWidth, colPointer, OverlapRect);
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
		var i:Int = (RowPointer * (Tilemap.widthInTiles) + ColPointer);
		
		if (i >= Tilemap._data.length)
		{
			return;
		}
		
		RowArray.push(Tilemap._data[i]);
		Cornerpoint.x += TileWidth;
		ColPointer ++;
		if (Cornerpoint.x <= OverlapRect.right)
		{
			recAddTiles(Tilemap, RowArray, RowPointer, Cornerpoint, TileWidth, ColPointer, OverlapRect);
		}
		
	}
	
	/**
	 * This function takes an 2-dimensional Int array and a corresponding Tilemap and creates a FlxSprite that contains the same graphical content.
	 * It basically creates a "movable wall" in front of the tilemap with exact the same graphic as the tilemap behind.
	 * On this FlxSprite, the lighting effects take place.
	 * @param	MapData		2-dimensional Int-Array containing the indices of the tiles whose bitmapdata is to be copied onto the sprite. Count starts with zero.
	 * @param	TileGraphic	The graphic of the Tilemap. Needs to be something that can be converted into BitmapData. It is the original Tilesheet-graphic, without manipulations like tint, rotate, etc.
	 * @param	TileWidth	Width of the tiles used on the TileMap.
	 * @param	TileHeight	Width of the tiles used on the TileMap.
	 * @param	OverlapRect	The rectangle of the overlap between Tilemap and Lightsource.
	 * @return	A FlxSprite with the correct graphic of the Tilemap behind it. Must be a multiple of the tilesizes, no matter how large or small the OverlapRect is.
	 */
	private function _puzzleItTogether(MapData:Array<Array<Int>>, TileMap:FlxTilemap, TileWidth:Int = 0, TileHeight:Int = 0, OverlapRect:Rectangle):FlxSprite
	{
		//TileGraphic:FlxTilemapGraphicAsset
		//get upper left tile that overlaps with the Light source Rectangle
		var rowNumber:Int = Std.int(OverlapRect.y / TileHeight);//first row numer is zero
		var colNumber:Int = Std.int(OverlapRect.x / TileWidth);
		
		var leSprite:FlxSprite = new FlxSprite(colNumber * TileWidth, rowNumber * TileHeight);
		leSprite.makeGraphic(MapData[0].length * TileWidth, MapData.length * TileHeight);
		
		var originalWidthInTiles:Int = Std.int(TileMap.frames.parent.width / TileWidth);
		
		// i is the y-value, indicating the row; j is the x-value, indicating the column
		for (i in 0...MapData.length)
		{
			for (j in 0...MapData[i].length)
			{
				trace("MapData[i][j]: " + MapData[i][j]);
				var localRowNumber:Int = Std.int((MapData[i][j]) / originalWidthInTiles);
				var localColNumer:Int = (MapData[i][j]) - (originalWidthInTiles * localRowNumber);
				trace("localRowNumber: " + localRowNumber);
				trace("localColNumer: " + localColNumer);
				leSprite.pixels.copyPixels(TileMap.frames.parent.bitmap, new Rectangle(localColNumer * TileWidth, localRowNumber * TileHeight, TileWidth, TileHeight), new Point (j * TileWidth, i * TileHeight), null, null, true);
			}
		}
		
		//leSprite.pixels.copyPixels(TileMap.frames.parent.bitmap, new Rectangle(0, 0, 128, 128), new Point (0, 0), null, null, true);
		
		return leSprite;
	}
	
	
	
	
	
	
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
		
		
		/*
		this.lightGlow.x = FlxG.mouse.screenX - Std.int(this.lightGlow.width / 2);
		this.lightGlow.y = FlxG.mouse.screenY - Std.int(this.lightGlow.height / 2);
		
		
		
		for (i in 0...this.objectGroup.members.length)
		{
			var _target:FlxObject = this.objectGroup.members[i];
			
			if (_target.overlaps(this.lightGlow))
			{
				
				if (_target == this.couchSprite)
				{
					trace("okay, it's the couch.");
				}
				
				if (Type.getClass(_target) == FlxTilemap)
				{
					this.lightingTileHandler(this.lightGlow, cast _target);
					
				}
				else if (Type.getClass(_target) == FlxSprite)
				{
					//trace ("it'S a sprite! aw my god!");
					this.lightingSpriteHandler(this.lightGlow, cast _target);
				}
			}
		}
		*/
		
	}
	


}