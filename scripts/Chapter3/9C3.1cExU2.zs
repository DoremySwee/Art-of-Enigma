import mods.botaniatweaks.Agglomeration as Agg;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.embers.Stamper;
import mods.embers.Melter;
import mods.embers.Mixer;
import scripts.Lib;
recipes.remove(<minecraft:nether_brick>);

//ThermalFound QoL
var MithI=<thermalfoundation:material:136>;
var MithGl=<thermalfoundation:glass:8>;
var MithG=<thermalfoundation:material:264>;
var EmberC=<embers:crystal_ember>;
var map as IIngredient[string]={
    "I":MithI,"G":MithGl,"@":MithG,"C":EmberC
};
var tempmap1 as IIngredient[string]={
    "A":<mysticalagriculture:crafting>,"B":<thermalexpansion:machine>,"C":<minecraft:iron_ingot>,"D":<mysticalagriculture:inferium_furnace>};
recipes.addShaped(<mysticalagriculture:inferium_furnace>,Lib.Mapper(tempmap1,"AAA;ABA;AAA;"));
recipes.addShaped(<thermalexpansion:machine>,Lib.Mapper(tempmap1,"CCC;CDC;CCC;"));
recipes.addShaped(<thermalexpansion:machine:1>,Lib.Mapper(Lib.Merge(map,{
    "T":<enderio:block_simple_sag_mill>}),"IGI;CTC;I@I;"));
recipes.addShaped(<thermalexpansion:machine:2>,Lib.Mapper(Lib.Merge(map,{
    "T":<enderio:block_simple_sag_mill>,"A":<thermalfoundation:tool.axe_platinum>}),"IGI;ATA;I@I;"));
recipes.addShaped(<thermalexpansion:machine:5>,Lib.Mapper(Lib.Merge(map,{
    "T":<enderio:block_dark_steel_anvil>}),"IGI;CTC;I@I;"));
recipes.addShaped(<thermalexpansion:device:4>,Lib.Mapper(Lib.Merge(map,{
    "T":<thermalfoundation:tool.fishing_rod_platinum>}),"IGI;CTC;I@I;"));