#loader crafttweaker reloadableevents
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

import mods.embers.Stamper;

var brick = <embers:brick_caminite>;
var gearMith = <thermalfoundation:material:264>;

furnace.remove(brick);
recipes.remove(<embers:dawnstone_anvil>);
recipes.remove(<embers:ember_bore>);
recipes.remove(<embers:archaic_light>);

T.tic.casting(<embers:blend_caminite>, <thermalfoundation:material:72>, <liquid:molten_essence>*144, 144);
T.tic.casting(brick, <embers:blend_caminite>, <liquid:glass>*144, 600);
T.tic.casting(<embers:crystal_ember>, <tconstruct:cast_custom:1>, <liquid:pyrotheum>*16, 288, false);

Agg.addRecipe(<minecraft:snowball>,[<appliedenergistics2:paint_ball:23>],300000,0x0000FF,0x8888FF,
    <thermalfoundation:glass:2>,<thermalfoundation:storage:8>,<minecraft:lapis_block>,
    <thermalfoundation:glass:8>,<thermalfoundation:storage:2>,<minecraft:lapis_ore>
);
Agg.addRecipe(gearMith,[<thermalfoundation:material:288>],500000,0x444466,0x8888FF,
    <minecraft:hopper>,<thermalfoundation:storage:8>,<minecraft:lapis_block>,
    <minecraft:hopper>,<thermalfoundation:storage:2>,<minecraft:lapis_ore>
);
T.embers.melter([<liquid:silver>*144,<liquid:mana>],<thermalfoundation:material:136>);
<thermalfoundation:material:136>.addTooltip(format.yellow(format.italic(game.localize("description.crt.tooltip.mithril.trymelting"))));

var table = <mysticalagriculture:tinkering_table>;
var map1 = {
    //Common
    "d": <ore:ingotDarkSteel>,
    "D": <enderio:block_alloy:6>,
    "b": brick,
    "B": <embers:block_caminite_brick>,
    "S": <embers:stairs_caminite_brick>,
    "s": <tconstruct:seared:8>,
    "G": gearMith,
    "F": <tconstruct:toolforge>.withTag({
            textureBlock: {id: "thermalfoundation:storage_alloy",
            Count: 1 as byte, Damage: 0 as short}}
        ),  //Steel
    "-": <immersiveengineering:storage_slab:8>,
    "~": <embers:block_caminite_brick_slab>,
    "&": <immersiveengineering:storage:8>,  //Steel Block
    "T": table,
    "R": <botania:rfgenerator>,
    
    //Use only once
    "1": <ore:stickTreatedWood>,
    "2": <minecraft:piston>,
    "3": <enderio:block_dark_steel_anvil>,
    "4": <tconstruct:seared_furnace_controller>,
    "5": <mysticalagriculture:ingot_storage:1>,
    "6": <extrautils2:drum:2>,
    "7": <enderio:block_simple_alloy_smelter>,
    "8": <tconstruct:seared:6>,
    "9": <thermalfoundation:glass:8>,
    "0": <tconstruct:faucet>,
    "!": M.flower("thermalily"),
    "@": <botania:spreader>,
    "#": M.flower("spectrolus"),
    "$": <immersiveengineering:connector:4>,
    "%": <immersiveengineering:connector:5>,
    "^": <botania:spreader:1>,
    "*": <embers:crystal_ember>
} as IIngredient[string];
recipes.addShaped(<embers:tinker_hammer>,Mp.read("dbd;d1d;_1_;",map1));
recipes.addShaped(<embers:stamper>,Mp.read("S2S;G3G;SFS;",map1));
recipes.addShaped(table, Mp.read("444;5F5;5_5",map1));
recipes.addShaped(<embers:block_furnace>,Mp.read("S6S;s7s;&8&;",map1));
recipes.addShaped(<embers:stamper_base>,Mp.read("-_-;s-s;BTB;",map1));
recipes.addShaped(<embers:mixer>,Mp.read("&9&;0G0;~R~;",map1));
recipes.remove(<embers:geo_separator>);
recipes.addShaped(<embers:geo_separator>,Mp.read("-_-;~~~;",map1));
recipes.remove(<embers:ember_activator>);
recipes.addShaped(<embers:ember_activator>,Mp.read("&@&;&#&;~!~;",map1));


Stamper.remove(<embers:aspectus_iron>);
Stamper.remove(<embers:aspectus_copper>);
Stamper.remove(<embers:aspectus_lead>);
Stamper.remove(<embers:aspectus_silver>);
Stamper.remove(<embers:aspectus_dawnstone>);

T.embers.mix(<liquid:alubrass>*64,[<liquid:aluminum>*48,<liquid:copper>*16]);
T.embers.mix(<liquid:constantan>*32,[<liquid:nickel>*16,<liquid:copper>*16]);
T.embers.mix(<liquid:invar>*48,[<liquid:nickel>*16,<liquid:iron>*32]);
T.embers.mix(<liquid:electrical_steel>*144,[<liquid:dark_steel>*144,<liquid:alchemical_redstone>*576]);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:160>, <appliedenergistics2:material:5>);

