package;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.graphics.frames.FlxFilterFrames;
import flash.filters.BitmapFilter;
import flash.filters.GlowFilter;
import flixel.ui.FlxButton;

/**
 * ...
 * @author sano98
 */
class TestButton extends FlxButton
{
	public var buttonIcon:FlxSprite;
	
	public var glowFilter:GlowFilter;
	public var filterFrame:FlxFilterFrames;
	
	static inline var SIZE_INCREASE:Int = 5;
	
	
	public function new(X:Float=0, Y:Float=0, ?Label:String, ?OnClick:Void->Void)
	{
		super(X, Y, Label, OnClick);
		
		
		
		//this.loadGraphic("assets/images/recipeButtonFrame.png", true, 60, 60, false); 
		this.loadGraphic("assets/images/recipeButtonFrameWhite.png", true, 60, 60, false);
		this.scrollFactor.y = 0;
		
		
		this.buttonIcon = new FlxSprite(X + 6, Y + 6);
		//this.buttonIcon.loadGraphic((Reflect.field(myRecipe.result_type, "graphic_crafting")), false, 48, 48);
		this.buttonIcon.loadGraphic("assets/images/objectIcon_Screw_48x48_white.png", false, 48, 48);
		this.buttonIcon.scrollFactor.y = 0;
		
		this.glowFilter = new GlowFilter(0xFFFFFFFF, 0.8, 5, 5, 3);
		//this.filterFrame = this.createFilterFrames (this.buttonIcon, glowFilter);
		this.filterFrame = this.createFilterFrames(this);
		
	}
	
	
	public function addGlow():Void
	{
		this.filterFrame.addFilter(glowFilter);
		this.updateFilter(this, this.filterFrame);
	}
	
	
	public function removeGlow():Void
	{
		this.filterFrame.removeFilter(glowFilter);
		this.updateFilter(this, this.filterFrame);
	}
	
	
	public override function onOutHandler():Void 
	{
		this.removeGlow();
		super.onOutHandler();
		//this.buttonIcon.color = 0xFFabecf4;
		
	}
	
	public override function onOverHandler():Void 
	{
		this.addGlow();
		super.onOverHandler();
		
		//this.buttonIcon.color = 0xFFFFFFFF;
		
	}
	
	
	private function createFilterFrames(sprite:FlxSprite):FlxFilterFrames
	{ 
		var filterFrames = FlxFilterFrames.fromFrames(sprite.frames, SIZE_INCREASE, SIZE_INCREASE, []); 
		return filterFrames; 
	} 
	
	
	function updateFilter(spr:FlxSprite, sprFilter:FlxFilterFrames)
	{
		sprFilter.applyToSprite(spr, false, true);
	}
	
	
	
}