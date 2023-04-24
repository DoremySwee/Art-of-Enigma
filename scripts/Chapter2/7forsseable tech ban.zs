#priority 114514
var d = [] as crafttweaker.item.IIngredient[];
var e = [] as crafttweaker.item.IItemStack[];

//immersiveengineering
d+=<immersiveengineering:metal_decoration0:7>;

//Embers
d+=<embers:mech_core>;
d+=<embers:blend_caminite>;
d+=<embers:item_pipe>;
d+=<embers:tinker_hammer>;
d+=<embers:stamper>;
d+=<embers:stamper_base>;
d+=<embers:mixer>;
d+=<embers:block_furnace>;

//Avaritia
d+=<avaritia:compressed_crafting_table>;
d+=<avaritia:extreme_crafting_table>;
e+=<avaritia:neutron_collector>;
e+=<avaritia:neutronium_compressor>;
e+=<avaritia:skullfire_sword>;

//Botania
d+=<botania:altar>;
d+=<botania:terraplate>;
d+=<botania:brewery>;
d+=<botania:manabomb>;
d+=<botania:alchemycatalyst>;
d+=<botania:conjurationcatalyst>;
d+=<botania:livingwood:5>;
d+=<botania:alfheimportal>;
d+=<botania:pylon:1>;
d+=<botania:pylon:2>;
for i in 0 to 16{
    mods.botania.RuneAltar.removeRecipe(<botania:rune>.definition.makeStack(i));
}
for i in 1 to 5{
    d+=<botania:lens>.definition.makeStack(i);
}
d+=<botania:lens:8>;
d+=<botania:lens:11>;
d+=<botania:lens:14>;
d+=<botania:lens:15>;
//wools
for i in 1 to 16{
    recipes.removeShapeless(<minecraft:wool>.definition.makeStack(i));
}


//BloodMagic
d+=<bloodmagic:soul_forge>;
d+=<bloodmagic:altar>;

//AE2
d+=<appliedenergistics2:controller>;
d+=<appliedenergistics2:part:180>;
//d+=<appliedenergistics2:grindstone>;

//ExU
d+=<extrautils2:glasscutter>;
d+=<extrautils2:resonator>;
d+=<extrautils2:machine>;
d+=<extrautils2:ingredients:1>;
d+=<extrautils2:decorativesolid:2>;

//CC
d+=<calculator:powercube>;
d+=<calculator:calculatorscreen>;
d+=<calculator:calculatorassembly>;
d+=<calculator:dynamiccalculator>;

//DE
d+=<draconicevolution:draconic_core>;

//Thermal
d+=<thermalexpansion:frame>;
d+=<thermalexpansion:frame:64>;
for i in 22 to 28 {
    d+=(<thermalfoundation:material>.definition.makeStack(i));
}
for i in 256 to 265 {
    var temp=<thermalfoundation:material>.definition.makeStack(i);
    d+=temp;
    mods.tconstruct.Casting.removeTableRecipe(temp);
}
for i in 288 to 295 {
    var temp=<thermalfoundation:material>.definition.makeStack(i);
    d+=temp;
    mods.tconstruct.Casting.removeTableRecipe(temp);
}
for i in 512 to 516 {
    d+=(<thermalfoundation:material>.definition.makeStack(i));
}
for i in 0 to 4{
    d+=(<thermalfoundation:upgrade>.definition.makeStack(i));
}
d+=<thermaldynamics:duct_32:*>;
d+=<thermalexpansion:augment:337>;
for i in 0 to 16{
    d+=<thermalexpansion:machine>.definition.makeStack(i);
}

//EnderIO
d+=<enderio:item_basic_capacitor>;
d+=<enderio:item_material:71>;
d+=<enderio:item_material>;
for i in 9 to 14{
    var temp=<enderio:item_material>.definition.makeStack(i);
    d+=temp;
    mods.tconstruct.Casting.removeTableRecipe(temp);
}
d+=<enderio:item_me_conduit>;
d+=<enderio:item_item_conduit>;

//Endup
for i in d {
    recipes.removeShaped(i);
    recipes.removeShapeless(i);
}
for i in e {
    mods.avaritia.ExtremeCrafting.remove(i);
}