recipes.remove(<embers:shard_ember>);
recipes.remove(<embers:ember_receiver>);
recipes.addShaped(<embers:ember_receiver>,Mp.read("b$b;%#%;b$b",map1));
recipes.addShaped(<embers:ember_emitter>,Mp.read("b*b;*^*;b#b",map1));

//Mystical Agriculture
for i in 1 to 5{
    var bt=<mysticalagriculture:storage>.definition.makeStack(i);
    var b=<mysticalagriculture:ingot_storage>.definition.makeStack(i+1);
    var t=<mysticalagriculture:crafting>.definition.makeStack(i+33);
    recipes.remove(bt);
    recipes.remove(b);
    recipes.remove(t);
    var l as IIngredient[]=[t,t,t,t,t,t,t,t,t]as IIngredient[];
    T.ava.shaped(b,[l,l,l,l,l,l,l,l,l]);
    mods.thermalexpansion.Factorizer.removeRecipeCombine(t*9);
    mods.thermalexpansion.Factorizer.removeRecipeSplit(b);
}
T.tic.casting(<mysticalagriculture:crafting:33>,<thermalfoundation:material:136>,<liquid:molten_essence>*144,600);
T.embers.melt([<liquid:molten_essence>*144],<mysticalagriculture:crafting>);
//T.tic.melt(<liquid:molten_essence>*144,<mysticalagriculture:crafting>,500);
recipes.remove(<mysticalagriculture:inferium_apple>);

//TE Machines & invar upgrade
var map2 as IIngredient[string]={
    "A":<mysticalagriculture:crafting>,
    "B":<thermalexpansion:machine>,
    "C":<minecraft:iron_ingot>,
    "D":<mysticalagriculture:inferium_furnace>,
    "I":<thermalfoundation:material:136>,   //ingot
    "G":<thermalfoundation:glass:8>,        //glass
    "@":gearMith,
    "C":<embers:shard_ember>,
    "1":<enderio:block_simple_sag_mill>,
    "2":<thermalfoundation:tool.axe_platinum>,
    "3":<enderio:block_dark_steel_anvil>,
    "4":<thermalfoundation:tool.fishing_rod_platinum>,
    "5":<minecraft:furnace>
};
recipes.addShaped(<mysticalagriculture:inferium_furnace>,Mp.read("AAA;ABA;AAA;",map2));
recipes.addShaped(<thermalexpansion:machine>,Mp.read("CCC;CDC;CCC;",map2));
recipes.addShaped(<thermalexpansion:machine:1>,Mp.read("IGI;C1C;I@I;",map2));
recipes.addShaped(<thermalexpansion:machine:2>,Mp.read("IGI;212;I@I;",map2));
recipes.addShaped(<thermalexpansion:machine:5>,Mp.read("IGI;C3C;I@I;",map2));
recipes.addShaped(<thermalexpansion:device>,Mp.read("IGI;C5C;I@I",map2));
recipes.addShaped(<thermalexpansion:device:3>,Mp.read("IGI;5C5;I@I",map2));
recipes.addShaped(<thermalexpansion:device:4>,Mp.read("IGI;C4C;I@I",map2));

//EIO & ExU Enchanter
var capacitor = <enderio:item_basic_capacitor>;
recipes.remove(capacitor);
T.tic.casting(capacitor, <appliedenergistics2:material:5>, <liquid:electrical_steel>*576, 300);
recipes.addShaped(<thermalfoundation:upgrade>,Mp.read("PCP;RGR;PCP;",{
    "P":<tconstruct:large_plate>.withTag({Material: "silver"}),"C":capacitor,
    "G":gearMith,"R":<thermalfoundation:material:2048>
}));
T.tic.casting(<extrautils2:machine>.withTag({Type: "extrautils2:enchanter"}),
    <thermalexpansion:machine:3>.withTag({Level: 1 as byte}),
    <liquid:xpjuice>*2000, 6000);

var frame=<enderio:item_material:1>;
recipes.addShaped(frame,Mp.read("PSR;UXU;RSP;",{
    "U":<thermalfoundation:upgrade>,
    "X":<tconstruct:tough_binding>.withTag({Material: "xu_enchanted_metal"}),
    "P":<tconstruct:pick_head>.withTag({Material: "dark_steel"}),
    "S":<tconstruct:sign_head>.withTag({Material: "xu_magical_wood"}),
    "R":<tconstruct:tough_tool_rod>.withTag({Material: "dark_steel"})
}));
recipes.addShaped(<enderio:block_slice_and_splice>,Mp.read("BaB;BfB;FsF;",{
    "f":frame,"B":<immersiveengineering:storage:8>,
    "F":<tconstruct:toolforge>.withTag({textureBlock: {id: "enderio:block_alloy", Count: 1 as byte, Damage: 7 as short}}),
    "s":<botania:manasteelshears>,"a":<botania:manasteelaxe>
}));
recipes.addShapeless(<enderio:item_material>*4,[<enderio:item_material:1>]);
T.tic.casting(<enderio:item_material:73>, gearMith, <liquid:dark_steel>*576, 600);

