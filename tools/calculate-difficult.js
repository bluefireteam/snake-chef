const requireDir = require('require-dir');

const recipes = requireDir('../snake_chef/assets/recipes');
const stages = requireDir('../snake_chef/assets/stages');

const calculateRecipe = recipe => {
  const ingredientsCounted = recipe.ingredients.reduce((summary, current) => {
    const count = recipe.ingredients.filter(r => r == current).length;
    return { ...summary, [current]: count };
  }, {});

  return Object.values(ingredientsCounted).reduce((score, current) => {
    return score + recipe.ingredients.length / current;
  }, 0);
}

console.log('===================');
console.log('= Recipes summary =');
console.log('===================');

const recipesDificult = Object
  .entries(recipes)
  .map(([name, recipe]) => ({ name, difficult: calculateRecipe(recipe), ingredients: recipe.ingredients }))
  .reduce((obj, curr) => ({ ...obj, [curr.name]: { difficult: curr.difficult, ingredients: curr.ingredients } }), {});

Object.entries(recipesDificult)
  .map(([name, { difficult, ingredients }]) => ({ name, difficult, ingredients }))
  .sort((a, b) => a.difficult - b.difficult)
  .forEach(({ name, difficult, ingredients }) => {
    console.log(`${difficult}`);
  });
