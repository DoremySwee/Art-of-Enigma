import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.item.IItemStack;
//import mods.enderio.AlloySmelter;

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//Smelter-Steel Ban
val a as IItemStack []= [<thermalfoundation:material>,<minecraft:iron_ingot>];
val b as IItemStack []= [<thermalfoundation:material:768>,<thermalfoundation:material:769>,<thermalfoundation:material:802>];
for i in a{ for j in b{
        mods.thermalexpansion.InductionSmelter.removeRecipe(i,j);
}}
mods.immersiveengineering.BlastFurnace.removeFuel(<minecraft:coal>);
mods.immersiveengineering.BlastFurnace.removeFuel(<thermalfoundation:storage_resource>);
recipes.remove(<thermalfoundation:storage_resource>);
recipes.remove(<minecraft:gunpowder>);

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//Tech tree
// SAG -> Coal Dust -> Liquid Coal in_ Tic
// torch = 1mb molten charged glowstone
// Coal Dust -> EnderSmelter -> Energitic
// molten_glass=xx+xx+xx+xx  or  post liquidXP: Blazing Pyrotheum (temp) glass->molten
// molten_glass*37 + liquidCoal*73 + moltenClay*29 + moltenDirt*43 + moltenEnergitic*7 -> moltenSoularium*189

// Soularium+Energitic+etc.=>LiquidXP

val sg=<thermalfoundation:material:288>;
val fumo=<ore:ingotEnchantedMetal>;
val elct=<ore:ingotElectrum>;
recipes.addShaped(<enderio:block_simple_sag_mill>, [
        [fumo,sg,fumo],
        [<minecraft:flint>,<botania:pool>,<minecraft:flint>],
        [elct,<minecraft:piston>,elct]]);
val cD=<thermalfoundation:material:768>;
mods.immersiveengineering.Crusher.removeRecipe(cD);
mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:coal>);
mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:coal_ore>);

mods.tconstruct.Melting.addRecipe(<liquid:coal> * 144,cD);
mods.tconstruct.Melting.addRecipe(<liquid:glowstone> * 1,<minecraft:torch>);
//recipes.addShapeless(<minecraft:glowstone_dust>,[<enderio:block_holier_fog>*9]);

val TESmel=<thermalexpansion:machine:3>;
val d1=<enderio:item_material:38>;
recipes.addShaped(<enderio:block_simple_alloy_smelter>,[
        [d1,TESmel,d1],
        [TESmel,<botania:pool>,TESmel],
        [fumo,<botania:rfgenerator>,elct]]);

mods.tconstruct.Alloy.addRecipe(<liquid:glass>*21,[<liquid:copper>*1,<liquid:gold>*2,
        <liquid:silver>*3,<liquid:platinum>*4,<liquid:xu_enchanted_metal>*5,<liquid:clay>*6]);
mods.tconstruct.Melting.removeRecipe(<liquid:glass>);

mods.tconstruct.Alloy.addRecipe(<liquid:soularium>*189,[<liquid:glass>*37,<liquid:coal>*73,
        <liquid:clay>*29,<liquid:dirt>*43,<liquid:energetic_alloy>*7]);

recipes.remove(<enderio:block_xp_vacuum>);
recipes.remove(<enderio:block_experience_obelisk>);
recipes.remove(<enderio:item_xp_transfer>);
mods.tconstruct.Casting.addTableRecipe(<enderio:item_xp_transfer>,
<tconstruct:tough_tool_rod>.withTag({Material: "soularium"}),
<liquid:xu_enchanted_metal>,1024,true,1200);
recipes.addShaped(<enderio:block_experience_obelisk>,[
        [null,<enderio:item_xp_transfer>,null],
        [fumo,<enderio:block_tank>,fumo],
        [<enderio:block_alloy:7>,<botania:pool>,<enderio:block_alloy:7>]]);