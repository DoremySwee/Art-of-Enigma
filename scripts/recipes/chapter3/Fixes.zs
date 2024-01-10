#reloadable
#priority -1
#loader crafttweaker reloadableevents
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
recipes.removeByRecipeName("embers:ember_emmiter");
recipes.removeByRecipeName("tconstruct:common/flint");
for i in 0 to 16{
    <entity:botania:doppleganger>.removeDrop(<botania:rune>.definition.makeStack(i));
}
var t1 = <mysticalagriculture:crafting:33>;
recipes.addShaped(<mysticalagriculture:ingot_storage:1>,[[t1,t1,t1],[t1,t1,t1],[t1,t1,t1]]);
var t2 = <appliedenergistics2:material:25>;
recipes.addShaped(<appliedenergistics2:material:53>*64,[[t2,t2,t2],[t2,<minecraft:crafting_table>,t2],[t2,t2,t2]]);
recipes.addShaped(<thermalexpansion:augment:128>,Mp.read("_PR;PGP;RP_;",{
    "P":<thermalfoundation:material:354>,"R":<minecraft:redstone>,
    "G":<tconstruct:tough_tool_rod>.withTag({Material: "electrum"})
}));

<tconstruct:bolt_core:0>.addTooltip(game.localize("jei.description.bolt_core"));
T.ae.inscribe(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:rabbit"}}),[
    <minecraft:egg>,<minecraft:rabbit_foot>,<minecraft:rabbit_foot>
]);
T.exu.enchant(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:zombie_villager"}}),[
    <minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:zombie"}}),
   <chisel:emerald:10> 
],9000,200);
T.tic.casting(<botania:waterbowl>.withTag({Fluid: {FluidName: "water", Amount: 1000}}),
    <minecraft:bowl>,<liquid:water>*1000,1
);
recipes.addShaped(<calculator:material:6>,Mp.read("AAA;AAA;AAA;",{"A":<calculator:firediamond>}));
recipes.addShaped(<thermalexpansion:tank>.withTag({RSControl: 0 as byte, Level: 0 as byte}),Mp.read(
    "ABA;BCB;ABA;",{
        "A":<thermalfoundation:material:163>,
        "B":<thermalfoundation:glass_alloy:4>,
        "C":<appliedenergistics2:material:54>
    }
));
T.tc.shaped(<botania:slimebottle>,Mp.read("ABA;ACA;_A_;",{
    "A":<tconstruct:nuggets:3>,
    "B":<mysticalagriculture:chunk:11>,
    "C":<botania:managlass>
}),4);
T.tic.casting(<tconstruct:slime_sapling:1>,<tconstruct:slime_sapling>,<liquid:purpleslime>*1296,1000);

mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:sand>,<astralsorcery:itemcraftingcomponent:2>);
for i in 0 to 5{
    recipes.remove(<mysticalagriculture:crafting>.definition.makeStack(i));
}
recipes.remove(<thermalfoundation:material:101>);