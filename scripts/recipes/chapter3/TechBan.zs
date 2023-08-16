#priority 500
import crafttweaker.mods.IMod;
import crafttweaker.mods.ILoadedMods;
import mods.bloodmagic.BloodAltar as BA;
import mods.bloodmagic.TartaricForge as TF;

mods.botania.Orechid.removeOre(<ore:oreCinnabar>);
mods.botania.Orechid.removeOre(<ore:oreUranium>);
mods.botania.Orechid.removeOre(<ore:oreAmber>);
mods.jei.JEI.hideCategory("thermalexpansion.factorizer_combine");
mods.jei.JEI.hideCategory("thermalexpansion.factorizer_split");
val MA=loadedMods["mysticalagriculture"] as IMod;
for i in MA.items{
    if(i.definition.id.contains("reprocessor"))recipes.remove(i);
    if(i.definition.id.contains("storage"))recipes.remove(i);
    if(i.definition.id.contains("tinkering"))recipes.remove(i);
	if(i.definition.id.contains("crafting"))recipes.remove(i);
	if(i.definition.id.contains("seeds"))recipes.remove(i);	
    if(i.definition.id.contains("apple"))recipes.remove(i);	
    if(i.definition.id.contains("coal"))recipes.remove(i);	
    if(i.definition.id.contains("can"))recipes.remove(i);	
    if(i.definition.id.contains("infusion"))recipes.remove(i);	
    if(i.definition.id.contains("gear"))recipes.remove(i);	
    if(i.definition.id.contains("chunk"))recipes.remove(i);	
}
for i in 0 to 9{
    recipes.remove(<extrautils2:passivegenerator>.definition.makeStack(i));
}
val CALC=loadedMods["calculator"] as IMod;
for i in CALC.items{
    recipes.remove(i);
}
if(true){
    var rs=<minecraft:redstone>;
    var gs=<minecraft:glowstone_dust>;
    var gp=<minecraft:gunpowder>;
    var lt=<minecraft:leather>;
    var st=<minecraft:string>;
    var gi=<minecraft:gold_ingot>;
    var wb=<minecraft:water_bucket>;
    var lb=<minecraft:lava_bucket>;
    var sg=<minecraft:sugar>;
    var tp=<bloodmagic:teleposer>;
    var gl=<minecraft:glass>;
    recipes.remove(tp);
    TF.removeRecipe([tp,<minecraft:glowstone>,<minecraft:redstone_block>,gi]);
    TF.removeRecipe([<minecraft:ghast_tear>,<minecraft:feather>,<minecraft:feather>]);
    TF.removeRecipe([<minecraft:iron_pickaxe>,<minecraft:iron_axe>,<minecraft:iron_shovel>,gp]);
    TF.removeRecipe([gs,rs,<minecraft:gold_nugget>,gp]);
    TF.removeRecipe([<minecraft:glowstone>,<minecraft:torch>,rs,rs]);
    TF.removeRecipe([lb,rs,<minecraft:cobblestone>,<minecraft:coal_block>]);
    TF.removeRecipe([<minecraft:cookie>,sg,<minecraft:cookie>,<minecraft:stone>]);
    TF.removeRecipe([<minecraft:slime>,<minecraft:slime>,lt,st]);
    TF.removeRecipe([<minecraft:chest>,lt,st,st]);
    TF.removeRecipe([<minecraft:ender_eye>,<minecraft:ender_pearl>,gi,gi]);
    TF.removeRecipe([tp,wb,lb,<minecraft:blaze_rod>]);
    TF.removeRecipe([<minecraft:bucket>,st,st,gp]);
    TF.removeRecipe([<minecraft:soul_sand>,<minecraft:soul_sand>,<minecraft:stone>,<minecraft:obsidian>]);
    TF.removeRecipe([<bloodmagic:sigil_divination>,gl,gl,gs]);
    TF.removeRecipe([sg,wb,wb]);
    TF.removeRecipe([<minecraft:flint>,<minecraft:flint>,<bloodmagic:cutting_fluid>]);
    TF.removeRecipe([<minecraft:ice>,<minecraft:snowball>,<minecraft:snowball>,rs]);
    TF.removeRecipe([<minecraft:sapling>,<minecraft:sapling>,<minecraft:reeds>,sg]);
    TF.removeRecipe([st,gi,<minecraft:iron_block>,gi]);
    //TF.removeRecipe([<bloodmagic:sigil_water>,<bloodmagic:sigil_air>,<bloodmagic:sigil_lava>,<minecraft:obsidian>]);
    TF.removeRecipe([<minecraft:iron_block>,<minecraft:gold_block>,<minecraft:obsidian>,<minecraft:cobblestone>]);
    TF.removeRecipe([tp,<minecraft:diamond>,<minecraft:ender_pearl>,<minecraft:obsidian>]);

    var gem=<bloodmagic:soul_gem>;
    TF.removeRecipe([rs,<minecraft:dye:15>,gp,<minecraft:coal>]);
    TF.removeRecipe([<minecraft:diamond_chestplate>,gem,<minecraft:iron_block>,<minecraft:obsidian>]);

    TF.removeRecipe([rs,gi,gl,<minecraft:dye:4>]);
    TF.removeRecipe([gem,<minecraft:diamond>,<minecraft:redstone_block>,<minecraft:lapis_block>]);
    TF.removeRecipe([<bloodmagic:soul_gem:1>,<minecraft:diamond>,<minecraft:gold_block>,<bloodmagic:slate:2>]);
    TF.removeRecipe([<bloodmagic:soul_gem:2>,<bloodmagic:slate:3>,<bloodmagic:blood_shard>,<bloodmagic:item_demon_crystal>]);
    TF.removeRecipe([<bloodmagic:soul_gem:3>,<minecraft:nether_star>]);

    TF.removeRecipe([<minecraft:bow>,<bloodmagic:soul_gem:1>,st,st]);
    TF.removeRecipe([gem,<minecraft:iron_pickaxe>]);
    TF.removeRecipe([gem,<minecraft:iron_sword>]);
    TF.removeRecipe([gem,<minecraft:iron_shovel>]);
    TF.removeRecipe([gem,<minecraft:iron_axe>]);
}
//Altar Clean Up
if(true){
    BA.removeRecipe(<minecraft:stone>);
    //for i in 0 to 5{BA.removeRecipe(<bloodmagic:slate>.definition.makeStack(i));}
    BA.removeRecipe(<bloodmagic:slate>);
    for i in 0 to 11{recipes.remove(<bloodmagic:blood_rune>.definition.makeStack(i));}
    BA.removeRecipe(<minecraft:diamond>);
    BA.removeRecipe(<minecraft:redstone_block>);
    BA.removeRecipe(<minecraft:gold_block>);
    BA.removeRecipe(<bloodmagic:blood_shard>);
    BA.removeRecipe(<minecraft:nether_star>);

    BA.removeRecipe(<minecraft:magma_cream>);
    BA.removeRecipe(<minecraft:ghast_tear>);
    BA.removeRecipe(<minecraft:obsidian>);
    BA.removeRecipe(<minecraft:lapis_block>);
    BA.removeRecipe(<minecraft:coal_block>);

    BA.removeRecipe(<minecraft:bucket>);
    BA.removeRecipe(<minecraft:ender_pearl>);
    BA.removeRecipe(<minecraft:iron_sword>);
}
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumtweaks:crafter>);
recipes.remove(<minecraft:nether_brick>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:soul_sand>, <minecraft:netherrack>);