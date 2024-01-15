#reloadable
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
//TODO: change some casting into TE Fluid transport / embers press
Agg.removeDefaultRecipe();
//seeds' materials
var seed3 = <mysticalagriculture:crafting:19>;
recipes.remove(<extrautils2:decorativeglass:4>);
T.te.compress(<calculator:smalltanzanite>,<calculator:largetanzanite>);
T.cc.scientific(<calculator:shardtanzanite>,[<calculator:largetanzanite>,<calculator:smalltanzanite>]);
T.tic.casting(<extrautils2:decorativeglass:4>,<extrautils2:decorativeglass:5>,<liquid:glowstone>*1000,3000,true,true);/*
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
T.tic.casting(<mysticalagriculture:crafting:2>,<mysticalagriculture:prudentium_apple>,<liquid:molten_essence>*8192);*/
T.bot.rune(<mysticalagriculture:tier3_inferium_seeds>*4,Mp.read("@#@$@%@&", {
    "@":<mysticalagriculture:crafting:2>,
    "#":<mysticalagriculture:tier2_inferium_seeds>,
    "$":<mysticalagriculture:fire_seeds>,
    "%":<mysticalagriculture:dye_seeds>,
    "&":<mysticalagriculture:slime_seeds>
})[0],500000);
T.bm.altar(seed3, <mysticalagriculture:tier3_inferium_seeds>, 8192, 3);
T.cc.scientific(<mysticalagriculture:crafting:32>,[<mysticalagriculture:crafting:33>,<mysticalagriculture:crafting>]);
recipes.addShapeless(<mysticalagriculture:crafting:39>*9,[<mysticalagriculture:crafting:32>]);
recipes.addShaped(<mysticalagriculture:crafting:32>,Mp.read("AAA;AAA;AAA;",{
    "A":<mysticalagriculture:crafting:39>
}));
T.ie.press(<mysticalagriculture:crafting:22>,<mysticalagriculture:crafting:39>*5,
    <tconstruct:cast>.withTag({PartType: "tconstruct:tool_rod"})
);
T.tic.casting(<mysticalagriculture:crafting:29>,<mysticalagriculture:crafting:28>,<liquid:soularium>*144,3000);
/*
recipes.addShaped(<minecraft:quartz>,Mp.read("AAA;ABA;AAA;",{
    "A":<mysticalagriculture:nether_essence>,"B":<appliedenergistics2:material>
}));*/
T.tic.casting(<botania:quartz:5>,<botania:quartz:1>,<liquid:molten_chlorophyte>*144,300);
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
})[0],20000000);/*
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
})[0],2000000);*/
T.tc.shaped(<mysticalagriculture:slime_seeds>,[
    [<mysticalagriculture:chunk:11>,<contenttweaker:shard_balanced>,<tconstruct:edible:31>],
    [<contenttweaker:shard_aqua>,<mysticalagriculture:crafting:18>,<contenttweaker:shard_terra>],
    [<tconstruct:edible:34>,<tconstruct:materials:10>,<tconstruct:edible:30>]
],10);
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
//Knight Slime
T.eio.vat(<liquid:blueslime>, <liquid:bot_mana>, 1.0f,[
        <tconstruct:large_plate>.withTag({Material: "blueslime"}) % 200,
        <tconstruct:pan_head>.withTag({Material: "blueslime"}) % 75,
        <tconstruct:tough_binding>.withTag({Material: "blueslime"}) % 75,
        <tconstruct:materials:10> % 20
    ],[
        <mysticalagriculture:slime_essence> %20,
        <mysticalagriculture:knightslime_essence> %30,
        <mysticalagriculture:slime_seeds> %200,
        <mysticalagriculture:knightslime_seeds> %1000
    ]);
