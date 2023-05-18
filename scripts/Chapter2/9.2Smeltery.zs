import mods.botaniatweaks.Agglomeration;
//grass
for i in vanilla.seeds.seeds {
    vanilla.seeds.removeSeed(i.stack as crafttweaker.item.IIngredient);
    vanilla.seeds.removeSeed(i.stack);
	print("Item: " ~ i.stack.displayName ~ " || Chance: " ~ i.percent ~ "%");
}
vanilla.seeds.removeSeed(<minecraft:wheat_seeds>);
vanilla.seeds.addSeed(<minecraft:carrot> % 1);
vanilla.seeds.addSeed(<minecraft:potato> % 1);
vanilla.seeds.addSeed(<minecraft:pumpkin_seeds> % 1);
vanilla.seeds.addSeed(<minecraft:melon_seeds> % 1);
vanilla.seeds.addSeed(<minecraft:wheat_seeds> % 1);
vanilla.seeds.addSeed(<minecraft:melon_seeds> % 1);
vanilla.seeds.addSeed(<minecraft:wheat_seeds> % 1);
vanilla.seeds.addSeed(<minecraft:beetroot_seeds> % 1);
vanilla.seeds.addSeed(<immersiveengineering:seed> % 1);

//Pumpkin
recipes.addShapeless(<minecraft:pumpkin>, [<minecraft:wheat>,<minecraft:pumpkin_seeds>,<minecraft:dye:15>]);

//cocoon
var nr=<minecraft:netherrack>;
Agglomeration.addRecipe(<minecraft:rotten_flesh>,[<minecraft:fish>],1,0x000033,0x330000,
    nr,nr,nr,nr,nr,nr);
Agglomeration.addRecipe(<minecraft:rotten_flesh>,[<minecraft:fish:1>],1,0x000033,0x330000,
    nr,nr,nr,nr,nr,nr);
Agglomeration.addRecipe(<minecraft:rotten_flesh>,[<minecraft:beef>],1,0x000033,0x330000,
    nr,nr,nr,nr,nr,nr);
Agglomeration.addRecipe(<minecraft:rotten_flesh>,[<minecraft:mutton>],1,0x000033,0x330000,
    nr,nr,nr,nr,nr,nr);
Agglomeration.addRecipe(<minecraft:rotten_flesh>,[<minecraft:porkchop>],1,0x000033,0x330000,
    nr,nr,nr,nr,nr,nr);
Agglomeration.addRecipe(<minecraft:rotten_flesh>,[<minecraft:chicken>],1,0x000033,0x330000,
    nr,nr,nr,nr,nr,nr);
mods.appliedenergistics2.Inscriber.addRecipe(<minecraft:bone>,<minecraft:dye:15>,false,<minecraft:dye:15>,<minecraft:dye:15>);
//addRegexLogFilter("^Recipe name [cacoon-fix].*");
recipes.addShaped(<botania:cocoon>,[
    [<minecraft:string>,<minecraft:string>,<minecraft:string>],
    [<botania:manaresource:22>,<botania:felpumpkin>,<botania:manaresource:22>],
    [<minecraft:string>,null,<minecraft:string>]]);
recipes.addShaped(<botania:cocoon>*4,[
    [<minecraft:string>,<minecraft:string>,<minecraft:string>],
    [<botania:manaresource:22>,<botania:felpumpkin>,<botania:manaresource:22>],
    [<minecraft:string>,<minecraft:iron_ingot>,<minecraft:string>]]);
recipes.addShaped(<botania:cocoon>*16,[
    [<minecraft:string>,<minecraft:string>,<minecraft:string>],
    [<botania:manaresource:22>,<botania:felpumpkin>,<botania:manaresource:22>],
    [<minecraft:string>,<ore:ingotElectrum>,<minecraft:string>]]);

//Better Snad
var cs=<minecraft:cobblestone>;
var gr=<minecraft:gravel>;
var sd=<minecraft:sand>;
mods.appliedenergistics2.Inscriber.addRecipe(sd,gr,true,<minecraft:iron_ingot>,<minecraft:iron_ingot>);
mods.appliedenergistics2.Inscriber.addRecipe(gr,cs,true,<minecraft:iron_ingot>,<minecraft:iron_ingot>);