//9x9 crafting table
var dreamWood = <botania:dreamwood>;
var redString = <botania:manaresource:12>;
var craftingTable = <avaritia:extreme_crafting_table>;
var tablet = <botania:manatablet>;
recipes.remove(<extrautils2:decorativesolidwood:1>);
T.bot.daisy(dreamWood,<extrautils2:decorativesolidwood:1>,50);
recipes.addShaped(craftingTable,Mp.read("AA;AA",{"A":dreamWood}));
recipes.remove(tablet);
recipes.addShaped(tablet,Mp.read("RRR;RWR;RRR;",{"W":dreamWood,"R":<botania:livingrock>}));
recipes.remove(redString);
T.bot.altar(<botania_tweaks:dire_crafty_crate>,Mp.read("A0B0C0D0E0;",{
    "0":<botania:opencrate:1>, "A":redString, "B":<minecraft:concrete:14>, "C":<minecraft:red_glazed_terracotta>, "D": craftingTable,
    "E":<tconstruct:toolforge>.withTag({textureBlock: {id: "minecraft:redstone_block", Count: 1 as byte, Damage: 0 as short}})
})[0],2857142);

var l0 = [<botania:manaresource:16>,<mysticalagriculture:crafting:23>,redString,<minecraft:string>] as IItemStack[];
for i in 0 to 3{
    T.bm.altar(l0[i+1],l0[i],100);
}
//BloodMagic
T.tic.casting(<bloodmagic:soul_forge>,<embers:block_furnace>,<liquid:blood>*10000,10000,true,true);
recipes.remove(<bloodmagic:soul_snare>);
recipes.addShaped(<bloodmagic:soul_snare>,Mp.read("SIS;ICI;SIS;",{
    "S":<botania:manaresource:16>,"I":<mysticalagriculture:crafting:33>,"C":<enderio:item_basic_capacitor>
}));
recipes.addShaped(<bloodmagic:altar>,Mp.read("AaA;BbB;CcC;",{
    "A":<tconstruct:slime:3>,"B":<tconstruct:seared:6>,"C":<enderio:item_material:1>,
    "a":<enderio:item_material:41>,"b":<bloodmagic:soul_forge>,"c":<botania:runealtar>
}));
Agg.addRecipe(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:blaze"}}),
    [<minecraft:egg>],3000000,0xFFFF77,0xFFFF00,
    <liquid:mana>,<botania:blazeblock>,<liquid:pyrotheum>,
    <liquid:mana>,<minecraft:obsidian>,<liquid:lava>);
mods.tconstruct.Melting.addEntityMelting(<entity:minecraft:blaze>,<liquid:pyrotheum>);
recipes.remove(<bloodmagic:alchemy_table>);
T.te.refinery(<liquid:lifeessence>, <liquid:blood>*666, 400);
recipes.remove(<bloodmagic:sacrificial_dagger>);
T.bm.altar(<bloodmagic:sacrificial_dagger>,<botania:manasteelsword>,144);
recipes.addShaped(<enderio:item_broken_spawner>,
    Mp.read("AAA;A_A;AAA;",{"A":<enderio:block_dark_iron_bars>}));
T.tic.casting(<minecraft:mob_spawner>,<enderio:item_broken_spawner>,<liquid:lifeessence>*10000,3000,true,true);
T.tic.casting(<botania:spawnermover>,
    <tconstruct:large_plate>.withTag({Material: "xu_enchanted_metal"}),
    <liquid:lifeessence>*3000,3000);
T.bm.altar(<botania:spawnerclaw>,<botania:spawnermover>,10086);
recipes.remove(<botania:spawnerclaw>);

//Fixes 20230724
recipes.remove(<enderio:item_material:22>);
recipes.remove(<enderio:item_travel_staff>);
recipes.remove(<enderio:block_travel_anchor>);
//recipes.addShaped(<mysticalagriculture:tinkering_table>,Mp.read("AAA;B_B;B_B;",{"A":<tconstruct:seared:3>,"B":<mysticalagriculture:crafting:33>}));
T.tic.casting(<enderio:item_travel_staff>,<enderio:item_xp_transfer>,<liquid:molten_essence>*144,900);
recipes.addShaped(<enderio:block_travel_anchor>,Mp.read("ABA;BCB;ABA;",{"A":<enderio:block_alloy:9>,"B":<enderio:item_material:20>,"C":<mysticalagriculture:crafting:33>}));