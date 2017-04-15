package;

/**
 * ...
 * @author sano98
 */
class Food extends Stuff
{
	public static var juicyness:Int = 0;
	public var sweetness:Int;
	
	public function new(Sweetness:Int) 
	{
		this.sweetness = Sweetness;
		super();
	}
	
}