//sear&casting
var seI=<tconstruct:materials>;
mods.tconstruct.Casting.removeBasinRecipe(<tconstruct:seared>);
mods.tconstruct.Casting.removeBasinRecipe(<tconstruct:seared:1>);
recipes.removeShaped(<tconstruct:seared:3>);
recipes.addShaped(<tconstruct:seared:3>,[[seI,null,seI],[null,seI,null],[seI,null,seI]]);

//slime ball
var slb=<minecraft:slime_ball>;
mods.tconstruct.Casting.addTableRecipe(slb, <minecraft:dye:10>, <liquid:milk>, 975, true, 1200);
mods.tconstruct.Casting.addTableRecipe(slb, <botania:dye:5>, <liquid:milk>, 1753, true, 1200);

//CraftingTable
var vlg=<minecraft:log>;
recipes.addShaped(<minecraft:crafting_table>,[[vlg,seI,vlg],[slb,<botania:opencrate:1>,slb],[vlg,slb,vlg]]);

//Smeltery controller
var fcont=<tconstruct:seared_furnace_controller>;
recipes.removeShaped(fcont);
recipes.removeShaped(<tconstruct:smeltery_controller>);
recipes.addShaped(<tconstruct:smeltery_controller>,[[seI,seI,seI],[fcont,<tconstruct:materials:50>.withTag({display: {Lore: ["Use it to Craft the Smeltery Controller"], Name: "Brain of Smeltery"}}),fcont],[seI,seI,seI]]);
recipes.addShaped(<tconstruct:smeltery_controller>,[[seI,seI,seI],[fcont,<tconstruct:materials:50>.withTag({forSmeltry: true}),fcont],[seI,seI,seI]]);
<tconstruct:materials:50>.withTag({forSmeltry: 1}).displayName=game.localize("crt.smeltry_head.name");
<tconstruct:materials:50>.withTag({forSmeltry: 1}).addTooltip(game.localize("crt.smeltry_head.tip"));

//orechid
mods.tconstruct.Casting.addTableRecipe(<botania:specialflower>.withTag({type: "thermalily"}),<botania:specialflower>.withTag({type: "endoflame"}),<liquid:obsidian>,514,true,1200);
mods.tconstruct.Casting.addTableRecipe(<botania:specialflower>.withTag({type: "orechid"}),<botania:specialflower>.withTag({type: "thermalily"}),<liquid:iron>,114,true,1200);
mods.appliedenergistics2.Inscriber.addRecipe(<botania:specialflower>.withTag({type: "hopperhock"}),<botania:specialflower>.withTag({type: "orechid"}),false,<minecraft:hopper>,<minecraft:iron_ingot>);
mods.appliedenergistics2.Inscriber.addRecipe(<botania:lens:18>,<botania:lens:1>,false,<botania:pistonrelay>,<botania:pistonrelay>);

//fumo
mods.tconstruct.Alloy.addRecipe(<liquid:xu_enchanted_metal>*39,[
        <liquid:bronze>*10,<liquid:constantan>*10,<liquid:alubrass>*10,
        <liquid:gold>*3,<liquid:silver>*3,<liquid:construction_alloy>*4,<liquid:obsidian>*3
]);
mods.tconstruct.Alloy.addRecipe(<liquid:xu_enchanted_metal>*195,[
        <liquid:bronze>*50,<liquid:constantan>*50,<liquid:alubrass>*50,
        <liquid:gold>*15,<liquid:silver>*15,<liquid:construction_alloy>*20,<liquid:obsidian>*15
]);

//AE2 Liquid Management
mods.tconstruct.Casting.addTableRecipe(<appliedenergistics2:part:241>,<appliedenergistics2:part:240>,<liquid:water>,1,true,10);
mods.tconstruct.Casting.addTableRecipe(<appliedenergistics2:part:261>,<appliedenergistics2:part:260>,<liquid:water>,1,true,10);
mods.tconstruct.Casting.addTableRecipe(<appliedenergistics2:part:221>,<appliedenergistics2:part:220>,<liquid:water>,1,true,10);