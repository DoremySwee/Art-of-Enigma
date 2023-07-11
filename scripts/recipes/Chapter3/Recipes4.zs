#loader crafttweaker reloadableevents
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
//seeds' materials
var seed3 = <mysticalagriculture:crafting:19>;
recipes.remove(<extrautils2:decorativeglass:4>);
T.te.compress(<calculator:smalltanzanite>,<calculator:largetanzanite>);
T.cc.scientific(<calculator:shardtanzanite>,[<calculator:smalltanzanite>,<calculator:largetanzanite>]);
T.tic.casting(<extrautils2:decorativeglass:4>,<extrautils2:decorativeglass:5>,<liquid:glowstone>*1000,3000,true,true);
T.ava.shaped(<mysticalagriculture:prudentium_apple>*12, Mp.read("
    _________;
    _________;
    _@@#$#@@_;
    _@%&$&%@_;
    _*$*~*$*_;
    _@%&$&%@_;
    _@@#$#@@_;
    _________;
    _________;
    ",{
    "@":<minecraft:golden_apple>,
    "#":<mysticalagriculture:dye_essence>,
    "$":<extrautils2:magicapple>,
    "%":<mysticalagriculture:inferium_apple>,
    "&":<mysticalagriculture:fire_essence>,
    "*":<mysticalagriculture:nether_essence>,
    "~":<mysticalagriculture:crafting:1>
}));
T.tic.casting(<mysticalagriculture:crafting:2>,<mysticalagriculture:prudentium_apple>,<liquid:molten_essence>*8192);
T.bot.rune(<mysticalagriculture:tier3_inferium_seeds>*4,Mp.read("@#@$@%@&", {
    "@":<mysticalagriculture:crafting:2>,
    "#":<mysticalagriculture:tier2_inferium_seeds>,
    "$":<mysticalagriculture:fire_seeds>,
    "%":<mysticalagriculture:dye_seeds>,
    "&":<mysticalagriculture:slime_seeds>
})[0],500000);
T.bm.altar(seed3*4, <mysticalagriculture:tier3_inferium_seeds>*4, 32768, 2);
T.cc.scientific(<mysticalagriculture:crafting:32>,[<mysticalagriculture:crafting:33>,<mysticalagriculture:crafting>]);
recipes.addShapeless(<mysticalagriculture:crafting:39>*9,[<mysticalagriculture:crafting:32>]);
recipes.addShaped(<mysticalagriculture:crafting:32>,Mp.read("AAA;AAA;AAA;",{
    "A":<mysticalagriculture:crafting:39>
}));
T.ie.press(<mysticalagriculture:crafting:22>,<mysticalagriculture:crafting:39>*5,
    <tconstruct:cast>.withTag({PartType: "tconstruct:tool_rod"})
);
T.tic.casting(<mysticalagriculture:crafting:29>,<mysticalagriculture:crafting:28>,<liquid:soularium>*144,3000);
recipes.addShaped(<minecraft:quartz>,Mp.read("AAA;ABA;AAA;",{
    "A":<mysticalagriculture:nether_essence>,"B":<appliedenergistics2:material>
}));
//orb3, though it requires some of the tier 3 seeds
Agg.addRecipe(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}),Mp.read("@#$%&*~", {
        "@":<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"})*3,
        "#":<thermalfoundation:fertilizer:2>,
        "$":<tconstruct:large_plate>.withTag({Material: "blueslime"}),
        "%":<mysticalagriculture:manasteel_essence>,
        "&":<tconstruct:materials:14>,
        "*":<thaumcraft:salis_mundus>,
        "~":<botania:alchemycatalyst>
    })[0],3000000,0x00FF00,0x0088FF,
    <botania:miniisland>,<liquid:bot_mana>,<botania:enchanter:1>,
    <minecraft:red_flower:1>,<liquid:water>,<minecraft:lapis_ore>
);
//test
if(false){
    Agg.addRecipe(<minecraft:apple>,Mp.read("#", {
            "#":<thermalfoundation:fertilizer:2>
        })[0],3000000,0x00FF00,0x0088FF,
        <botania:miniisland>,<liquid:bot_mana>,<botania:enchanter:1>,
        <minecraft:red_flower:1>,<liquid:water>,<minecraft:lapis_ore>
    );
    Agg.addRecipe(<minecraft:apple>,Mp.read("*", {
        "*":<thaumcraft:salis_mundus>
        })[0],3000000,0x00FF00,0x0088FF,
        <botania:miniisland>,<liquid:water>,<botania:enchanter:1>,
        <minecraft:red_flower:1>,<liquid:water>,<minecraft:lapis_ore>
    );
    Agg.addRecipe(<minecraft:apple>,Mp.read("*", {
        "*":<thaumcraft:salis_mundus>
        })[0],3000000,0x00FF00,0x0088FF,
        <botania:enchanter:1>,<liquid:water>,<botania:miniisland>,
        <minecraft:red_flower:1>,<liquid:water>,<minecraft:lapis_ore>
    );
    Agg.addRecipe(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}),Mp.read("@#$%&*~", {
            "@":<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"})*3,
            "#":<thermalfoundation:fertilizer:2>,
            "$":<tconstruct:large_plate>.withTag({Material: "blueslime"}),
            "%":<mysticalagriculture:manasteel_essence>,
            "&":<tconstruct:materials:14>,
            "*":<thaumcraft:salis_mundus>,
            "~":<botania:alchemycatalyst>
        })[0],3000000,0x00FF00,0x0088FF
    );
}
//TODO: elf portal

