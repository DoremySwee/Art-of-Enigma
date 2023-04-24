//LiquidXP + RocketFeul + Lava + Glowstone= Blast

//Molten Redstone : Unlock at Blast temperature
//Unlock: Redstone Alloy : Energitic*114 + Iron*81 + Redstone *514
//Unlock: Molten Conductive Iron: Iron*144 + Redstone*1000
//Signalum still locked. The recipes of three alloys are completely changed

//remove molten emerald
//Molten Dark Steel + Molten Iron Alloy + LiquidXP + Lava 
//      +Soularium ->Tectonic Petrotheum

// Certus (rune altar)
// + Enchanted Books*4
// + Bucket of LiquidXP + Bucket of Liquid Redstone Alloy
// + Bucket of Platium + Bucket of Glass
// => Fluix

// Fluix + 1mana => Fluix*64
// Certus+ 1mana => Certus*64
// All kinds of AE2 facilities

//Bucket of Molten Glass (rune altar)
//  + sand + leaves + Bucket of Energitic + Glowstone + soup of Mushroom
//  + Bucket of tree oil + Bucket of syrup + disc:far
//  =>Bucket of Zephyrean Aerotheum

//LiquidXP Casting onto snowball=Blizz Powder
//Blizz Powder = 1mb Gelid Cryotheum

//Bucket of LiquidXP(rune altar)
//  + 4 buckets + spectrolus 
//  + Blocks: Redstone Alloy, Dark Steel, Platium, Electum
//  => Bucket of Primal Mana

recipes.remove(<minecraft:mushroom_stew>);
<liquid:rocket_fuel>.addTooltip(format.bold(format.yellow("Use the potion of greek flame to alloy.")));
mods.tconstruct.Alloy.addRecipe(<liquid:pyrotheum>*2000,[<liquid:xpjuice>*200,<liquid:rocket_fuel>*1000]);
mods.tconstruct.Melting.removeRecipe(<liquid:redstone>);
mods.tconstruct.Melting.addRecipe(<liquid:redstone>*144,<minecraft:redstone>,
    (<liquid:lava>.temperature+<liquid:pyrotheum>.temperature)/2);
mods.tconstruct.Alloy.addRecipe(<liquid:redstone_alloy>*144,[<liquid:iron>*81,<liquid:redstone>*514,<liquid:energetic_alloy>*114]);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material>,<minecraft:redstone>);
mods.tconstruct.Alloy.addRecipe(<liquid:redstone_alloy>*1440,[<liquid:iron>*810,<liquid:redstone>*5140,<liquid:energetic_alloy>*1140]);
mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material>,<minecraft:redstone>);
mods.tconstruct.Alloy.addRecipe(<liquid:conductive_iron>*1000,[<liquid:iron>*1000,<liquid:redstone>*144]);

mods.tconstruct.Melting.removeRecipe(<liquid:emerald>);
mods.tconstruct.Alloy.addRecipe(<liquid:petrotheum>*314,[<liquid:dark_steel>*114,<liquid:construction_alloy>*86,<liquid:xpjuice>*512,<liquid:lava>*114]);

mods.botania.RuneAltar.addRecipe(<appliedenergistics2:material:7>,[<appliedenergistics2:material>,<minecraft:enchanted_book>,<minecraft:enchanted_book>,<minecraft:enchanted_book>,<minecraft:enchanted_book>,
    <forge:bucketfilled>.withTag({FluidName: "xpjuice", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "petrotheum", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "redstone_alloy", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "platinum", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "glass", Amount: 1000})],114514);

mods.botania.RuneAltar.addRecipe(<forge:bucketfilled>.withTag({FluidName: "aerotheum", Amount: 1000}),[<minecraft:sand>,<minecraft:leaves>,
    <forge:bucketfilled>.withTag({FluidName: "syrup", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "resin", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "glowstone", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "mushroom_stew", Amount: 1000}),
    <enderio:item_alloy_nugget:1>,<minecraft:record_far>],10086);

for i in 1024 to 1028{
    recipes.remove(<thermalfoundation:material>.definition.makeStack(i));
}
mods.thermalexpansion.Transposer.removeFillRecipe(<minecraft:snowball>,<liquid:xpjuice>);
mods.thermalexpansion.Transposer.removeFillRecipe(<thermalfoundation:material:772>,<liquid:xpjuice>);
mods.thermalexpansion.Transposer.removeFillRecipe(<thermalfoundation:material:770>,<liquid:xpjuice>);
mods.thermalexpansion.Transposer.addFillRecipe(<thermalfoundation:material:2049>, <minecraft:snowball>, <liquid:xpjuice> * 1, 20);
mods.tconstruct.Melting.addRecipe(<liquid:cryotheum>*1,<thermalfoundation:material:2049>);

var wools = [] as crafttweaker.item.IIngredient[];
for i in 0 to 16{
    wools+=<minecraft:wool>.definition.makeStack(i);
}
mods.botania.RuneAltar.addRecipe(<botania:specialflower>.withTag({type: "spectrolus"}),wools,2000);

mods.botania.RuneAltar.addRecipe(<forge:bucketfilled>.withTag({FluidName: "mana", Amount: 1000}),[
    <forge:bucketfilled>.withTag({FluidName: "xpjuice", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "pyrotheum", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "petrotheum", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "aerotheum", Amount: 1000}),
    <forge:bucketfilled>.withTag({FluidName: "cryotheum", Amount: 1000}),
    <enderio:block_alloy:3>,<enderio:block_alloy:4>,<enderio:block_alloy:6>,
    <thermalfoundation:storage:6>, <thermalfoundation:storage:1>,
    <botania:specialflower>.withTag({type: "spectrolus"})],1919810);