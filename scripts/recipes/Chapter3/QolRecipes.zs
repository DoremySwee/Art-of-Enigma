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
T.ava.shaped(<minecraft:quartz_block>*64,/*Mp.read("
    @@#@_@_@@;
    @#@_@_@$@;
    #@@_@_@@_;
    @__%@$__@;
    _@@@%@@@_;
    @__$@%__@;
    _@@_@_@@#;
    @$@_@_@#@;
    @@_@_@#@@;
    ",{
    "@":<mysticalagriculture:nether_quartz_essence>,
    "#":<mysticalagriculture:stone_essence>,
    "$":<mysticalagriculture:nether_essence>,
    "%":<mysticalagriculture:water_essence>
})/*/Mp.read("
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
})/**/
);
T.tic.melt(<liquid:redstone>*1000,<mysticalagriculture:redstone_essence>,1);
//recipes.removeByRecipeName("mysticalagriculture:redstone");
T.tc.shapeless(<minecraft:redstone>*64,[<mysticalagriculture:redstone_essence>],10);
T.tc.shapeless(<minecraft:glowstone>*64,[<mysticalagriculture:glowstone_essence>],10);
recipes.addShapeless(<botania:spreader:2>, [<botania:spreader>, <botania:dreamwood>]);
