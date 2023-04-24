mods.tconstruct.Casting.addTableRecipe(<embers:blend_caminite>,<thermalfoundation:material:72>,<liquid:dirt>,144,true,144);
mods.tconstruct.Casting.addTableRecipe(<embers:brick_caminite>,<embers:blend_caminite>,<liquid:glass>,144,true,144);
furnace.remove(<embers:brick_caminite>);
recipes.removeShaped(<embers:dawnstone_anvil>);
recipes.removeShaped(<embers:ember_bore>);
recipes.removeShaped(<embers:archaic_light>);

recipes.addShaped(<embers:tinker_hammer>.withTag({}),[
    [<ore:ingotDarkSteel>,<embers:brick_caminite>,<ore:ingotDarkSteel>],
    [<ore:ingotDarkSteel>,<ore:stickTreatedWood>,<ore:ingotDarkSteel>],
    [null,<ore:stickTreatedWood>,null]]);

mods.tconstruct.Casting.addTableRecipe(<embers:crystal_ember>,<tconstruct:cast_custom:1>,<liquid:pyrotheum>,16,false,72);


var mytI=<ore:ingotMithril>;
var mytD=<ore:dustMithril>;
var mythI=<ore:ingotMithril>;
var mythD=<ore:dustMithril>;
var mythGlass=<thermalfoundation:glass:8>;
var steG=<ore:gearSteel>;
var fluixC=<ore:crystalFluix>;
recipes.addShaped(<thermalfoundation:upgrade>,[
    [null,mytI,null],
    [mythI,steG,mytI],
    [fluixC,mytI,fluixC]]);
var pool=<botania:pool>;
var converter=<botania:rfgenerator>;
recipes.addShaped(<thermalexpansion:machine>,[
    [mytI,pool,mytI],
    [<embers:crystal_ember>,<minecraft:furnace>,<embers:crystal_ember>],
    [mytI,converter,mytI]]);
recipes.addShaped(<thermalexpansion:machine:1>,[
    [mytI,pool,mytI],
    [<embers:crystal_ember>,<enderio:block_simple_sag_mill>,<embers:crystal_ember>],
    [mytI,converter,mytI]]);
recipes.addShaped(<thermalexpansion:machine>,[
    [mytI,pool,mytI],
    [<botania:manasteelaxe>,steG,<minecraft:diamond_axe>],
    [mytI,converter,mytI]]);

recipes.addShaped(<thermalfoundation:material:512>,[
    [fluixC,steG,mythI],
    [mythI,<embers:crystal_ember>,<minecraft:redstone>]]);

recipes.addShaped(<thermalexpansion:frame:64>,[
    [mythI,mythGlass,mythI],
    [mythGlass,steG,mythGlass],
    [mythI,mythGlass,mythI]]);


mods.tconstruct.Casting.addTableRecipe(<embers:adhesive>,<minecraft:slime_ball>,<liquid:sap>,34,false,72);
recipes.remove(<thermalexpansion:florb>);
recipes.remove(<thermalexpansion:florb:1>);



var caI=<embers:brick_caminite>;
var caD=<embers:blend_caminite>;
var caB=<embers:block_caminite_brick>;
var adh=<embers:adhesive>;
var FeAlloy=<enderio:item_alloy_ingot:9>;

recipes.addShaped(<embers:block_furnace>,[
    [caI,adh,caI],
    [caI,<enderio:block_simple_alloy_smelter>,caI],
    [FeAlloy,<forge:bucketfilled>.withTag({FluidName: "pyrotheum", Amount: 1000}),FeAlloy]
]);
recipes.addShaped(<embers:stamper_base>,[
    [FeAlloy,null,FeAlloy],
    [caB,FeAlloy,caB],
    [caB,adh,caB]]);
recipes.addShaped(<embers:stamper>,[
    [caB,adh,caB],
    [FeAlloy,<minecraft:sticky_piston>,FeAlloy],
    [caB,<enderio:block_dark_steel_anvil>,caB]]);
//