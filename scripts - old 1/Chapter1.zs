import mods.botaniatweaks.Agglomeration;
//Duplication
recipes.addShapeless("AE2 wrench duplication",<appliedenergistics2:certus_quartz_wrench>,[<appliedenergistics2:certus_quartz_wrench>.reuse()]);
recipes.addShapeless("Terra Torch duplication",<botania:terrasword>.withTag({Unbreakable:1}),[<botania:terrasword>.withTag({Unbreakable:1}).reuse()]);
recipes.removeShapeless(<minecraft:crafting_table>*8, [<minecraft:crafting_table>]);
recipes.addShapeless("AE2 energycell duplication",<appliedenergistics2:creative_energy_cell>*8,[<appliedenergistics2:creative_energy_cell>]);
recipes.addShapeless("Piston duplication",<minecraft:piston>*8,[<minecraft:piston>]);
recipes.addShapeless("spiton(X) duplication",<minecraft:sticky_piston>*8,[<minecraft:sticky_piston>]);
recipes.addShapeless("lever duplication",<minecraft:lever>*8,[<minecraft:lever>]);

<appliedenergistics2:certus_quartz_wrench>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
<botania:terrasword>.withTag({Unbreakable:1}).addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
<appliedenergistics2:creative_energy_cell>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
<minecraft:piston>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
<minecraft:sticky_piston>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
<minecraft:lever>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 

//pre manapool stage
var BR=<minecraft:bedrock>;
var Li=<minecraft:sapling>;
var De=<minecraft:deadbush>;
var CS=<minecraft:cobblestone>;
var SA=<minecraft:sand>;
var GR=<minecraft:gravel>;
var Fur=<minecraft:furnace>;
var GL=<minecraft:glass>;
var p1=<botania:pool:2>;
var p2=<botania:pool>;
var lw=<botania:livingwood>;
var lr=<botania:livingrock>;
Agglomeration.addRecipe(De,[Li],1,0x008000,0x404000,BR,CS,BR,BR,GR,BR);
Agglomeration.addRecipe(Li,[De],500,0x404000,0x008000,BR,GR,BR,BR,SA,BR);
Agglomeration.addRecipe(<minecraft:stone_pickaxe>,[Li,<minecraft:flint>*2/*,De*/,<minecraft:stick>],2000,0x404000,0x80D080,BR,GR,BR,BR,SA,BR);

Agglomeration.addRecipe(De,[Li],1500,0x202020,0x808080,SA,CS,CS,Fur,GL,GL);
Agglomeration.addRecipe(De,[Li],600,0x202020,0xD0D0D0,<minecraft:stone_slab>,<minecraft:stone>,<minecraft:stone>,p1,CS,CS);





//pre crafting
mods.botania.ManaInfusion.addInfusion(<minecraft:iron_pickaxe>,<minecraft:stone_pickaxe>,1000);
Agglomeration.addRecipe(<minecraft:log>,[Li],2000,0x6060C0,0xD0D0F0,p1,p1,p1,p2,<minecraft:stone_slab>,p1);
Agglomeration.addRecipe(De,[Li],3000,0x808080,0x8080F0,Fur,p2,<minecraft:log>,<botania:opencrate:1>,p1,<minecraft:grass>);
mods.botania.ManaInfusion.addInfusion(<minecraft:dye:15>,Li,300);
recipes.remove(<minecraft:crafting_table>);
recipes.remove(<botania:opencrate:1>);
recipes.remove(<minecraft:furnace>);




