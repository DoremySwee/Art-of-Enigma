//blocks&ingots
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import scripts.Lib;

import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.embers.Melter;
for i in 0 to 5{
    var bt=<mysticalagriculture:storage>.definition.makeStack(i);
    var b=<mysticalagriculture:ingot_storage>.definition.makeStack(i+1);
    var t=<mysticalagriculture:crafting>.definition.makeStack(i+33);
    recipes.remove(bt);
    recipes.remove(b);
    recipes.remove(t);
    var l as IIngredient[]=[t,t,t,t,t,t,t,t,t]as IIngredient[];
    Lib.Shaped9x9(b,[l,l,l,l,l,l,l,l,l]);
    mods.thermalexpansion.Factorizer.removeRecipeCombine(t*9);
    mods.thermalexpansion.Factorizer.removeRecipeSplit(b);
}

//Level0
var MoltE=<liquid:molten_essence>;
Casting.addTableRecipe(<mysticalagriculture:crafting:33>,
    <thermalfoundation:material:136>,<liquid:molten_essence>,144,true,600);
Melter.add(<liquid:molten_essence>*144,<mysticalagriculture:crafting>);
Melting.addRecipe(<liquid:molten_essence>*144,<mysticalagriculture:crafting>,500);
Casting.addTableRecipe(<mysticalagriculture:inferium_apple>,<minecraft:golden_apple>,MoltE,1440,true,600);
recipes.remove(<mysticalagriculture:inferium_apple>);
