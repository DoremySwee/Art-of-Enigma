#priority -1
import mods.immersiveengineering.AlloySmelter;
import mods.immersiveengineering.MetalPress;
import mods.botaniatweaks.Agglomeration;
//hammer:   acceptable
//coke:     acceptable
//blast:    acceptable

mods.immersiveengineering.BlastFurnace.removeFuel(<minecraft:coal:1>);

//Alloy kiln
//AlloySmelter.addRecipe(IItemStack output, IIngredient first, IIngredient second, int time);
//AlloySmelter.removeRecipe(IItemStack output);
AlloySmelter.removeRecipe(<immersiveengineering:metal:6>);
AlloySmelter.removeRecipe(<immersiveengineering:metal:7>);
AlloySmelter.removeRecipe(<thermalfoundation:material:162>);
AlloySmelter.addRecipe(<thermalfoundation:material:162>*3,<ore:dustNickel>,<ore:dustIron>*2,1800);

//Metal Press
val heavyB=<immersiveengineering:metal_decoration0:5>;
val st=<ore:ingotSteel>;
recipes.remove(heavyB);
recipes.addShaped(heavyB,[
    [st,<immersiveengineering:material:9>,st],
    [<minecraft:piston>,<thermalfoundation:material:162>,<minecraft:piston>],
    [st,<immersiveengineering:material:9>,st]]);
MetalPress.removeRecipeByMold(<immersiveengineering:mold>);
MetalPress.removeRecipeByMold(<immersiveengineering:mold:1>);
MetalPress.removeRecipeByMold(<immersiveengineering:mold:7>);
recipes.removeShaped(<immersiveengineering:wooden_device0:2>);

//gears: ban most gears till Chapter3. Allow gold, steel, iron and Mithril
val gg=<thermalfoundation:material:25>;
val sg=<thermalfoundation:material:288>;
val ig=<thermalfoundation:material:24>;
val ii=<minecraft:iron_ingot>;
MetalPress.addRecipe(ig, ii, <immersiveengineering:mold:1>, 2000,4);
MetalPress.addRecipe(gg, <minecraft:gold_ingot>, <immersiveengineering:mold:1>, 700,4);
MetalPress.addRecipe(<immersiveengineering:mold:1>,sg,<thermalfoundation:material:352>,8000,4);
Agglomeration.addRecipe(gg*3,[<thermalfoundation:material:23>],40000,0xA04040,0xFFFF00,
    <extrautils2:simpledecorative>,<minecraft:gold_block>,<thermalfoundation:storage_alloy:2>,
    <minecraft:emerald_ore>,<minecraft:gold_ore>,<minecraft:iron_ore>);
recipes.remove(<enderio:item_material:10>);
recipes.remove(<enderio:item_material:9>);
recipes.remove(<appliedenergistics2:material:40>);
recipes.remove(<tconstruct:wooden_hopper>);
recipes.addShaped(<tconstruct:wooden_hopper>,[
    [<minecraft:planks>,<minecraft:iron_ingot>,<minecraft:planks>],
    [<minecraft:planks>,<minecraft:chest>,<minecraft:planks>],
    [null,<minecraft:planks>,null],
]);
recipes.addShaped(<appliedenergistics2:material:40>,[
    [null,<minecraft:stick>,null],
    [<minecraft:stick>,<enderio:item_material:20>,<minecraft:stick>],
    [null,<minecraft:stick>,null]]);
Agglomeration.addRecipe(sg,[gg],70000,0xDDDD00,0x888888,
    <tconstruct:wooden_hopper>,<immersiveengineering:sheetmetal:8>,<thermalfoundation:storage_alloy:2>,
    <minecraft:planks>,<minecraft:coal_ore>,<thermalfoundation:storage_alloy:2>);

mods.tconstruct.Casting.removeTableRecipe(<tconstruct:cast_custom:4>);
mods.tconstruct.Casting.addTableRecipe(<tconstruct:cast_custom:4>,<thermalfoundation:material:264>,<liquid:gold>,1919,true,8000);

recipes.remove(<minecraft:hopper>);
recipes.addShaped(<minecraft:hopper>,[
    [ii,ig,ii],
    [ii,<minecraft:chest>,ii],
    [null,ii,null]]);

recipes.removeShapeless(<minecraft:flint_and_steel>);
recipes.addShapeless(<minecraft:flint_and_steel>, [<minecraft:flint>,sg]);
recipes.removeShaped(<immersiveengineering:blueprint>.withTag({blueprint: "molds"}));

//Bonsai
val rst=<minecraft:redstone_torch>;
val st2=<ore:stone>;
recipes.addShaped(<minecraft:comparator>,[
    [null,rst,null],
    [rst,<appliedenergistics2:material:0>,rst],
    [st2,st2,st2]]);
recipes.removeShaped(<botanicbonsai:bonsai_pot_manager>);
recipes.addShaped(<botanicbonsai:bonsai_pot_manager>,[
    [<botania:spreader>,<storagedrawers:controller>,<botania:spreader>],
    [<ore:ingotEnchantedMetal>,<minecraft:hopper>,<ore:ingotEnchantedMetal>],
    [<botania:pool>,<botania:distributor>,<botania:pool>]]);