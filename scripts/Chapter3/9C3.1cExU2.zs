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
var EmberC=<embers:shard_ember>;
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

var Cap=<enderio:item_basic_capacitor>;
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

//9x9
var dw=<botania:dreamwood>;
var rst=<botania:manaresource:12>;//red string
recipes.remove(<extrautils2:decorativesolidwood:1>);
mods.botania.PureDaisy.addRecipe(<extrautils2:decorativesolidwood:1>,dw,50);
recipes.addShaped(<avaritia:extreme_crafting_table>,Lib.Mapper({"A":dw},"AA;AA;"));
recipes.remove(<botania:manatablet>);
recipes.addShaped(<botania:manatablet>.withTag({}),Lib.Mapper(
    {"A":dw,"B":<botania:livingrock>},"BBB;BAB;BBB;"));
recipes.remove(rst);
mods.botania.RuneAltar.addRecipe(<botania_tweaks:dire_crafty_crate>,Lib.Mapper({
        "A":<botania:manaresource:12>,"C":<minecraft:concrete:14>,"D":<minecraft:red_glazed_terracotta>,
        "B":<tconstruct:toolforge>.withTag({textureBlock: {id: "minecraft:redstone_block", Count: 1 as byte, Damage: 0 as short}}),
        "0":<botania:opencrate:1>,"E":<avaritia:extreme_crafting_table>
    },"A0B0C0D0E0;")[0],2857142);
//TODO: red string