recipes.remove(<tconstruct:soil:5>);
T.tic.casting(<tconstruct:slime_sapling>,<minecraft:sapling>,<liquid:blueslime>*144,900);
T.ie.mix(<liquid:purpleslime>*250,[<tconstruct:edible:4>],<liquid:blueslime>*250);
T.tic.casting(<tconstruct:ingots:3>,<mysticalagriculture:crafting:32>,<liquid:purpleslime>*250,900);
T.ava.shaped(<mysticalagriculture:knightslime_seeds>*2,Mp.read("
    @___#____;
    _@@#_____;
    _@$#_%&__;
    _*~@#1#__;
    233454332;
    __#1#@~*_;
    __&%_#$@_;
    _____#@@_;
    ____#___@;
    ",{
    "@":<contenttweaker:shard_balanced>,
    "1":<mysticalagriculture:crafting:19>,
    "2":<tconstruct:bow_limb>.withTag({Material: "knightslime"}),
    "#":<thaumcraft:salis_mundus>,
    "3":<tconstruct:bow_string>.withTag({Material: "slimevine_blue"}),
    "$":<appliedenergistics2:material:7>,
    "4":<tconstruct:large_sword_blade>.withTag({Material: "knightslime"}),
    "%":<tconstruct:arrow_head>.withTag({Material: "knightslime"}),
    "5":<tconstruct:rapier>.withTag({"TinkerData": {"Materials": ["knightslime", "knightslime", "knightslime"]}}),
    "&":<tconstruct:shuriken>.withTag({"TinkerData": {"Materials": ["knightslime", "knightslime", "knightslime", "knightslime"]}}),
    "*":<tconstruct:broad_axe_head>.withTag({Material: "knightslime"}),
    "~":<tconstruct:scythe_head>.withTag({Material: "knightslime"})
}));
//Liquid Elf
T.ie.mix(<liquid:bot_elf>*100,[
    <thaumcraft:salis_mundus>, <mysticalagriculture:knightslime_essence>,
    <thaumcraft:alumentum>, <extrautils2:ingredients:3>
],<liquid:bot_mana>*100);
//Elf portal
//Cholorophyte
T.eio.vat(<liquid:molten_chlorophyte>, <liquid:emerald>, 1.0f/9, [<mysticalagriculture:nature_seeds>%160],[<contenttweaker:shard_terra>%9,<thaumcraft:salis_mundus>%36]);
T.tic.casting(<contenttweaker:chlorophyte_ore>,<thermalfoundation:ore:6>,<liquid:molten_chlorophyte>*144,900,true,true);
T.tic.melting(<liquid:molten_chlorophyte>*16,<contenttweaker:chlorophyte_ore>);
    T.te.magama(<liquid:molten_chlorophyte>*16,<contenttweaker:chlorophyte_ore>);
T.tic.casting(<botania:pylon:1>,<botania:pylon>,<liquid:molten_chlorophyte>*1440,900,true,true);
T.tic.casting(<contenttweaker:chlorophyte_ingot>,<tconstruct:cast_custom>,<liquid:molten_chlorophyte>*144,80,false);
T.tic.melting(<liquid:molten_chlorophyte>*144,<contenttweaker:chlorophyte_ingot>);
    T.te.magama(<liquid:molten_chlorophyte>*144,<contenttweaker:chlorophyte_ingot>);
T.tic.casting(<botania:livingwood:5>,<botania:livingwood>,<liquid:molten_chlorophyte>*144,900,true,true);

T.tic.casting(<botania:manaresource:7>,<botania:manaresource>,<liquid:bot_elf>*1440,900);
T.tic.casting(<botania:manaresource:8>,<botania:manaresource:23>,<liquid:bot_elf>*1440,900);
T.tic.casting(<botania:manaresource:9>,<botania:manaresource:2>,<liquid:bot_elf>*1440,900);

