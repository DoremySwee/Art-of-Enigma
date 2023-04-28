import mods.botaniatweaks.Agglomeration as Agg;
import mods.bloodmagic.TartaricForge as TF;
import mods.bloodmagic.BloodAltar as BA;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.embers.Stamper;
import mods.embers.Melter;
import mods.embers.Mixer;
import scripts.Lib;
Casting.addBasinRecipe(<bloodmagic:soul_forge>,<embers:block_furnace>,<liquid:blood>,10000,true,10000);
recipes.remove(<bloodmagic:soul_snare>);
recipes.addShaped(<bloodmagic:soul_snare>,Lib.Mapper({
    "S":<botania:manaresource:16>,"I":<mysticalagriculture:crafting:33>,"C":<enderio:item_basic_capacitor>
},"SIS;ICI;SIS;"));

//Tech Ban
if(true){
    var rs=<minecraft:redstone>;
    var gs=<minecraft:glowstone_dust>;
    var gp=<minecraft:gunpowder>;
    var lt=<minecraft:leather>;
    var st=<minecraft:string>;
    var gi=<minecraft:gold_ingot>;
    var wb=<minecraft:water_bucket>;
    var lb=<minecraft:lava_bucket>;
    var sg=<minecraft:sugar>;
    var tp=<bloodmagic:teleposer>;
    var gl=<minecraft:glass>;
    recipes.remove(tp);
    TF.removeRecipe([tp,<minecraft:glowstone>,<minecraft:redstone_block>,gi]);
    TF.removeRecipe([<minecraft:ghast_tear>,<minecraft:feather>,<minecraft:feather>]);
    TF.removeRecipe([<minecraft:iron_pickaxe>,<minecraft:iron_axe>,<minecraft:iron_shovel>,gp]);
    TF.removeRecipe([gs,rs,<minecraft:gold_nugget>,gp]);
    TF.removeRecipe([<minecraft:glowstone>,<minecraft:torch>,rs,rs]);
    TF.removeRecipe([lb,rs,<minecraft:cobblestone>,<minecraft:coal_block>]);
    TF.removeRecipe([<minecraft:cookie>,sg,<minecraft:cookie>,<minecraft:stone>]);
    TF.removeRecipe([<minecraft:slime>,<minecraft:slime>,lt,st]);
    TF.removeRecipe([<minecraft:chest>,lt,st,st]);
    TF.removeRecipe([<minecraft:ender_eye>,<minecraft:ender_pearl>,gi,gi]);
    TF.removeRecipe([tp,wb,lb,<minecraft:blaze_rod>]);
    TF.removeRecipe([<minecraft:bucket>,st,st,gp]);
    TF.removeRecipe([<minecraft:soul_sand>,<minecraft:soul_sand>,<minecraft:stone>,<minecraft:obsidian>]);
    TF.removeRecipe([<bloodmagic:sigil_divination>,gl,gl,gs]);
    TF.removeRecipe([sg,wb,wb]);
    TF.removeRecipe([<minecraft:flint>,<minecraft:flint>,<bloodmagic:cutting_fluid>]);
    TF.removeRecipe([<minecraft:ice>,<minecraft:snowball>,<minecraft:snowball>,rs]);
    TF.removeRecipe([<minecraft:sapling>,<minecraft:sapling>,<minecraft:reeds>,sg]);
    TF.removeRecipe([st,gi,<minecraft:iron_block>,gi]);
    //TF.removeRecipe([<bloodmagic:sigil_water>,<bloodmagic:sigil_air>,<bloodmagic:sigil_lava>,<minecraft:obsidian>]);
    TF.removeRecipe([<minecraft:iron_block>,<minecraft:gold_block>,<minecraft:obsidian>,<minecraft:cobblestone>]);
    TF.removeRecipe([tp,<minecraft:diamond>,<minecraft:ender_pearl>,<minecraft:obsidian>]);

    var gem=<bloodmagic:soul_gem>;
    TF.removeRecipe([rs,<minecraft:dye:15>,gp,<minecraft:coal>]);
    TF.removeRecipe([<minecraft:diamond_chestplate>,gem,<minecraft:iron_block>,<minecraft:obsidian>]);

    TF.removeRecipe([rs,gi,gl,<minecraft:dye:4>]);
    TF.removeRecipe([gem,<minecraft:diamond>,<minecraft:redstone_block>,<minecraft:lapis_block>]);
    TF.removeRecipe([<bloodmagic:soul_gem:1>,<minecraft:diamond>,<minecraft:gold_block>,<bloodmagic:slate:2>]);
    TF.removeRecipe([<bloodmagic:soul_gem:2>,<bloodmagic:slate:3>,<bloodmagic:blood_shard>,<bloodmagic:item_demon_crystal>]);
    TF.removeRecipe([<bloodmagic:soul_gem:3>,<minecraft:nether_star>]);

    TF.removeRecipe([<minecraft:bow>,<bloodmagic:soul_gem:1>,st,st]);
    TF.removeRecipe([gem,<minecraft:iron_pickaxe>]);
    TF.removeRecipe([gem,<minecraft:iron_sword>]);
    TF.removeRecipe([gem,<minecraft:iron_shovel>]);
    TF.removeRecipe([gem,<minecraft:iron_axe>]);
}
recipes.addShaped(<bloodmagic:altar>,Lib.Mapper({
    "A":<tconstruct:slime:3>,"B":<tconstruct:seared:6>,"C":<enderio:item_material:1>,
    "a":<enderio:item_material:41>,"b":<bloodmagic:soul_forge>,"c":<botania:runealtar>
},"AaA;BbB;CcC;"));
Agg.addRecipe(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:blaze"}}),
    [<minecraft:egg>],3000000,0xFFFF77,0xFFFF00,
    <liquid:mana>,<botania:blazeblock>,<liquid:pyrotheum>,
    <liquid:mana>,<minecraft:obsidian>,<liquid:lava>);
