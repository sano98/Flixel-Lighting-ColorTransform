package;

/**
 * ...
 * @author sano98
 */
class FruitRecipe extends FoodRecipe
{
	
	public var fruitIngredient:Class<Fruit>;

	public function new(Ingredient:Class<Fruit>) 
	{
		super(Ingredient);
		
		this.fruitIngredient = Ingredient;
		this.ingredient = Ingredient;
	}
	
}