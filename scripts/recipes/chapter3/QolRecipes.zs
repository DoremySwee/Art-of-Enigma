#loader crafttweaker reloadableevents
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

//Essences
    recipes.addShaped(<botania:manaresource:2>,Mp.read("_M_;MMM;_M_;",{
        "M":<mysticalagriculture:manasteel_essence>
    }));
    T.bot.rune(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}}),[
        <minecraft:egg>, <mysticalagriculture:slime_seeds>, <mysticalagriculture:chunk:11>
    ],1000000);
    T.bot.rune(<minecraft:spawn_egg>.withTag({EntityTag: {id: "tconstruct:blueslime"}}),[
        <minecraft:egg>, <mysticalagriculture:slime_seeds>, <mysticalagriculture:knightslime_essence>, <tconstruct:materials:10>
    ],3000000);
    recipes.remove(<minecraft:quartz>);
    T.ava.shaped(<minecraft:quartz_block>*64,Mp.read("
        @@@@@@@@@;
        @@@_@_@@@;
        @@@@@@@@@;
        @_@@_@@_@;
        @@@_@_@@@;
        @_@@_@@_@;
        @@@@@@@@@;
        @@@_@_@@@;
        @@@@@@@@@;
        ",{
        "@":<mysticalagriculture:nether_quartz_essence>
    }));
    T.tic.melt(<liquid:redstone>*1000,<mysticalagriculture:redstone_essence>,1);
    T.te.magama(<liquid:redstone>*1000,<mysticalagriculture:redstone_essence>, 10);
    //recipes.removeByRecipeName("mysticalagriculture:redstone");
    T.tc.shapeless(<minecraft:redstone>*64,[<mysticalagriculture:redstone_essence>],10);
    T.tc.shapeless(<minecraft:glowstone>*64,[<mysticalagriculture:glowstone_essence>],10);
    recipes.addShapeless(<botania:spreader:2>, [<botania:spreader>, <botania:dreamwood>]);

//Bot lens
    T.exu.enchant(<botania:lens:12>,[<botania:lens:16>,
        <minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 1 as short, id: 19 as short}]})],
        3000, 1000);
    T.bot.rune(<botania:lens:13>*6,Mp.read("%@%#%$%&%*%~", {
        "@":<minecraft:anvil>,
        "#":<minecraft:concrete_powder:3>,
        "$":<minecraft:sand:1>,
        "%":<botania:lens:12>,
        "&":<mysticalagriculture:crafting:23>,
        "*":<contenttweaker:shard_terra>,
        "~":<contenttweaker:shard_perditio>
    })[0],100000);
    T.ava.shaped(<botania:prism>*16,Mp.read("
        _________;
        ___@@@___;
        ___@#@___;
        ___@#@___;
        ___@#@___;
        ___@#@___;
        ___@#@___;
        ___@@@___;
        _________;
        ",{
        "@":<botania:managlass>,
        "#":<extrautils2:decorativeglass:4>,
    }));

//Bot Flowers
    T.ae.inscribe(<botania:specialflower>.withTag({type: "rannuncarpus"}),[<botania:specialflower>.withTag({type: "hopperhock"}),<appliedenergistics2:part:320>,<appliedenergistics2:part:320>]);

//Traveling System
    recipes.remove(<enderio:item_travel_staff>);
    recipes.remove(<enderio:block_travel_anchor>);
    T.te.fill(<enderio:item_travel_staff>,<enderio:item_xp_transfer>,<liquid:molten_essence>*144,9000);
    recipes.addShaped(<enderio:block_travel_anchor>,Mp.read("ABA;BCB;ABA;",{"A":<enderio:block_alloy:9>,"B":<enderio:item_material:20>,"C":<mysticalagriculture:crafting:33>}));

//TE Melter
    recipes.addShaped(<thermalexpansion:machine:6>,Mp.read("121;343;565;",{
        "1":<thermalfoundation:glass:8>,"2":<thermalfoundation:material:264>,
        "3":<embers:crystal_ember>,"4":M.reuse(<bloodmagic:soul_forge>),
        "5":<extrautils2:decorativesolid:3>,"6":<forge:bucketfilled>.withTag({FluidName: "pyrotheum", Amount: 1000})
    }));
    val list0 = [<minecraft:emerald_ore>,<minecraft:emerald>,<minecraft:emerald_block>] as IItemStack[];
    for item in list0{
        mods.thermalexpansion.Crucible.removeRecipe(item);
    }

//Get rid of Dying Lens!
var dupPattern1="_________;_WWWWWWW_;_WWWWWWW_;_WWWWWWW_;_WWWAWWW_;_WWWWWWW_;_WWWWWWW_;_WWWWWWW_;_________;";
for i in 0 to 16{
    var AB = <chisel:antiblock>.definition.makeStack(15-i);
    var W = <minecraft:wool>.definition.makeStack(i);
    T.ava.compress(AB,W*8192);
    T.ava.shaped(W*48,Mp.read(dupPattern1,{
        "W":<minecraft:wool>, "A": M.reuse(AB)
    }));
}
T.ava.shaped(<botania:livingwood>*48,Mp.read(dupPattern1,{
    "W":<ore:logWood>, "A": <mysticalagriculture:nature_essence>
}));
T.ava.shaped(<botania:livingrock>*48,Mp.read(dupPattern1,{
    "W":<minecraft:stone>, "A": <mysticalagriculture:nature_essence>
}));