//Flower Altar Alternatives
var grass=<minecraft:tallgrass:1>;
var water=<liquid:water>;
Agglomeration.addRecipe(De,[Li],1000,0x00FF00,0x0000FF,<botania:managlass>,grass,grass,water,De.withTag({display: {Name: "Surrounding a block of Water"}}),De.withTag({display: {Name: "Surrounding a block of Water"}}));
Agglomeration.addRecipe(<botania:specialflower>.withTag({type: "puredaisy"}),[Li],3000,0x80D080,0x8080FF,grass,water,<botania:petalblock>,De,<botania:managlass>,De);
Agglomeration.addRecipe(<botania:specialflower>.withTag({type: "hydroangeas"}),[Li],3000,0x80D080,0x8080FF,water,<botania:managlass>,<botania:petalblock:3>,<botania:managlass>,<botania:managlass>,<botania:managlass>);
Agglomeration.addRecipe(<botania:specialflower>.withTag({type: "endoflame"}),[Li],3000,0x80D080,0xFF8080,water,<chisel:block_charcoal>,lw,<minecraft:string>,CS,<minecraft:log>);
recipes.remove(<chisel:block_charcoal:*>);
recipes.remove(<chisel:block_charcoal1:*>);
recipes.remove(<chisel:block_charcoal2:*>);
var cc=<minecraft:coal:1>;
recipes.addShapeless("BlockCharcoalFix",<chisel:block_charcoal>,[cc,cc,cc,cc,cc,cc,cc,cc,cc]);/*
<botania:specialflower>.withTag({type: "puredaisy"}).addTooltip(format.aqua(format.italic("Agglomerate with water in the place of air in JEI, if you can't use Petal Apothecary."))); 
<botania:specialflower>.withTag({type: "hydroangeas"}).addTooltip(format.aqua(format.italic("Agglomerate with water in the place of air in JEI, if you can't use Petal Apothecary.")));
<botania:specialflower>.withTag({type: "endoflame"}).addTooltip(format.aqua(format.italic("Agglomerate with water in the place of air in JEI, if you can't use Petal Apothecary.")));
<botania:specialflower>.withTag({type: "endoflame"}).addTooltip(format.bold(format.yellow("Only 8 enfoflames per chunk is allowed.")));
<botania:specialflower>.addTooltip(format.bold(format.yellow("Automatic placement of flowers is not permitted, probably end up in disappearance of the flower.")));
game.setLocalization("en_us","description.crt.tooltip.flower.waterCraft","Agglomerate with water in the place of air in JEI. Water Block consumes.");
game.setLocalization("zh_cn","description.crt.tooltip.flower.waterCraft","由于botTweak的缺陷，凝聚板合成材料中的水方块显示成了空气。水会消耗。");
game.setLocalization("en_US","description.crt.tooltip.flower.endoRestrict","Only 8 enfoflames per chunk is allowed.");
game.setLocalization("zh_cn","description.crt.tooltip.flower.endoRestrict","一个区块最多放置8个火红莲");
game.setLocalization("en_US","description.crt.tooltip.flower.autoPlace","Automatic placement of flowers is not permitted, probably end up in disappearance of the flower.");
game.setLocalization("zh_cn","description.crt.tooltip.flower.autoPlace","请勿使用自动化装置放置花朵，花朵会消失。");*/
//<botania:specialflower>.withTag({type: "puredaisy"}).addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.flower.waterCraft")))); 
//<botania:specialflower>.withTag({type: "hydroangeas"}).addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.flower.waterCraft"))));
//<botania:specialflower>.withTag({type: "endoflame"}).addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.flower.waterCraft"))));
<botania:specialflower>.withTag({type: "endoflame"}).addTooltip(format.bold(format.yellow(game.localize("description.crt.tooltip.flower.endoRestrict"))));
//<botania:specialflower>.addTooltip(format.bold(format.yellow(game.localize("description.crt.tooltip.flower.autoPlace"))));



//pre spark
recipes.remove(<botania:spark>);
recipes.remove(<botania:runealtar>);
recipes.remove(<botania:spreader>);
recipes.addShaped("manaspreader1",<botania:spreader>,[
    [lw,lw,lw],
    [<botania:petalblock:*>,lr,<botania:managlass>],
    [lw,lw,lw]]);
Agglomeration.addRecipe(De,[<botania:specialflower>.withTag({type: "hydroangeas"})],11451,0x4040F0,0xC0C0FF,
    p1,lr,lw,<botania:runealtar>,<minecraft:stone>,<minecraft:log>);
var bsp=<botania:spark>;
mods.botania.RuneAltar.addRecipe(bsp,[<botania:specialflower>.withTag({type: "endoflame"}),<botania:petal:4>,<botania:petal>,<minecraft:flint>],19198);
recipes.addShapeless("spark duplication",bsp*8,[bsp]);
bsp.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
recipes.addShaped("spark upgrade 0",<botania:sparkupgrade>,   [[bsp,null,bsp],[null,bsp,null],[bsp,null,bsp]]);
recipes.addShaped("spark upgrade 1",<botania:sparkupgrade:1>,[[null,bsp,null],[bsp,bsp,bsp],[null,bsp,null]]);
recipes.addShaped("spark upgrade 2",<botania:sparkupgrade:2>,[[bsp,null,bsp],[null,null,null],[bsp,null,bsp]]);
recipes.addShaped("spark upgrade 3",<botania:sparkupgrade:3>,[[null,bsp,null],[bsp,null,bsp],[null,bsp,null]]);


