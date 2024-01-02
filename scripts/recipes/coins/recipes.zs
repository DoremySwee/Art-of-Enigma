#reloadable
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import scripts.recipes.coins.cdSystem.cd;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.recipes.IRecipeFunction;
import crafttweaker.recipes.IRecipeAction;
import crafttweaker.data.IData;

static tag as IData = {ench: [{lvl: 1 as short, id: 29 as short}],canCraft:true};
static coinId as string="contenttweaker:coin";
static coinNum as int = 8;

function coin(x as int)as IItemStack{
    return itemUtils.getItem(coinId~x); 
}
function map(x as int)as IItemStack[string]{
    return {
        "A":coin(x)
    };
}

function addTradeRecipe(level as int, output as IItemStack, inputPattern as string) as void {
    val thisCoin = coin(level);
    recipes.addShaped(output, Mp.read(inputPattern, {"A": thisCoin}), function(out, ins, info) {
        var player = info.player;
        if (isNull(player)) {
            return null;
        }
        return player.getCooldown(thisCoin) == 0.0f ? out : null;
    } as IRecipeFunction, function(out, info, player) {
        if (!isNull(player)) {
            player.setCooldown(thisCoin, cd);            
        }
    } as IRecipeAction);
}

//coin1
    addTradeRecipe(1, <minecraft:cobblestone>*40,"AA_;___;___;");
    addTradeRecipe(1, <minecraft:stone>*25,"AA_;___;___;");
    addTradeRecipe(1, <botania:livingrock>*15,"A_A;___;___;");
    addTradeRecipe(1, <minecraft:gravel>*40,"A__;A__;___;");
    addTradeRecipe(1, <minecraft:sand>*40,"A__;_A_;___;");
    addTradeRecipe(1, <minecraft:sapling>*64,"A__;__A;___;");
    addTradeRecipe(1, <minecraft:log>*20,"A__;___;A__;");
    addTradeRecipe(1, <minecraft:dye:15>*20,"A__;___;A__;");
    addTradeRecipe(1, <botania:blacklotus>*8,"AAA;AAA;AAA;");
//coin2
    addTradeRecipe(2, <extrautils2:compressedgravel:1>,"AA_;___;___;");
    addTradeRecipe(2, <extrautils2:compressedsand:1>,"A_A;___;___;");
    addTradeRecipe(2, <extrautils2:compressedcobblestone:1>*3,"A__;A__;___;");
    addTradeRecipe(2, <mysticalagriculture:xp_droplet>*20,"A__;_A_;___");
    addTradeRecipe(2, <botania:spark>,"___;_AA;___");
    addTradeRecipe(2, <minecraft:lava_bucket>,"A__;__A;___");
    addTradeRecipe(2, <minecraft:obsidian>,"A__;___;A__");
//coin3
    addTradeRecipe(3, <extrautils2:compressedgravel:1>*2,"AA_;___;___;");
    addTradeRecipe(3, <extrautils2:compressedsand:1>*2,"A_A;___;___;");
    addTradeRecipe(3, <extrautils2:compressedcobblestone:1>*5,"A__;A__;___;");
    addTradeRecipe(3, <mysticalagriculture:xp_droplet>*60,"A__;_A_;___");
    addTradeRecipe(3, <botania:spark>,"___;_AA;___");
    addTradeRecipe(3, <tconstruct:seared_tank>.withTag({FluidName: "lava", Amount: 4000})*4,"A__;__A;___");
    addTradeRecipe(3, <minecraft:obsidian>*16,"A__;___;A__");
    addTradeRecipe(3, <minecraft:clay>*40,"A__;___;_A_;");
//coin4
    addTradeRecipe(4, <extrautils2:compressedgravel:1>*2,"AA_;___;___;");
    addTradeRecipe(4, <extrautils2:compressedsand:1>*2,"A_A;___;___;");
    addTradeRecipe(4, <extrautils2:compressedcobblestone:1>*5,"A__;A__;___;");
    addTradeRecipe(4, <botania:spark>,"___;_AA;___");
    addTradeRecipe(4, <tconstruct:seared_tank>.withTag({FluidName: "lava", Amount: 4000})*4,"A__;__A;___");
    addTradeRecipe(4, <minecraft:obsidian>*16,"A__;___;A__");
    addTradeRecipe(4, <minecraft:clay>*40,"A__;___;_A_;");
    addTradeRecipe(4, <extrautils2:ingredients:12>*7,"A__;___;__A");
    addTradeRecipe(4, <immersiveengineering:metal:8>*27,"AA_;___;___");
//coin5
    addTradeRecipe(5, <botania:spark>,"___;_AA;___");
    addTradeRecipe(5, <appliedenergistics2:material:7>,"___;AAA;___");

    addTradeRecipe(5, <extrautils2:compressedgravel:1>*9,"AA_;___;___;");
    addTradeRecipe(5, <extrautils2:compressedsand:1>*9,"A_A;___;___;");
    
    addTradeRecipe(5, <forge:bucketfilled>.withTag({FluidName: "pyrotheum", Amount: 1000}),"AAA;AAA;AAA;");
    // T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "cryotheum", Amount: 1000}),Mp.read("A_A______;",map(5)));
    // T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "aerotheum", Amount: 1000}),Mp.read("A__A_____;",map(5)));
    // T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "petrotheum", Amount: 1000}),Mp.read("A___A____;",map(5)));
    // T.ava.shaped(<forge:bucketfilled>.withTag({FluidName: "mana", Amount: 1000}),Mp.read("A____A___;",map(5)));
    
    addTradeRecipe(5, <embers:brick_caminite>*40,"AAA;AAA;AAA;");
    addTradeRecipe(5, <tconstruct:seared_tank>.withTag({FluidName: "xpjuice", Amount: 4000})*6,"A__;A__;___");
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