//T.bot.rune(<contenttweaker:wand_cap_manasteel_inert>,Mp.read1d("BAAAAAA",{"B":<contenttweaker:wand_cap_iron>,"A":<mysticalagriculture:manasteel_essence>}), 6000);
T.tc.shaped(<contenttweaker:wand_cap_manasteel_inert>,Mp.read("ABA;BCB;ABA;",{
    "A":<thaumcraft:fabric>,"B":<contenttweaker:shard_balanced>,"C":<contenttweaker:wand_cap_iron>
}),4);
recipes.addShaped(<contenttweaker:wand_cap_manasteel>,Mp.read("A1A;2B3;A4A;",{
    "A":<contenttweaker:wand_cap_manasteel_inert>.transformReplace(<contenttweaker:wand_cap_iron>), "B":<contenttweaker:wand_cap_manasteel_inert>,
    "1":<mysticalagriculture:manasteel_essence>,"4":<forge:bucketfilled>.withTag({FluidName: "bot_mana", Amount: 1000}),
    "2":<contenttweaker:shard_balanced>,"3":<thaumcraft:salis_mundus>
}));
//T.tic.casting(<contenttweaker:wand_cap_manasteel>, <contenttweaker:wand_cap_manasteel_inert>, <liquid:bot_mana>*1440,900);
mods.thaumcraft.ArcaneWorkbench.removeRecipe(<thaumcraft:fabric>);
T.tc.shaped(<thaumcraft:fabric>,Mp.read("ACA;CBC;ACA;",{
    "A":<mysticalagriculture:crafting:23>,"B":<thermalfoundation:rockwool:12>,
    "C":<tconstruct:bow_string>.withTag({Material: "slimevine_blue"})
}),4);

T.ava.shaped(<botania:alfheimportal>,Mp.read("
    @@@@#@@@@;
    @$%&*~%1@;
    @2%343%5@;
    @6#7*8#6@;
    909`!`909;
    @6#^a^#6@;
    @b%cdc%e@;
    @f%^a^%g@;
    @@@@#@@@@;
    ",{
    "@":<botania:livingwood>,
    "^":<mysticalagriculture:manasteel_essence>,
    "`":<botania:manaresource:9>,
    "!":<appliedenergistics2:spatial_pylon>,
    "a":<mysticalagriculture:crafting:10>,
    "b":<botania:elementiumlegs>,
    "#":<botania:livingwood:5>,
    "c":<mysticalagriculture:manasteel_seeds>,
    "$":<botania:elementiumhelm>,
    "d":<thaumicwands:item_wand>.withTag({cap: "manasteel", rod: "livingwood"}),
    "%":<botania:pylon:1>,
    "e":<botania:elementiumshovel>,
    "&":<botania:manatablet>.withTag({mana: 102400}),
    "f":<botania:elementiumboots>,
    "g":<botania:elementiumsword>,
    "*":<botania:manaresource:8>,
    "0":<botania:manaresource:7>,
    "1":<botania:elementiumpick>,
    "2":<botania:elementiumchest>,
    "3":M.consume(M.orb(3)),
    "4":<botania:manatablet>.withTag({mana: 114514}),
    "5":<botania:elementiumaxe>,
    "6":<botania:storage:4>,
    "7":<botania:manatablet>.withTag({mana: 167000}),
    "8":<botania:manatablet>.withTag({mana: 200000}),
    "9":<appliedenergistics2:controller>,
    "~":<botania:manatablet>.withTag({mana: 130000})
}));
//Trading basic
var outputs = [<botania:dreamwood>,<botania:manaresource:7>,<botania:manaresource:8>,<botania:manaresource:9>,<botania:storage:2>,<botania:storage:4>,<botania:quartz:5>,<botania:elfglass>,<botania_tweaks:dire_crafty_crate>]as IItemStack[];
for i in outputs{
    mods.botania.ElvenTrade.removeRecipe(i);
}
T.bot.trade([<botania:livingwood>],[<botania:dreamwood>]);
T.bot.trade([<botania:manaresource>*2],[<botania:manaresource:7>]);
T.bot.trade([<botania:manaresource:1>],[<botania:manaresource:8>]);
T.bot.trade([<botania:manaresource:2>],[<botania:manaresource:9>]);
T.bot.trade([<minecraft:quartz>],[<botania:quartz:5>]);

//Wither
T.embers.stamp(<thermalexpansion:augment:369>,<liquid:bot_elf>*250,[
    <tconstruct:materials:14>,<thermalfoundation:upgrade>
]);
T.tic.casting(<minecraft:skull:1>,<minecraft:skull>,<liquid:potion>.withTag({Potion:"cofhcore:wither4"})*250,900);
recipes.remove(<extrautils2:ingredients:5>);
recipes.addShaped(<extrautils2:ingredients:5>,Mp.read("BAB;ABA;BAB;",{
    "A":<extrautils2:ingredients:3>,"B":<extrautils2:unstableingots>
}));

