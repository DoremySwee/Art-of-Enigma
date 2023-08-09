import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

var dups = [
    <botania:terrasword>.withTag({Unbreakable:1}),
    <appliedenergistics2:certus_quartz_wrench>,
    <appliedenergistics2:creative_energy_cell>,
    <minecraft:sticky_piston>,
    <botania:quartztypemana>,
    <minecraft:observer>,
    <minecraft:piston>,
    <minecraft:lever>,
    <botania:spark>,
] as IItemStack[];
for item in dups{
    M.dup(item);
}
var dups2 = [
    <botania:pool:2>,
    <botania:spreader>,
    <appliedenergistics2:part:31>,
    <appliedenergistics2:part:220>,
    <appliedenergistics2:part:240>,
    <appliedenergistics2:part:260>,
    <appliedenergistics2:part:221>,
    <appliedenergistics2:part:241>,
    <appliedenergistics2:part:261>
] as IItemStack[];
for item in dups2{
    M.dupSpark(item);
}

//pre manapool
var BR=<minecraft:bedrock>;
var Li=<minecraft:sapling>;
var De=<minecraft:deadbush>;
var CS=<minecraft:cobblestone>;
var St=<minecraft:stone>;
var slab = <minecraft:stone_slab>;
var SA=<minecraft:sand>;
var GR=<minecraft:gravel>;
var F =<minecraft:furnace>;
var GL=<minecraft:glass>;
var P1=<botania:pool:2>;
var P2=<botania:pool>;
var LW=<botania:livingwood>;
var LR=<botania:livingrock>;
var MG=<botania:managlass>;
Agg.addRecipe(De, [Li], 1,   0x008000, 0x404000,  BR,CS,BR,  BR,GR,BR);
Agg.addRecipe(Li, [De], 500, 0x404000, 0x008000,  BR,GR,BR,  BR,SA,BR);
Agg.addRecipe(<minecraft:stone_pickaxe>,
    [Li,<minecraft:flint>*2,<minecraft:stick>],
    2000,0x404000,0x80D080,  BR,GR,BR,  BR,SA,BR
);
Agg.addRecipe(De, [Li],1500,0x202020,0x808080, SA,CS,CS, F,GL,GL);
Agg.addRecipe(De, [Li],600, 0x202020,0xD0D0D0, slab,St,St, P1,CS,CS);

//pre crafting crate
T.bot.infusion(<minecraft:iron_pickaxe>,<minecraft:stone_pickaxe>,1000);
Agg.addRecipe(<minecraft:log>, [Li], 2000, 0x6060C0, 0xD0D0F0, P1,P1,P1, P2,slab,P1);
Agg.addRecipe(De, [Li], 3000, 0x808080, 0x8080F0,
    F, P2, <minecraft:planks>,   <botania:opencrate:1>, P1, <minecraft:grass>
);
T.bot.infusion(<minecraft:dye:15>,Li,200);
recipes.remove(<minecraft:crafting_table>);
recipes.remove(<botania:opencrate:1>);
recipes.remove(<minecraft:furnace>);

//flowers
var grass=<minecraft:tallgrass:1>;
var water=<liquid:water>;
var CC=<minecraft:coal:1>;
var CCB=<chisel:block_charcoal>;
Agg.addRecipe(De, [Li], 1000, 0x00FF00, 0x0000FF, 
    MG, grass, grass,  water, De, De
);
Agg.addRecipe(M.flower("puredaisy"), [Li], 3000, 0x80D080, 0x8080FF,
    grass, water, <botania:petalblock>,  De, MG, De
);
Agg.addRecipe(M.flower("hydroangeas"), [Li], 3000, 0x80D080, 0x8080FF,
    water, MG, <botania:petalblock:3>,  MG, MG, MG
);
Agg.addRecipe(M.flower("endoflame"), [Li], 3000, 0x80D080, 0xFF8080,
    water, CCB, LW,  
    <minecraft:string>,CS,<minecraft:log>
);
recipes.remove(<chisel:block_charcoal:*>);
recipes.remove(<chisel:block_charcoal1:*>);
recipes.remove(<chisel:block_charcoal2:*>);
recipes.addShapeless(CCB,[CC,CC,CC,CC,CC,CC,CC,CC,CC]);

//spark
var Sp = <botania:spark>;
recipes.addShaped(<botania:spreader>,
    Mp.read("AAA;BCD;AAA;",{
        "A":LW, "B":<botania:petalblock:*>, "C":LR, "D":MG
    }as IIngredient[string])
);
Agg.addRecipe(De, [M.flower("hydroangeas")], 10000, 0x4040F0, 0xC0C0FF,
    P1, LR, LW, <botania:runealtar>, St, <minecraft:log>
);
T.bot.rune(Sp,[M.flower("endoflame"),<botania:petal:4>,<botania:petal>,<minecraft:flint>],20000);
for i in 0 to 4{
    var patterns = ["A_A;_A_;A_A;","_A_;AAA;_A_","A_A;___;A_A;","_A_;A_A;_A_;"] as string[];
    recipes.addShaped(<botania:sparkupgrade>.definition.makeStack(i),Mp.read(patterns[i],{"A":Sp}));
}

//end chapter
T.bot.rune(M.flower("endoflame"),[Sp,<botania:petal:14>],1);
Agg.addRecipe(<botania:terraplate>,[
    M.flower("puredaisy"),
    De,<minecraft:piston>,<minecraft:lever>,
    F,<minecraft:stone_pickaxe>,<botania:opencrate:1>,Sp],
    10000, 0x000000, 0x0000FF,
    BR,<chisel:lapis:7>,BR,
    BR,MG,BR
);
recipes.remove(<minecraft:lapis_block>);
<ore:blockLapis>.remove(<chisel:lapis:7>);

//fixes
furnace.remove(<minecraft:iron_nugget>);
T.bot.rune(<botania:manaresource:11>*32,[<minecraft:planks>,<minecraft:stone>],1);
recipes.addShaped(<botania:twigwand>.withTag({color1: 5, color2: 13}),[
    [null,<minecraft:stick>],
    [<minecraft:stick>,<minecraft:sapling>]]);
for i in 0 to 16{
    M.dupMana(<botania:petal>.definition.makeStack(i));
}
recipes.addShaped(P1*4,[
    [slab,<botania:dye:3>,slab],
    [St,slab,St]
]);
furnace.setFuel(<minecraft:dye:15>,400);
furnace.setFuel(Sp,800);
recipes.remove(St);
recipes.remove(<betterbuilderswands:wandstone>);
recipes.addShaped(<betterbuilderswands:wandstone>,Mp.read("__R;_S_;S__;",{"R":LR,"S":<botania:manaresource:3>}));
<botania:twigwand>.addTooltip(game.localize("description.crt.tooltip.twigwand"));

//These scrips probably should be moved to other files...
recipes.remove(<botania:pylon:1>);
recipes.remove(<botania:alfheimportal>);