//end Chapter
mods.botania.RuneAltar.addRecipe(<botania:specialflower>.withTag({type: "endoflame"}),[<botania:spark>,<botania:petal:14>],1);
Agglomeration.addRecipe(<botania:terraplate>,[<botania:specialflower>.withTag({type: "puredaisy"}),De,<minecraft:piston>,<minecraft:lever>,Fur,<minecraft:stone_pickaxe>,<botania:opencrate:1>,<botania:spark>],
    100000,0x000000,0x0000FF,BR,<chisel:lapis:7>,BR,BR,<botania:managlass>,BR);
recipes.remove(<minecraft:lapis_block>);
recipes.remove(<botania:pylon:1>);
recipes.remove(<botania:alfheimportal>);
//mods.chisel.Carving.removeVariation("blockLapis",<chisel:lapis:7>);
<ore:blockLapis>.remove(<chisel:lapis:7>);

//Fix-20220908
mods.botania.ManaInfusion.addInfusion(<minecraft:sapling>,<minecraft:cobblestone>,300);
furnace.remove(<minecraft:iron_nugget>);
mods.botania.RuneAltar.addRecipe(<botania:manaresource:11>*32,[<minecraft:planks>,<minecraft:stone>],1);
recipes.addShaped(<botania:twigwand>.withTag({color1: 5, color2: 13}),[
    [null,<minecraft:stick>],
    [<minecraft:stick>,<minecraft:sapling>]]);
for i in 0 to 16{
    val t=<botania:petal>.definition.makeStack(i);
    mods.botania.ManaInfusion.addInfusion(t*4,t,300);
}
//mods.botania.ManaInfusion.addInfusion(<minecraft:sapling>,<minecraft:cobblestone>,300);
recipes.addShaped(p1*4,[
    [<minecraft:stone_slab>,<botania:dye:3>,<minecraft:stone_slab>],
    [<minecraft:stone>,<minecraft:stone_slab>,<minecraft:stone>]]);
furnace.setFuel(<minecraft:dye:15>,400);

//Fix 20220910
recipes.addShapeless(<minecraft:observer>*8,[<minecraft:observer>]);
recipes.addShapeless(<botania:quartztypemana>*8,[<botania:quartztypemana>]);
<minecraft:observer>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
<botania:quartztypemana>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0")))); 
recipes.addShapeless(<botania:pool:2>*8,[<botania:pool:2>,<botania:spark>]);
recipes.addShapeless(<botania:spreader>*8,[<botania:spreader>,<botania:spark>]);
recipes.addShapeless(<appliedenergistics2:part:31>*8,[<appliedenergistics2:part:31>,<botania:spark>]);
recipes.addShapeless(<appliedenergistics2:part:220>*8,[<appliedenergistics2:part:220>,<botania:spark>]);
recipes.addShapeless(<appliedenergistics2:part:260>*8,[<appliedenergistics2:part:260>,<botania:spark>]);
recipes.addShapeless(<appliedenergistics2:part:240>*8,[<appliedenergistics2:part:240>,<botania:spark>]);
furnace.setFuel(<botania:spark>,400);
<botania:pool:2>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<botania:spreader>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<appliedenergistics2:part:31>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<appliedenergistics2:part:220>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<appliedenergistics2:part:240>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<appliedenergistics2:part:260>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 

recipes.addShapeless(<appliedenergistics2:part:221>*8,[<appliedenergistics2:part:221>,<botania:spark>]);
recipes.addShapeless(<appliedenergistics2:part:261>*8,[<appliedenergistics2:part:261>,<botania:spark>]);
recipes.addShapeless(<appliedenergistics2:part:241>*8,[<appliedenergistics2:part:241>,<botania:spark>]);
<appliedenergistics2:part:221>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<appliedenergistics2:part:241>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 
<appliedenergistics2:part:261>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark")))); 


//Fix 20221108
recipes.remove(<minecraft:stone>);

//Addition 20221129
recipes.addShaped(<betterbuilderswands:wandstone>,[
    [null,null,<botania:livingrock>],
    [null,<botania:manaresource:3>,null],
    [<botania:manaresource:3>,null,null]]);

//Tooltip 20221215
//<botania:terraplate>.addTooltip(format.red(game.localize("description.crt.tooltip.numLim")));
<botania:petal:*>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupMana"))));
<appliedenergistics2:material:7>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupMana"))));

//Tooltip 20230516
<botania:twigwand>.addTooltip(game.localize("description.crt.tooltip.twigwand"));