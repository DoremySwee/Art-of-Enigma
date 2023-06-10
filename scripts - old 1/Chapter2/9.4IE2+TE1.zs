recipes.removeShaped(<immersiveengineering:metal_device1:6>);
val stPl=<immersiveengineering:metal:38>;
val elct=<ore:ingotElectrum>;
val invar=<ore:ingotInvar>;
val disc=<ore:record>;
val fumo=<ore:ingotEnchantedMetal>;
recipes.addShaped(<thermalexpansion:machine:3>,[
    [disc,invar,disc],
    [<minecraft:furnace>,<botania:rfgenerator>,<minecraft:furnace>],
    [fumo,<botania:pool>,fumo]]);
recipes.addShaped(<immersiveengineering:metal_device1:6>, [
    [stPl,elct,stPl],
    [null,<thermalfoundation:material:288>,null],
    [stPl,elct,stPl]]);
recipes.addShaped(<thermalexpansion:machine:8>,[
    [elct,<forge:bucketfilled>.withTag({FluidName: "biodiesel", Amount: 1000}),elct],
    [invar,<thermalexpansion:machine:3>,invar],
    [fumo,<botania:pool>,fumo]]);
