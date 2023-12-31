#reloadable
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
static tag as IData = {ench: [{lvl: 1 as short, id: 29 as short}],canCraft:true};
static coinId as string="contenttweaker:coin";
static coinNum as int = 8;
function coin(x as int)as IItemStack{
    return itemUtils.getItem(coinId~x); 
}
function map(x as int)as IItemStack[string]{
    return {
        "A":coin(x).withTag(tag),
        "B":coin(x)
    };
}
//coin1
    recipes.addShaped(<minecraft:cobblestone>*40,Mp.read("AB_;___;___;",map(1)));
    recipes.addShaped(<minecraft:stone>*25,Mp.read("BA_;___;___;",map(1)));
    recipes.addShaped(<botania:livingrock>*15,Mp.read("B_A;___;___;",map(1)));
    recipes.addShaped(<minecraft:gravel>*40,Mp.read("B__;A__;___;",map(1)));
    recipes.addShaped(<minecraft:sand>*40,Mp.read("B__;_A_;___;",map(1)));
    recipes.addShaped(<minecraft:sapling>*64,Mp.read("B__;__A;___;",map(1)));
    recipes.addShaped(<minecraft:log>*20,Mp.read("B__;___;A__;",map(1)));
    recipes.addShaped(<minecraft:dye:15>*20,Mp.read("B__;___;A__;",map(1)));
    recipes.addShaped(<botania:blacklotus>*8,Mp.read("BBB;BAB;BBB;",map(1)));
//coin2
    recipes.addShaped(<extrautils2:compressedgravel:1>,Mp.read("AB_;___;___;",map(2)));
    recipes.addShaped(<extrautils2:compressedsand:1>,Mp.read("A_B;___;___;",map(2)));
    recipes.addShaped(<extrautils2:compressedcobblestone:1>*3,Mp.read("A__;B__;___;",map(2)));
    recipes.addShaped(<mysticalagriculture:xp_droplet>*20,Mp.read("A__;_B_;___",map(2)));
    recipes.addShaped(<botania:spark>,Mp.read("___;_BB;___",map(2)));
    recipes.addShaped(<minecraft:lava_bucket>,Mp.read("A__;__B;___",map(2)));
    recipes.addShaped(<minecraft:obsidian>,Mp.read("A__;___;B__",map(2)));
//coin3
    recipes.addShaped(<extrautils2:compressedgravel:1>*2,Mp.read("AB_;___;___;",map(3)));
    recipes.addShaped(<extrautils2:compressedsand:1>*2,Mp.read("A_B;___;___;",map(3)));
    recipes.addShaped(<extrautils2:compressedcobblestone:1>*5,Mp.read("A__;B__;___;",map(3)));
    recipes.addShaped(<mysticalagriculture:xp_droplet>*60,Mp.read("A__;_B_;___",map(3)));
    recipes.addShaped(<botania:spark>,Mp.read("___;_BB;___",map(3)));
    recipes.addShaped(<tconstruct:seared_tank>.withTag({FluidName: "lava", Amount: 4000})*4,Mp.read("A__;__B;___",map(3)));
    recipes.addShaped(<minecraft:obsidian>*16,Mp.read("A__;___;B__",map(3)));
    recipes.addShaped(<minecraft:clay>*40,Mp.read("A__;___;_B_;",map(3)));
//coin4
    recipes.addShaped(<extrautils2:compressedgravel:1>*2,Mp.read("AB_;___;___;",map(4)));
    recipes.addShaped(<extrautils2:compressedsand:1>*2,Mp.read("A_B;___;___;",map(4)));
    recipes.addShaped(<extrautils2:compressedcobblestone:1>*5,Mp.read("A__;B__;___;",map(4)));
    recipes.addShaped(<botania:spark>,Mp.read("___;_BB;___",map(4)));
    recipes.addShaped(<tconstruct:seared_tank>.withTag({FluidName: "lava", Amount: 4000})*4,Mp.read("A__;__B;___",map(4)));
    recipes.addShaped(<minecraft:obsidian>*16,Mp.read("A__;___;B__",map(4)));
    recipes.addShaped(<minecraft:clay>*40,Mp.read("A__;___;_B_;",map(4)));
    recipes.addShaped(<extrautils2:ingredients:12>*7,Mp.read("A__;___;__B",map(4)));
    recipes.addShaped(<immersiveengineering:metal:8>*27,Mp.read("BA_;___;___",map(4)));
//coin5
    recipes.addShaped(<botania:spark>,Mp.read("___;_BB;___",map(5)));
    recipes.addShaped(<appliedenergistics2:material:7>,Mp.read("___;BBB;___",map(5)));

    recipes.addShaped(<extrautils2:compressedgravel:1>*9,Mp.read("AB_;___;___;",map(5)));
    recipes.addShaped(<extrautils2:compressedsand:1>*9,Mp.read("A_B;___;___;",map(5)));
    
    recipes.addShaped(<forge:bucketfilled>.withTag({FluidName: "pyrotheum", Amount: 1000}),Mp.read("ABB;BBB;BBB;",map(5)));
    T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "cryotheum", Amount: 1000}),Mp.read("A_B______;",map(5)));
    T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "aerotheum", Amount: 1000}),Mp.read("A__B_____;",map(5)));
    T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "petrotheum", Amount: 1000}),Mp.read("A___B____;",map(5)));
    T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "mana", Amount: 1000}),Mp.read("A____B___;",map(5)));
    
    recipes.addShaped(<embers:brick_caminite>*40,Mp.read("BAB;BBB;BBB;",map(5)));
    recipes.addShaped(<tconstruct:seared_tank>.withTag({FluidName: "xpjuice", Amount: 4000})*6,Mp.read("A__;B__;___",map(5)));
//TODO: coin6~8
//craft coins
    recipes.addShapeless(<contenttweaker:coin1>*2,[<botania:livingrock0slab>,M.reuse(<tconstruct:pattern>.withTag({PartType: "tconstruct:pan_head"}))]);
    T.ae2.inscribe(<contenttweaker:coin1>*8,[<botania:livingrock>,<tconstruct:cast>.withTag({PartType: "tconstruct:pan_head"}),<tconstruct:cast>],false);
    recipes.addShaped(<contenttweaker:coin2>*8,Mp.read("A_A;_A_;A_A;",{"A":<mysticalagriculture:manasteel_essence>}));
    T.ae2.inscribe(<contenttweaker:coin2>,[<contenttweaker:coin1>,<botania:manaresource>,<botania:manaresource:2>]);
    T.tic.casting(<contenttweaker:coin3>,<contenttweaker:coin2>,<liquid:xu_enchanted_metal>*144);
    T.tic.casting(<contenttweaker:coin4>*8,<ore:record>,<liquid:dark_steel>*144);
    T.de.fuse(<contenttweaker:coin5>*8,<appliedenergistics2:material:37>,[
        <appliedenergistics2:material:12>,
        <appliedenergistics2:paint_ball:30>,
        <embers:shard_ember>,
        <avaritia:resource:7>,
        <contenttweaker:shard_ordo>,
        <tconstruct:shard>.withTag({Material: "xu_enchanted_metal"}),
        <appliedenergistics2:material:16>,
        <thermalfoundation:material:264>,
        <botania:specialflower>.withTag({type: "spectrolus"})
    ],400000);