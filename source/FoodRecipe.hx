package;

/**
 * ...
 * @author sano98
 */
class FoodRecipe
{

	public var ingredient:Class<Food>;
	
	public function new(Ingredient:Class<Food>) 
	{
		this.ingredient = Ingredient;
	}
	
	//trace (Ingredient);
	//trace(Reflect.field(Ingredient, "juicyness"));
}