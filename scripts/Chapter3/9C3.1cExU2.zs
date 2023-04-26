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

var Cap=<enderio:item_basic_capacitor:2>;
recipes.remove(Cap);
Casting.addTableRecipe(Cap,<appliedenergistics2:material:5>,<liquid:electrical_steel>,576,true,300);
recipes.addShaped(<thermalfoundation:upgrade>,Lib.Mapper({
    "P":<tconstruct:large_plate>.withTag({Material: "silver"}),"C":Cap,
    "G":MithG,"R":<thermalfoundation:material:2048>
},"PCP;RGR;PCP;"));

//Enchanter
Casting.addTableRecipe(<extrautils2:machine>.withTag({Type: "extrautils2:enchanter"}),
    <thermalexpansion:machine:3>.withTag({Level: 1 as byte}),
    <liquid:xpjuice>,200,true,6000);

//EIO
var Frame=<enderio:item_material:1>;
recipes.addShaped(Frame,Lib.Mapper({
    "U":<thermalfoundation:upgrade>,
    "X":<tconstruct:tough_binding>.withTag({Material: "xu_enchanted_metal"}),
    "P":<tconstruct:pick_head>.withTag({Material: "dark_steel"}),
    "S":<tconstruct:sign_head>.withTag({Material: "xu_magical_wood"}),
    "R":<tconstruct:tough_tool_rod>.withTag({Material: "dark_steel"})
},"PSR;UXU;RSP;"));
recipes.addShaped(<enderio:block_slice_and_splice>,Lib.Mapper({
    "f":Frame,"B":<immersiveengineering:storage:8>,
    "F":<tconstruct:toolforge>.withTag({textureBlock: {id: "enderio:block_alloy", Count: 1 as byte, Damage: 7 as short}}),
    "s":<botania:manasteelshears>,"a":<botania:manasteelaxe>
},"BaB;BfB;FsF;"));
recipes.addShapeless(<enderio:item_material>*4,[<enderio:item_material:1>]);
Casting.addTableRecipe(<enderio:item_material:73>,MithG,<liquid:dark_steel>,576,true,600);