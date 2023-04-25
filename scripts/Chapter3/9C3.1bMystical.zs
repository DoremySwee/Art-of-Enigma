//blocks&ingots
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import scripts.Lib;
for i in 0 to 5{
    var b=<mysticalagriculture:storage>.definition.makeStack(i);
    var i=<mysticalagriculture:crafting>.definition.makeStack(i+33);
    recipes.remove(b);
    recipes.remove(i);
    var l=[i,i,i,i,i,i,i,i,i];
    Lib.Shaped9x9(b,[l,l,l,l,l,l,l,l,l]);
}