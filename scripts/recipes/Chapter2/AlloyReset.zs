#loader crafttweaker reloadableevents
#priority 1000
import scripts.recipes.libs.Transcript as T;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

//T.test();
/*
addRegexLogFilter("^No InductionSmelter recipe exists for.*");
//Embers
if(true){
    var stamper = [
        <minecraft:iron_ingot>,
        <minecraft:gold_ingot>,
        <embers:ingot_lead>,
        <embers:ingot_silver>,
        <embers:ingot_copper>,
        <embers:ingot_dawnstone>,
        <embers:ingot_aluminum>,
        <embers:ingot_bronze>,
        <embers:ingot_electrum>,
        <embers:ingot_nickel>,
        <embers:ingot_tin>,
        <embers:plate_iron>,
        <embers:plate_gold>,
        <embers:plate_lead>,
        <embers:plate_silver>,
        <embers:plate_copper>,
        <embers:plate_dawnstone>,
        <embers:plate_aluminum>,
        <embers:plate_bronze>,
        <embers:plate_electrum>,
        <embers:plate_nickel>,
        <embers:plate_tin>
    ] as IItemStack[];
    var mixer = [
        <liquid:oil_dwarf>,
        <liquid:dawnstone>,
        <liquid:electrum>,
        <liquid:bronze>
    ] as ILiquidStack[];
    var melter = [
        <liquid:iron>,
        <liquid:gold>,
        <liquid:silver>,
        <liquid:copper>,
        <liquid:lead>,
        <liquid:aluminum>,
        <liquid:nickel>,
        <liquid:tin>,
        <liquid:dawnstone>,
        <liquid:bronze>,
        <liquid:electrum>,
        <liquid:alchemical_redstone>,
        <liquid:oil_soul>    
    ] as ILiquidStack[];
    for item in stamper{
        mods.embers.Stamper.remove(item);
    }
    for liquid in mixer{
        mods.embers.Mixer.remove(liquid);
    }
    for liquid in melter{
        mods.embers.Melter.remove(liquid);
    }
}

//Tic contamination
if (true) {
    var Basic = [ <liquid:water>, <liquid:lava> ] as crafttweaker.liquid.ILiquidStack[];
    var MetalB = [ <liquid:silver>, <liquid:gold> ] as crafttweaker.liquid.ILiquidStack[];
    var MetalA = [ 
        <liquid:copper>,
        <liquid:iron>,
        <liquid:nickel>,
        <liquid:tin>,
        <liquid:zinc>,
        <liquid:aluminum>,
        <liquid:zinc>,
        <liquid:lead>,
        <liquid:invar>,
        <liquid:steel>,
        <liquid:bronze>,
        <liquid:alubrass>,
        <liquid:brass>,
        <liquid:constantan>,
        <liquid:conductive_iron>
    ] as crafttweaker.liquid.ILiquidStack[];
    var Bio = [
        <liquid:syrup>,
        <liquid:resin>,
        <liquid:sap>,
        <liquid:tree_oil>,
        <liquid:creosote>,
        <liquid:seed_oil>,
        <liquid:refined_biofuel>
    ] as crafttweaker.liquid.ILiquidStack[];

    for i in MetalA {
        for j in MetalB {
            //T.test();
            //T.tic.alloy(<liquid:construction_alloy>*7,[i*5,j*2]);
            //mods.tconstruct.Alloy.addRecipe(<liquid:construction_alloy>*7,[i*5,j*2]);
            //print(i.name);
            //print(j.name);
        }
    }/*
    for i in Basic {
        for j in MetalA {
            T.tic.alloy(<liquid:stone>*13,[i*9,j*4]);
        }
        for j in MetalB {
            T.tic.alloy(<liquid:stone>*13,[i*9,j*4]);
        }
        T.tic.alloy(<liquid:stone>*13,[i*9,<liquid:construction_alloy>*4]);
        for j in Bio{
            T.tic.alloy(i*2,[i*1,j*1]);
        }
    }
    for i in Bio {
        for j in MetalA {
            T.tic.alloy(<liquid:dirt>*13,[i*11,j*2]);
        }
        for j in MetalB {
            T.tic.alloy(<liquid:dirt>*13,[i*11,j*2]);
        }
        T.tic.alloy(<liquid:dirt>*13,[i*11,<liquid:construction_alloy>*2]);
    }*
}

//dust banning
for i in furnace.all{
    var f=false;
    for j in i.input.ores{
        if(j.name.toLowerCase().indexOf("dust")>-1){
            f=true;
        }
        if(f){
            break;
        }
    }
    if(f){
        furnace.remove(i.output,i.input);
        recipes.remove(i.input);
    }
}

//Disable Induction Destruction & Smelting
//Disable Arc Furnace
for i in oreDict.entries{
    var t as string=i.name.toLowerCase();
    if(t.indexOf("gear")>-1 || t.indexOf("plate")>-1){
        mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:sand>,i.firstItem);
    }
    if(t.indexOf("ore")>-1){
        mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:sand>,i.firstItem);
        mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:865>,i.firstItem);
        mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:866>,i.firstItem);
    }
    if(t.indexOf("ingot")>-1){
        mods.immersiveengineering.ArcFurnace.removeRecipe(i.firstItem);
    }
}

//leave for later chapters
mods.tconstruct.Alloy.removeRecipe(<liquid:knightslime>);
mods.tconstruct.Alloy.removeRecipe(<liquid:manyullyn>);
mods.tconstruct.Alloy.removeRecipe(<liquid:signalum>);
mods.tconstruct.Alloy.removeRecipe(<liquid:enderium>);
mods.tconstruct.Alloy.removeRecipe(<liquid:lumium>);
mods.tconstruct.Melting.removeRecipe(<liquid:blood>);

//TiC Smelter shouldn't do these alloy!
mods.tconstruct.Alloy.removeRecipe(<liquid:electrum>);
mods.tconstruct.Alloy.removeRecipe(<liquid:invar>);

//Use EIO alloy for EIO metals!
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material>,<minecraft:redstone>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:soul_sand>,<thermalfoundation:material:1>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:96>,<appliedenergistics2:material:5>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:iron_ingot>,<minecraft:redstone>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<enderio:item_material>,<enderio:item_material:51>);
mods.tconstruct.Alloy.removeRecipe(<liquid:energetic_alloy>);
mods.tconstruct.Alloy.removeRecipe(<liquid:vibrant_alloy>);

//Immersive
mods.immersiveengineering.AlloySmelter.removeRecipe(<immersiveengineering:metal:6>);
mods.immersiveengineering.AlloySmelter.removeRecipe(<immersiveengineering:metal:7>);
mods.immersiveengineering.AlloySmelter.removeRecipe(<thermalfoundation:material:162>);
mods.immersiveengineering.AlloySmelter.addRecipe(<thermalfoundation:material:162>*3,<ore:dustNickel>,<ore:dustIron>*2,1800);
*/