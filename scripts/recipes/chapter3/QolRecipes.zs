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