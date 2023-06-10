#priority 1919
//Ember banning
//mods.embers.Melter.remove(ILiquidStack outputfluid);
//mods.embers.Mixer.remove(ILiquidStack outputfluid);
//mods.embers.Stamper.remove(IItemStack output);
addRegexLogFilter("^No InductionSmelter recipe exists for.*");
mods.embers.Stamper.remove(<minecraft:iron_ingot>);
mods.embers.Stamper.remove(<minecraft:gold_ingot>);
mods.embers.Stamper.remove(<embers:ingot_lead>);
mods.embers.Stamper.remove(<embers:ingot_silver>);
mods.embers.Stamper.remove(<embers:ingot_copper>);
mods.embers.Stamper.remove(<embers:ingot_dawnstone>);
mods.embers.Stamper.remove(<embers:ingot_aluminum>);
mods.embers.Stamper.remove(<embers:ingot_bronze>);
mods.embers.Stamper.remove(<embers:ingot_electrum>);
mods.embers.Stamper.remove(<embers:ingot_nickel>);
mods.embers.Stamper.remove(<embers:ingot_tin>);
mods.embers.Stamper.remove(<embers:plate_iron>);
mods.embers.Stamper.remove(<embers:plate_gold>);
mods.embers.Stamper.remove(<embers:plate_lead>);
mods.embers.Stamper.remove(<embers:plate_silver>);
mods.embers.Stamper.remove(<embers:plate_copper>);
mods.embers.Stamper.remove(<embers:plate_dawnstone>);
mods.embers.Stamper.remove(<embers:plate_aluminum>);
mods.embers.Stamper.remove(<embers:plate_bronze>);
mods.embers.Stamper.remove(<embers:plate_electrum>);
mods.embers.Stamper.remove(<embers:plate_nickel>);
mods.embers.Stamper.remove(<embers:plate_tin>);

mods.embers.Mixer.remove(<liquid:oil_dwarf>);
mods.embers.Mixer.remove(<liquid:dawnstone>);
mods.embers.Mixer.remove(<liquid:electrum>);
mods.embers.Mixer.remove(<liquid:bronze>);

mods.embers.Melter.remove(<liquid:iron>);
mods.embers.Melter.remove(<liquid:gold>);
mods.embers.Melter.remove(<liquid:silver>);
mods.embers.Melter.remove(<liquid:copper>);
mods.embers.Melter.remove(<liquid:lead>);
mods.embers.Melter.remove(<liquid:aluminum>);
mods.embers.Melter.remove(<liquid:nickel>);
mods.embers.Melter.remove(<liquid:tin>);
mods.embers.Melter.remove(<liquid:dawnstone>);
mods.embers.Melter.remove(<liquid:bronze>);
mods.embers.Melter.remove(<liquid:electrum>);
mods.embers.Melter.remove(<liquid:alchemical_redstone>);
mods.embers.Melter.remove(<liquid:oil_soul>);


//contamination
if (true) {
    var Basic=  [] as crafttweaker.liquid.ILiquidStack[];
    var MetalA= [] as crafttweaker.liquid.ILiquidStack[];
    var MetalB= [] as crafttweaker.liquid.ILiquidStack[];
    var Bio=    [] as crafttweaker.liquid.ILiquidStack[];

    Basic+=<liquid:water>;
    Basic+=<liquid:lava>;
    MetalB+=<liquid:silver>;
    MetalB+=<liquid:gold>;
    
    MetalA+=<liquid:copper>;
    MetalA+=<liquid:iron>;
    MetalA+=<liquid:nickel>;
    MetalA+=<liquid:tin>;
    MetalA+=<liquid:zinc>;
    MetalA+=<liquid:aluminum>;
    MetalA+=<liquid:zinc>;
    MetalA+=<liquid:lead>;
    MetalA+=<liquid:invar>;
    MetalA+=<liquid:steel>;
    MetalA+=<liquid:bronze>;
    MetalA+=<liquid:alubrass>;
    MetalA+=<liquid:brass>;
    MetalA+=<liquid:constantan>;
    MetalA+=<liquid:conductive_iron>;
    
    Bio+=<liquid:syrup>;
    Bio+=<liquid:resin>;
    Bio+=<liquid:sap>;
    Bio+=<liquid:tree_oil>;
    Bio+=<liquid:creosote>;
    Bio+=<liquid:seed_oil>;
    Bio+=<liquid:refined_biofuel>;

    for i in MetalA {
        for j in MetalB {
            mods.tconstruct.Alloy.addRecipe(<liquid:construction_alloy>*7,[i*5,j*2]);
        }
    }

    for i in Basic {
        for j in MetalA {
            mods.tconstruct.Alloy.addRecipe(<liquid:stone>*13,[i*9,j*4]);
        }
        for j in MetalB {
            mods.tconstruct.Alloy.addRecipe(<liquid:stone>*13,[i*9,j*4]);
        }
        mods.tconstruct.Alloy.addRecipe(<liquid:stone>*13,[i*9,<liquid:construction_alloy>*4]);

        for j in Bio{
            mods.tconstruct.Alloy.addRecipe(i*2,[i*1,j*1]);
        }
    }

    for i in Bio {
        for j in MetalA {
            mods.tconstruct.Alloy.addRecipe(<liquid:dirt>*13,[i*11,j*2]);
        }
        for j in MetalB {
            mods.tconstruct.Alloy.addRecipe(<liquid:dirt>*13,[i*11,j*2]);
        }
        mods.tconstruct.Alloy.addRecipe(<liquid:dirt>*13,[i*11,<liquid:construction_alloy>*2]);
    }
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
        recipes.removeShapeless(i.input);
    }
}


//Disable Induction Cancelling & Smelting
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
addRegexLogFilter("^No InductionSmelter recipe exists for.*");

//Mixer


//Chapter2
//CompulsorySmelter
mods.tconstruct.Alloy.removeRecipe(<liquid:electrum>);
mods.tconstruct.Alloy.removeRecipe(<liquid:invar>);

//TemporaryBan
mods.tconstruct.Alloy.removeRecipe(<liquid:knightslime>);
mods.tconstruct.Alloy.removeRecipe(<liquid:manyullyn>);
mods.tconstruct.Alloy.removeRecipe(<liquid:signalum>);
mods.tconstruct.Alloy.removeRecipe(<liquid:enderium>);
mods.tconstruct.Alloy.removeRecipe(<liquid:lumium>);
//Misc
mods.tconstruct.Melting.removeRecipe(<liquid:blood>);
//Common Alloy
//TCon
mods.tconstruct.Alloy.removeRecipe(<liquid:energetic_alloy>);
mods.tconstruct.Alloy.removeRecipe(<liquid:vibrant_alloy>);
//Thermal
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:soul_sand>,<thermalfoundation:material:1>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:96>,<appliedenergistics2:material:5>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<minecraft:iron_ingot>,<minecraft:redstone>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<enderio:item_material>,<enderio:item_material:51>);