Melting.addEntityMelting(<entity:minecraft:blaze>,<liquid:pyrotheum>);
//Altar Clean Up
if(true){
    BA.removeRecipe(<minecraft:stone>);
    for i in 0 to 3{BA.removeRecipe(<bloodmagic:slate>.definition.makeStack(i));}
    BA.removeRecipe(<minecraft:diamond>);
    BA.removeRecipe(<minecraft:redstone_block>);
    BA.removeRecipe(<minecraft:gold_block>);
    BA.removeRecipe(<bloodmagic:blood_shard>);
    BA.removeRecipe(<minecraft:nether_star>);

    BA.removeRecipe(<minecraft:magma_cream>);
    BA.removeRecipe(<minecraft:ghast_tear>);
    BA.removeRecipe(<minecraft:obsidian>);
    BA.removeRecipe(<minecraft:lapis_block>);
    BA.removeRecipe(<minecraft:coal_block>);

    BA.removeRecipe(<minecraft:bucket>);
    BA.removeRecipe(<minecraft:ender_pearl>);
    BA.removeRecipe(<minecraft:iron_sword>);
}
mods.thermalexpansion.Refinery.addRecipe(<liquid:lifeessence>, null , <liquid:blood>*666, 400);
recipes.remove(<bloodmagic:sacrificial_dagger>);
BA.addRecipe(<bloodmagic:sacrificial_dagger>,<botania:manasteelsword>,0,144,1,0);
recipes.addShaped(<enderio:item_broken_spawner>,Lib.Mapper({"A":<enderio:block_dark_iron_bars>,"_":null},"AAA;A_A;AAA;"));
Casting.addBasinRecipe(<minecraft:mob_spawner>,<enderio:item_broken_spawner>,<liquid:lifeessence>,10000,true,3000);
Casting.addTableRecipe(<botania:spawnermover>,
    <tconstruct:large_plate>.withTag({Material: "xu_enchanted_metal"}),<liquid:lifeessence>,3000,true,3000);
BA.addRecipe(<botania:spawnerclaw>.withTag({}),<botania:spawnermover>,0,10086,1,1);
recipes.remove(<botania:spawnerclaw>);
