import mods.botaniatweaks.Agglomeration as Agg;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.embers.Stamper;
import mods.embers.Melter;
import mods.embers.Mixer;
import scripts.Lib;

furnace.remove(<embers:brick_caminite>);
recipes.removeShaped(<embers:dawnstone_anvil>);
recipes.removeShaped(<embers:ember_bore>);
recipes.removeShaped(<embers:archaic_light>);

//Basic Casting
Casting.addTableRecipe(<embers:blend_caminite>,
    <thermalfoundation:material:72>,<liquid:molten_essence>,144,true,144);
Casting.addTableRecipe(<embers:brick_caminite>,
    <embers:blend_caminite>,<liquid:glass>,144,true,600);
Casting.addTableRecipe(<embers:crystal_ember>,
    <tconstruct:cast_custom:1>,<liquid:pyrotheum>,16,false,288);

//Mithril Processing
Agg.addRecipe(<minecraft:snowball>,[<appliedenergistics2:paint_ball:23>],300000,0x0000FF,0x8888FF,
    <thermalfoundation:glass:2>,<thermalfoundation:storage:8>,<minecraft:lapis_block>,
    <thermalfoundation:glass:8>,<thermalfoundation:storage:2>,<minecraft:lapis_ore>
);
Agg.addRecipe(<thermalfoundation:material:264>,[<thermalfoundation:material:288>],500000,0x444466,0x8888FF,
    <minecraft:hopper>,<thermalfoundation:storage:8>,<minecraft:lapis_block>,
    <minecraft:hopper>,<thermalfoundation:storage:2>,<minecraft:lapis_ore>
);
Melter.add(<liquid:silver>*144,<thermalfoundation:material:136>,<liquid:mana>);
<thermalfoundation:material:136>.addTooltip(format.yellow(format.italic(game.localize("description.crt.tooltip.mithril.trymelting"))));

//Basic Tool&Device
static map as IIngredient[string]={
    "_":null,
    "d":<ore:ingotDarkSteel>,
    "b":<embers:brick_caminite>,
    "D":<enderio:block_alloy:6>,
    "B":<embers:block_caminite_brick>,
    "|":<ore:stickTreatedWood>,
    "m":<ore:ingotMithril>,
    "G":<thermalfoundation:glass:8>,        //MithGlass
    "@":<thermalfoundation:material:264>,   //MithGear
    "A":<enderio:block_dark_steel_anvil>,
    "s":<embers:stairs_caminite_brick>,     //stair
    "p":<minecraft:piston>,
    "F":<tconstruct:toolforge>.withTag({
        textureBlock: {id: "thermalfoundation:storage_alloy",
        Count: 1 as byte, Damage: 0 as short}}), //Forge Steel
}as IIngredient[string];
function sh(o as IItemStack,i as string){
    recipes.addShaped(o,Lib.Mapper(map,i));
}
sh(<embers:tinker_hammer>,"dbd;d|d;_|_;");
sh(<embers:stamper>,"sps;@A@;sFs;");
    //seems a bit too complicated, especially for recipes using various ingredients
var SteelBlock=<immersiveengineering:storage:8>;
var CaminiteSlab=<embers:block_caminite_brick_slab>;
recipes.addShaped(<mysticalagriculture:tinkering_table>,[
    [<tconstruct:seared_furnace_controller>,<tconstruct:seared_furnace_controller>,<tconstruct:seared_furnace_controller>],
    [<mysticalagriculture:ingot_storage:1>,
        <tconstruct:toolforge>.withTag({
            textureBlock: {id: "thermalfoundation:storage_alloy",
            Count: 1 as byte, Damage: 0 as short}}),
        <mysticalagriculture:ingot_storage:1>],
    [<mysticalagriculture:ingot_storage:1>,null,<mysticalagriculture:ingot_storage:1>]
]);
recipes.addShaped(<embers:block_furnace>,[
    [<embers:stairs_caminite_brick>,<extrautils2:drum:2>,<embers:stairs_caminite_brick>],
    [<tconstruct:seared:8>,<enderio:block_simple_alloy_smelter>,<tconstruct:seared:8>],
    [SteelBlock,<tconstruct:seared:6>,SteelBlock]
]);
recipes.addShaped(<embers:stamper_base>,[
    [<immersiveengineering:storage_slab:8>,null,<immersiveengineering:storage_slab:8>],
    [<tconstruct:seared:8>,<immersiveengineering:storage_slab:8>,<tconstruct:seared:8>],
    [<embers:block_caminite_brick>,<mysticalagriculture:tinkering_table>,<embers:block_caminite_brick>]
]);
recipes.addShaped(<embers:mixer>,[
    [SteelBlock,<thermalfoundation:glass:8>,SteelBlock],
    [<tconstruct:faucet>,<thermalfoundation:material:264>,<tconstruct:faucet>],
    [CaminiteSlab,<botania:rfgenerator>,CaminiteSlab]
]);
recipes.remove(<embers:geo_separator>);
recipes.addShaped(<embers:geo_separator>,[
    [<immersiveengineering:storage_slab:8>,null,<immersiveengineering:storage_slab:8>],
    [CaminiteSlab,CaminiteSlab,CaminiteSlab]
]);
recipes.remove(<embers:ember_activator>);
recipes.addShaped(<embers:ember_activator>,[
    [SteelBlock,<botania:spreader>,SteelBlock],
    [SteelBlock,<botania:specialflower>.withTag({type: "spectrolus"}),SteelBlock],
    [CaminiteSlab,<botania:specialflower>.withTag({type: "thermalily"}),CaminiteSlab]
]);

//Fluid Processing
Mixer.add(<liquid:alubrass>*64,[<liquid:aluminum>*48,<liquid:copper>*16]);
Mixer.add(<liquid:constantan>*32,[<liquid:nickel>*16,<liquid:copper>*16]);
Mixer.add(<liquid:invar>*48,[<liquid:nickel>*16,<liquid:iron>*32]);
Stamper.remove(<embers:aspectus_iron>);
Stamper.remove(<embers:aspectus_copper>);
Stamper.remove(<embers:aspectus_lead>);
Stamper.remove(<embers:aspectus_silver>);
Stamper.remove(<embers:aspectus_dawnstone>);

Mixer.add(<liquid:electrical_steel>*144,[<liquid:dark_steel>*144,<liquid:alchemical_redstone>*576]);