//Spatial Pylon & Avaritia Compresser
recipes.remove(<appliedenergistics2:quantum_ring>);
recipes.remove(<appliedenergistics2:quantum_link>);
recipes.remove(<appliedenergistics2:material:9>);
T.tic.casting(<appliedenergistics2:material:9>,<botania:manaresource:1>,<liquid:bot_elf>*576,900);
val matrix = <appliedenergistics2:matrix_frame>;
recipes.remove(<appliedenergistics2:material:32>);
recipes.remove(<appliedenergistics2:material:33>);
recipes.remove(<appliedenergistics2:material:34>);
T.ava.shaped(<appliedenergistics2:material:32>,Mp.read("
    _________;
    ___@_@___;
    __#$%$#__;
    _@$&*&$@_;
    __%*~*%__;
    _@$&*&$@_;
    __#$%$#__;
    ___@_@___;
    _________;
    ",{
    "@":<appliedenergistics2:material:1>,
    "#":<mysticalagriculture:certus_quartz_essence>,
    "$":<minecraft:quartz>,
    "%":/*<appliedenergistics2:sky_stone_block>*/<astralsorcery:itemcraftingcomponent:1>,
    "&":<mysticalagriculture:nether_quartz_essence>,
    "*":<mysticalagriculture:sky_stone_essence>,
    "~":<appliedenergistics2:material:9>
}));
Agg.addRecipe(<avaritia:neutronium_compressor>,[
    <thermalexpansion:machine:5>.withTag({"Level": 1 as byte}),
    <appliedenergistics2:material:32>,<avaritia:extreme_crafting_table>
],30000000,0xCCCCCC,0xCCCCFF,matrix,matrix,matrix,matrix,matrix,matrix);

