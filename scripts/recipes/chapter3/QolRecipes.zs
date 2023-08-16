#loader crafttweaker reloadableevents
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
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
//recipes.removeByRecipeName("mysticalagriculture:redstone");
T.tc.shapeless(<minecraft:redstone>*64,[<mysticalagriculture:redstone_essence>],10);
T.tc.shapeless(<minecraft:glowstone>*64,[<mysticalagriculture:glowstone_essence>],10);
recipes.addShapeless(<botania:spreader:2>, [<botania:spreader>, <botania:dreamwood>]);

T.exu.enchant(<botania:lens:12>,[<botania:lens:16>,
    <minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 2 as short, id: 19 as short}]})],
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
    ___@#$___;
    ___@#@___;
    ___@#@___;
    ___@#@___;
    ___@@@___;
    _________;
    ",{
    "@":<botania:managlass>,
    "#":<extrautils2:decorativeglass:4>,
    "$":<botania:managlass> * 2
}));
T.ae.inscribe(<botania:specialflower>.withTag({type: "rannuncarpus"}),[<botania:specialflower>.withTag({type: "hopperhock"}),<appliedenergistics2:part:320>,<appliedenergistics2:part:320>]);