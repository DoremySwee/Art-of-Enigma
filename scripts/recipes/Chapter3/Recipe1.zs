import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;

import mods.embers.Stamper;

var brick = <embers:brick_caminite>;

furnace.remove(brick);
recipes.remove(<embers:dawnstone_anvil>);
recipes.remove(<embers:ember_bore>);
recipes.remove(<embers:archaic_light>);

T.tic.casting(<embers:blend_caminite>, <thermalfoundation:metrial:72>, <liquid:molten_essence>*144, 144);
T.tic.casting(brick, <embers:blend_caminite>, <liquid:glass>*144, 600);
T.tic.casting(<embers:crystal_ember>, <tconstruct:cast_custom:1>, <liquid:pyrotheum>*16, 288, false);

Agg.addRecipe(<minecraft:snowball>,[<appliedenergistics2:paint_ball:23>],300000,0x0000FF,0x8888FF,
    <thermalfoundation:glass:2>,<thermalfoundation:storage:8>,<minecraft:lapis_block>,
    <thermalfoundation:glass:8>,<thermalfoundation:storage:2>,<minecraft:lapis_ore>
);
Agg.addRecipe(<thermalfoundation:material:264>,[<thermalfoundation:material:288>],500000,0x444466,0x8888FF,
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
    "G": <thermalfoundation:material:264>,
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
    "0": <toncstruct:faucet>,
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
recipes.addShaped(table, Mp.read("444;5F5,5_5",map1));
recipes.addShaped(<embers:block_furnace>,Mp.read("S6S;s7s;&8&;",map1));
recipes.addShaped(<embers:stamper_base>,Mp.read("-_-;s-s;BTB;",map1));
recipes.addShaped(<embers:mixer>,Mp.read("&9&;0G0;~R~;",map1));
recipes.remove(<embers:geo_separator>);
recipes.addShaped(<embers:geo_separator>,Mp.read("-_-;~~~;",map1));
recipes.remove(<embers:ember_activator>);
recipes.addShaped(<embers:ember_activator>,Mp.read("&@&;&#&;~!~;"));


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