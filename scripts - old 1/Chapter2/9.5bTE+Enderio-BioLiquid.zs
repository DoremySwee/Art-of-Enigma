//Tech tree
//The Vat & Fractionating Still

//Craft of Mushroom soop should be ban.
//It should come from the Mooshroom (0.95% from Cocoon of Caprice).

//Without the Mooshroom AE2 can be fully unlocked, as well as the mana production.
//But Chapter3 cannot be reached.

//After Fractionating Still
//Naphtha + Refined Fuel can be obtained

//Pulped Biomass = Cast(Sawdust, SeedOil*68)
//Rich Biomass = Cast(Pulped Biomass, Tree Oil)
//Pulped Bioblend = Cast(Rich Biomass, syrup)
//Rich Bioblend*8 = Pulped Bioblend*8 + Rosin

//Rich Bioblend -> Tic Biocrude
//Dark Steel = Tar + Soularium + Obsidian

//Post the Vat
//Biocrude in_ the place of water, obtain Hootch
//Hootch + Refined Feul + Seed Oil + Energitic -> Rocket Feul

val stPl=<immersiveengineering:metal:38>;
val elct=<ore:ingotElectrum>;
val invar=<ore:ingotInvar>;
val fumo=<ore:ingotEnchantedMetal>;
val disc=<ore:record>;

recipes.addShaped(<thermalexpansion:machine:7>,[
    [<thermalfoundation:glass_alloy:3>,disc,<thermalfoundation:glass_alloy:3>],
    [fumo,<minecraft:bucket>,fumo],
    [invar,<botania:pool>,invar]]);

for i in 816 to 820{recipes.remove(<thermalfoundation:material>.definition.makeStack(i));}
mods.tconstruct.Casting.addTableRecipe(<thermalfoundation:material:816>,
    <thermalfoundation:material:800>,<liquid:seed_oil>,68,true);
val Biom3=<thermalfoundation:material:818>;
mods.tconstruct.Casting.addTableRecipe(<thermalfoundation:material:817>,
    <thermalfoundation:material:816>,<liquid:tree_oil>,68,true);
mods.tconstruct.Casting.addTableRecipe(Biom3,
    <thermalfoundation:material:817>,<liquid:syrup>,68,true);
mods.tconstruct.Melting.addRecipe(<liquid:resin>*144,<ore:logWood>);
recipes.addShaped(<thermalfoundation:material:819>*8,[
    [Biom3,Biom3,Biom3],
    [Biom3,<thermalfoundation:material:832>,Biom3],
    [Biom3,Biom3,Biom3]]);
mods.thermalexpansion.Transposer.removeFillRecipe(Biom3,<liquid:seed_oil>);
mods.thermalexpansion.Transposer.removeFillRecipe(Biom3,<liquid:plantoil>);
mods.tconstruct.Melting.addRecipe(<liquid:biocrude>*71,<thermalfoundation:material:819>);

mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:96>, <thermalfoundation:material:770>);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:160>, <thermalfoundation:material:770>);

val ds=<ore:ingotDarkSteel>;
recipes.remove(<enderio:block_vat>);
recipes.addShaped(<enderio:block_vat>,[
    [ds,<minecraft:cauldron>,ds],
    [<enderio:block_tank>,<thermalexpansion:machine:8>,<enderio:block_tank>],
    [fumo,<botania:pool>,fumo]]);

mods.immersiveengineering.Mixer.addRecipe(<liquid:potion>.withTag({Potion:"minecraft:awkward"})*300, <liquid:water>*300, [<minecraft:cooked_mutton>, <minecraft:fish>], 2048);

mods.tconstruct.Alloy.addRecipe(<liquid:rocket_fuel>*240,[<liquid:hootch>*71,<liquid:refined_fuel>*131,
    <liquid:potion>.withTag({Potion:"extrautils2:xu2.greek.fire"})*74,<liquid:seed_oil>*31,<liquid:energetic_alloy>*7]);