//Simplified Water / Ice seed
T.bot.trade([<mysticalagriculture:water_seeds>],[<appliedenergistics2:storage_cell_1k>.withTag({
    it: 8 as short, "#0": {Craft: 0 as byte, Cnt: 14 as long, id: "minecraft:water_bucket", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, 
    "#1": {Craft: 0 as byte, Cnt: 6 as long, id: "minecraft:potion", Count: 1 as byte, tag: {Potion: "minecraft:water"}, Damage: 0 as short, Req: 0 as long}, 
    "#2": {Craft: 0 as byte, Cnt: 2 as long, id: "minecraft:enchanted_book", Count: 1 as byte, tag: {
        StoredEnchantments: [{lvl: 1 as short, id: 5 as short}]}, Damage: 0 as short, Req: 0 as long}, 
    "@0": 14, "#3": {Craft: 0 as byte, Cnt: 4 as long, id: "minecraft:enchanted_book", Count: 1 as byte, tag: {
        StoredEnchantments: [{lvl: 1 as short, id: 6 as short}]}, Damage: 0 as short, Req: 0 as long}, 
    "@1": 6, "#4": {Craft: 0 as byte, Cnt: 33 as long, id: "chisel:waterstone", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, 
    "@2": 2, "#5": {Craft: 0 as byte, Cnt: 2 as long, id: "botania:waterbowl", Count: 1 as byte, tag: {Fluid: {FluidName: "water", Amount: 1000}}, Damage: 0 as short, Req: 0 as long}, 
    "@3": 4, "#6": {Craft: 0 as byte, Cnt: 8 as long, id: "botania:specialflower", Count: 1 as byte, tag: {type: "hydroangeas"}, Damage: 0 as short, Req: 0 as long}, 
    "@4": 33, "#7": {Craft: 0 as byte, Cnt: 4 as long, id: "mysticalagriculture:crafting", Count: 1 as byte, Damage: 17 as short, Req: 0 as long}, "@5": 2, "@6": 8, "@7": 4, ic: 73
})]);
T.bot.trade([<mysticalagriculture:ice_seeds>],[<appliedenergistics2:storage_cell_1k>.withTag({
    it: 8 as short, "#0": {Craft: 0 as byte, Cnt: 39 as long, id: "minecraft:ice", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, 
    "#1": {Craft: 0 as byte, Cnt: 8 as long, id: "minecraft:snow", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, 
    "#2": {Craft: 0 as byte, Cnt: 1 as long, id: "minecraft:packed_ice", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, 
    "@0": 39, "#3": {Craft: 0 as byte, Cnt: 4 as long, id: "minecraft:enchanted_book", Count: 1 as byte, tag: {StoredEnchantments: [{lvl: 1 as short, id: 9 as short}]}, Damage: 0 as short, Req: 0 as long}, "
    @1": 8, "#4": {Craft: 0 as byte, Cnt: 8 as long, id: "thermalfoundation:material", Count: 1 as byte, Damage: 2048 as short, Req: 0 as long}, 
    "@2": 1, "#5": {Craft: 0 as byte, Cnt: 8 as long, id: "forge:bucketfilled", Count: 1 as byte, tag: {FluidName: "cryotheum", Amount: 1000}, Damage: 0 as short, Req: 0 as long}, 
    "@3": 4, "#6": {Craft: 0 as byte, Cnt: 8 as long, id: "tconstruct:bolt_core", Count: 1 as byte, tag: {TinkerData: {Materials: ["ice", "electrical_steel"]}}, Damage: 0 as short, Req: 0 as long}, 
    "@4": 8, "#7": {Craft: 0 as byte, Cnt: 4 as long, id: "mysticalagriculture:crafting", Count: 1 as byte, Damage: 17 as short, Req: 0 as long}, "@5": 8, "@6": 8, "@7": 4, ic: 80
})]);

//Add Compressed Machine Stuff
recipes.addShaped(<compactmachines3:machine:5>,Mp.read("ABA;CDC;ABA;",{
    "A":<appliedenergistics2:spatial_pylon>,
    "B":<thermalfoundation:material:264>,
    "C":<thermalfoundation:glass:8>,
    "D":<appliedenergistics2:material:47>
}));
recipes.addShaped(<compactmachines3:tunneltool>,Mp.read("ABA;BCB;ABA;",{
    "A":<minecraft:gold_ingot>,
    "B":<embers:brick_caminite>,
    "C":<appliedenergistics2:material:47>
}));
T.ae.inscribe(<compactmachines3:psd>,[<appliedenergistics2:wireless_terminal>,<appliedenergistics2:material:47>,<appliedenergistics2:material:47>]);

//reservoir
T.ae.inscribe(<thermalexpansion:reservoir:2>,[<thermalexpansion:tank>,<appliedenergistics2:portable_cell>,<thermalfoundation:glass_alloy:1>]);