//AstralSorcery Materials & Draconic Fusion
M.removeGrind(<astralsorcery:itemcraftingcomponent:2>,<astralsorcery:itemcraftingcomponent:1>,<astralsorcery:blockcustomore:1>);
for i in 0 to 3{
    var j = ([9,7,8]as int[])[i];
    Agg.addRecipe(<astralsorcery:itemcraftingcomponent>.definition.makeStack(i),[
        <calculator:largetanzanite>,<extrautils2:ingredients:5>,<mysticalagriculture:manasteel_essence>,
        <mysticalagriculture:sky_stone_essence>,<appliedenergistics2:material:47>,<minecraft:nether_star>,
        <botania:manaresource>.definition.makeStack(j)
    ],3000000,0xFFCCDD,0xCCCCFF,
    <botania:miniisland>,<botania:starfield>,<botania:enchanter>,
    <botania:miniisland>,<botania:starfield>,<botania:enchanter>);
}
recipes.remove(<draconicevolution:crafting_injector>);
recipes.remove(<draconicevolution:fusion_crafting_core>);
T.ava.shaped(<draconicevolution:crafting_injector>*8,Mp.read("
    @#$$%$$$$;
    $&#@*%&~$;
    $*1#2@~%%;
    #@33#1@3$;
    $3#*4*#3$;
    $3@1#33@#;
    %%~@2#1*$;
    $~&%*@#&$;
    $$$$%$$#@;
    ",{
    "@":<astralsorcery:itemcraftingcomponent>,
    "1":<botania:runealtar>,
    "2":<botania:spawnermover>,
    "#":<astralsorcery:itemcraftingcomponent:1>,
    "3":<mysticalagriculture:crafting:32>,
    "$":<minecraft:quartz_block>,
    "4":<calculator:flawlesscalculator>.withTag({"0": {}, slot4: "Energy Module", "1": {}, slot3: "Storage", "2": {}, slot2: "Crafting", "3": {}, slot1: "Dynamic", "4": {}, slot0: "Flawless"}),
    "%":<astralsorcery:itemcraftingcomponent:2>,
    "&":<botania:alchemycatalyst>,
    "*":<appliedenergistics2:material:22>,
    "~":<appliedenergistics2:material:38>
}));
T.ava.shaped(<draconicevolution:fusion_crafting_core>,Mp.read("
    @##$%%%%%;
    @&$**~~&#;
    @~$1~1$$#;
    @~1$~$12$;
    @3~~4~~2@;
    $31$~$1~@;
    #$$1~1$~@;
    #&~~55$&@;
    %%%%%$##@;
    ",{
    "@":<mysticalagriculture:crafting:32>,
    "1":<draconicevolution:crafting_injector>,
    "2":<mysticalagriculture:certus_quartz_essence>,
    "#":<appliedenergistics2:molecular_assembler>,
    "3":<mysticalagriculture:nether_quartz_essence>,
    "$":<astralsorcery:itemcraftingcomponent:2>,
    "4":<botania:sparkupgrade:1>,
    "%":<minecraft:quartz_block>,
    "5":<mysticalagriculture:glowstone_essence>,
    "&":<astralsorcery:itemcraftingcomponent>,
    "*":<mysticalagriculture:redstone_essence>,
    "~":<astralsorcery:itemcraftingcomponent:1>
}));
T.de.fusion(<mysticalagriculture:crafting:3>*20,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"}),
Mp.read("@#$%&@*~123@4567@890`!^", {
    "@":<mysticalagriculture:crafting:2>,
    "`":<botania:manaresource:8>,
    "!":<botania:manaresource:7>,
    "#":<mysticalagriculture:nether_quartz_essence>,
    "$":<mysticalagriculture:glowstone_essence>,
    "%":<mysticalagriculture:redstone_essence>,
    "&":<mysticalagriculture:knightslime_essence>,
    "*":<mysticalagriculture:manasteel_essence>,
    "0":<botania:manaresource:9>,
    "1":<mysticalagriculture:sky_stone_essence>,
    "2":<tconstruct:seared_tank:1>.withTag({FluidName: "bot_mana", Amount: 4000}),
    "3":<tconstruct:seared_tank:1>.withTag({FluidName: "bot_elf", Amount: 4000}),
    "4":<tconstruct:seared_tank:1>.withTag({FluidName: "molten_chlorophyte", Amount: 4000}),
    "5":<tconstruct:seared_tank:1>.withTag({FluidName: "molten_essence", Amount: 4000}),
    "6":<tconstruct:seared_tank:1>.withTag({FluidName: "xu_evil_metal", Amount: 4000}),
    "7":<botania:starfield>,
    "8":<astralsorcery:itemcraftingcomponent:1>,
    "9":<astralsorcery:itemcraftingcomponent:2>,
    "~":<mysticalagriculture:certus_quartz_essence>,
    "^":<botania:manaresource:12>
})[0],10000000);
T.de.fusion(<botania:pylon:2>,<botania:pylon:1>,Mp.read("#$%&*~123456789", {
    "#":<tconstruct:seared_tank:1>.withTag({FluidName: "bot_elf", Amount: 4000}),
    "$":<botania:manaresource:8>,
    "%":<botania:manaresource:9>,
    "&":<botania:manaresource:7>,
    "*":<botania:elementiumhelm>,
    "1":<botania:elementiumlegs>,
    "2":<botania:elementiumboots>,
    "3":<botania:elementiumpick>,
    "4":<botania:elementiumshovel>,
    "5":<botania:elementiumaxe>,
    "6":<botania:elementiumsword>,
    "7":<botania:elementiumshears>,
    "8":<botania:openbucket>,
    "9":<botania:pixiering>,
    "~":<botania:elementiumchest>
})[0],10000000);

//Gaia
recipes.addShaped(<botania:manaresource:14>,Mp.read("@#$;%&*;~12;",{
    "@":<astralsorcery:itemcraftingcomponent>,
    "1":<botania:manaresource:9>,
    "2":<astralsorcery:itemcraftingcomponent:2>,
    "#":<botania:manaresource:8>,
    "$":<astralsorcery:itemcraftingcomponent:1>,
    "%":<botania:manaresource:7>,
    "&":<appliedenergistics2:material:9>,
    "*":<minecraft:nether_star>,//<contenttweaker:chlorophyte_ingot>,
    "~":<bloodmagic:sacrificial_dagger>.withTag({sacrifice: 0 as byte})
}));

<entity:minecraft:wither>.removeDrop(<mysticalagriculture:crafting:4>);
<entity:minecraft:wither>.removeDrop(<contenttweaker:division_sigil>);
<entity:minecraft:wither>.addDrop(<contenttweaker:division_sigil>);

/*
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