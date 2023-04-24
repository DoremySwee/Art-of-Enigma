#priority -114
mods.botania.Orechid.removeOre(<ore:oreMithril>);
recipes.addShapeless(<botania:floatingspecialflower>.withTag({type: "clayconia"})*2, [<botania:floatingspecialflower>.withTag({type: "clayconia"}),<appliedenergistics2:material:7>]);
recipes.removeShaped(<betterbuilderswands:wandstone>);
recipes.addShapeless(<minecraft:glowstone_dust>,[<enderio:block_holier_fog>]);

//mods.tconstruct.Casting.addTableRecipe(<minecraft:nether_wart>, <minecraft:wheat_seeds>, <liquid:soularium>, 3, true, 50);
mods.immersiveengineering.Crusher.addRecipe(<thermalfoundation:material:800>*8, <ore:logWood>, 4000);
recipes.removeShaped(<enderio:item_basic_capacitor:1>);

//20221130
recipes.remove(<extrautils2:user>);
recipes.remove(<extrautils2:miner>);
recipes.remove(<extrautils2:scanner>);
recipes.remove(<extrautils2:analogcrafter>);
recipes.remove(<extrautils2:crafter>);
recipes.remove(<extrautils2:playerchest>);

recipes.addShapeless(<botania:specialflower>.withTag({type: "exoflame"}),[<botania:specialflower>.withTag({type: "endoflame"}),<minecraft:redstone_torch>]);
recipes.addShapeless(<botania:specialflower>.withTag({type: "endoflame"}),[<botania:specialflower>.withTag({type: "exoflame"}),<minecraft:redstone_torch>]);
mods.tconstruct.Fuel.registerFuel(<liquid:pyrotheum>, 1000);
<forge:bucketfilled>.withTag({FluidName: "pyrotheum", Amount: 1000}).addTooltip(game.localize("description.crt.tooltip.SmeltryF"));
<minecraft:lava_bucket>.addTooltip(game.localize("description.crt.tooltip.SmeltryF"));

//20221218
mods.botania.RuneAltar.addRecipe(<botania:specialflower>.withTag({type: "solegnolia"}),[<botania:magnetring>,<minecraft:redstone_torch>,<botania:doubleflower1:4>,<minecraft:redstone>,<botania:manaresource>,<botania:manaresource:6>],10086);
<minecraft:pumpkin>.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0"))));
recipes.remove(<minecraft:fire_charge>);

//20221227
recipes.addShaped(<extrautils2:redstonelantern>,[
    [<minecraft:redstone>,<minecraft:stone>,<minecraft:redstone>],
    [<minecraft:stone>,<minecraft:coal>,<minecraft:stone>],
    [<minecraft:redstone>,<minecraft:comparator>,<minecraft:redstone>]
]);
recipes.remove(<extrautils2:teleporter:1>);
recipes.addShapeless(<botania:lens:1>.withTag({}),[<botania:lens>,<minecraft:sugar>]);
recipes.addShapeless(<botania:lens:2>.withTag({}),[<botania:lens>,<botania:manaresource:2>]);
recipes.addShapeless(<botania:lens:3>.withTag({}),[<botania:lens>,<extrautils2:decorativeglass:5>]);
recipes.addShapeless(<botania:lens:4>.withTag({}),[<botania:lens>,<thermalfoundation:material:136>]);