//seeds
T.tic.casting(<mysticalagriculture:redstone_seeds>,
    seed3,<liquid:redstone_alloy>*100000,3000);/*
T.bot.rune(<mysticalagriculture:sky_stone_seeds>*2, Mp.read("@#$%&$@*$%~$", {
    "@":<mysticalagriculture:fire_seeds>,
    "#":<appliedenergistics2:material:14>,
    "$":<appliedenergistics2:sky_stone_block>,
    "%":<mysticalagriculture:crafting:19>,
    "&":<appliedenergistics2:material:15>,
    "~":<appliedenergistics2:material:13>,
    "*":seed3
})[0],6000000);*/
Agg.addRecipe(<appliedenergistics2:material:21>,[
        seed3*2,
        <appliedenergistics2:material:16>,
        <appliedenergistics2:material:17>,
        <appliedenergistics2:material:18>,
        <appliedenergistics2:material:20>,
        <appliedenergistics2:material:21>
    ],3000000,0xFF6600,0x666666,
    <mysticalagriculture:tier3_inferium_crop>,<mysticalagriculture:fire_crop>,<appliedenergistics2:sky_stone_block>,
    <mysticalagriculture:sky_stone_crop>,<mysticalagriculture:tier1_inferium_crop>,<appliedenergistics2:sky_stone_block>);
T.bot.rune(<mysticalagriculture:manasteel_seeds>, Mp.read("@#$%&*~1", {
    "@":<botania:manaresource>,
    "1":<mysticalagriculture:crafting:10>,
    "#":<thaumcraft:fabric>,
    "$":<mysticalagriculture:crafting:19>,
    "%":<botania:manaresource:23>,
    "&":<botania:manabottle>,
    "*":<botania:manatablet>.withTag({mana: 126000}),
    "~":<forge:bucketfilled>.withTag({FluidName: "bot_mana", Amount: 1000})
})[0],20000000);
T.bot.rune(<mysticalagriculture:slime_seeds>, Mp.read("@#$%&*~12222", {
    "@":<mysticalagriculture:crafting:18>,
    "1":<tconstruct:materials:9>,
    "2":<mysticalagriculture:chunk:11>,
    "#":<tconstruct:edible:31>,
    "$":<tconstruct:edible:34>,
    "%":<tconstruct:edible:30>,
    "&":<tconstruct:large_plate>.withTag({Material: "blueslime"}),
    "*":<tconstruct:sign_head>.withTag({Material: "blueslime"}),
    "~":<tconstruct:materials:10>
})[0],6000000);
T.ava.shaped(<mysticalagriculture:nether_quartz_seeds>,Mp.read("
    __@__#$__;
    _%%@_#$_&;
    _%AA@#$&_;
    _%ABC@&__;
    ****~1111;
    __23CBA%_;
    _24#3AA%_;
    2_4#_3%%_;
    __4#__3__;
    ",{
    "@":<botania:quartz>,
    "1":<botania:quartz:6>,
    "2":<botania:quartz:1>,
    "#":<appliedenergistics2:material:11>,
    "3":<minecraft:quartz>,
    "$":<botania:quartz:4>,
    "4":<botania:quartz:5>,
    "%":<appliedenergistics2:crystal_seed:600>.withTag({progress: 1000}),
    "A":<appliedenergistics2:crystal_seed:600>.withTag({progress: 800}),
    "B":<appliedenergistics2:crystal_seed:600>.withTag({progress: 600}),
    "C":M.reuse(M.orb(3)),
    "&":<botania:quartz:2>,
    "*":<botania:quartz:3>,
    "~":<mysticalagriculture:crafting:19>
}));
T.ava.shaped(<mysticalagriculture:certus_quartz_seeds>, Mp.read("
    ____@____;
    ______O__;
    _O_#$____;
    ___$%&*__;
    ~_1%2%1_~;
    __*&%$___;
    ____$#_O_;
    __O______;
    ____@____;
    ",{
    "@":<appliedenergistics2:material:10>,
    "1":<appliedenergistics2:crystal_seed>.withTag({progress: 200}),
    "2":<mysticalagriculture:crafting:19>,
    "#":<appliedenergistics2:crystal_seed>.withTag({progress: 400}),
    "$":<calculator:shardtanzanite>,
    "%":<mysticalagriculture:ice_essence>,
    "&":<appliedenergistics2:crystal_seed>.withTag({progress: 0}),
    "*":<calculator:smalltanzanite>,
    "~":<calculator:largetanzanite>,
    "O":M.reuse(M.orb(3))
}));
T.ava.shaped(<mysticalagriculture:glowstone_seeds>*3, Mp.read("
    ___@__#_$;
    ___@%&_$*;
    __%@~1$*&;
    #_~@2$~&_;
    _3&242&3_;
    _&~$2@~_#;
    &*$1~@%__;
    *$_&%@___;
    $_#__@___;
    ",{
    "@":<chisel:glowstone1:2>,
    "1":<mysticalagriculture:crafting:2>,
    "2":<mysticalagriculture:crafting:19>,
    "#":<extrautils2:suncrystal:240>,
    "3":<mysticalagriculture:fire_seeds>,
    "$":<mysticalagriculture:fire_essence>,
    "4":<thermalexpansion:tank>.withTag({"Fluid": {"FluidName": "glowstone", "Amount": 32768}, "Level": 1 as byte}),
    "%":<extrautils2:suncrystal>,
    "&":<mysticalagriculture:chunk:17>,
    "*":<extrautils2:decorativeglass:4>,
    "~":<thaumcraft:alumentum>
}));
/*
    史莱姆骑士：
        离魂匕首 -> 史莱姆灵魂碎片 -> 史莱姆精华
        液态魔力 + 史莱姆精华 -> 液态蓝色史莱姆 -> 蓝色史莱姆树苗 （使用熔岩史莱姆泥土种植）
        液态蓝色史莱姆 + 熔岩史莱姆球 -> 液态紫色史莱姆
        下级精华锭➗下级精华 = 基础精华锭
        基础精华锭 + 液态紫色史莱姆 -> 骑士史莱姆锭
    精灵门：

/*
    IE搅拌： 液态魔力 [史莱姆骑士精华] 世界盐 源动之焰 月球之尘  ->  液态精灵（cot）
    液态精灵 -> 【升级：炼金术反应釜】-> 凋零III -> 浇筑骷髅头得凋零头 -> 凋灵

    *ban 原本交易
    魔力钢锭 + 液态精灵 -> 源质钢锭 -> 2*魔力钢锭
    魔力钻石 + 液态精灵 -> 龙石 -> 魔力钻石
    魔力尘 + 液态精灵 -> 精灵尘 -> 魔力珍珠     *ban 泰拉钢锭
    液态精灵 + 魔力珍珠 -> 福鲁伊克斯珍珠 -> 空间塔 -> 矩阵框架 -> 水晶矩阵 & 中子态素压缩机 -> 奇点

    下界之星 + 魔力物品 + 陨石精华 + 月之石（ban钻石版合成表，修改产物数量为1）-> 星辉材料
    星辉材料 -> 基础聚合注入器 -> 高级精华
/*
    泰拉钢锭：？ or 直接盖亚魂锭
    盖亚水晶：？
    -> 粉红手炮
    -> 熔融粉红凋零

    合金出一种新的液体
*/