#priority 500
import crafttweaker.item.IItemStack;
var d = [
    <immersiveengineering:metal_decoration0:7>,
    <embers:mech_core>,
    <embers:blend_caminite>,
    <embers:item_pipe>,
    <embers:tinker_hammer>,
    <embers:stamper>,
    <embers:stamper_base>,
    <embers:mixer>,
    <embers:block_furnace>,
    <avaritia:compressed_crafting_table>,
    <avaritia:extreme_crafting_table>,
    <avaritia:neutron_collector>,
    <avaritia:neutronium_compressor>,
    <avaritia:skullfire_sword>,
    <botania:altar>,
    <botania:terraplate>,
    <botania:brewery>,
    <botania:manabomb>,
    <botania:alchemycatalyst>,
    <botania:conjurationcatalyst>,
    <botania:livingwood:5>,
    <botania:alfheimportal>,
    <botania:pylon:1>,
    <botania:pylon:2>,
    <botania:lens:8>,
    <botania:lens:11>,
    <botania:lens:14>,
    <botania:lens:15>,
    <bloodmagic:soul_forge>,
    <bloodmagic:altar>,
    <appliedenergistics2:controller>,
    <appliedenergistics2:part:180>,
    <extrautils2:glasscutter>,
    <extrautils2:resonator>,
    <extrautils2:machine>,
    <extrautils2:ingredients:1>,
    <extrautils2:decorativesolid:2>,
    <calculator:powercube>,
    <calculator:calculatorscreen>,
    <calculator:calculatorassembly>,
    <calculator:dynamiccalculator>,
    <draconicevolution:draconic_core>,
    <thermalexpansion:frame>,
    <thermalexpansion:frame:64>,
    <thermaldynamics:duct_32:*>,
    <thermalexpansion:augment:337>,
    <enderio:item_basic_capacitor>,
    <enderio:item_material:71>,
    <enderio:item_material>,
    <enderio:item_me_conduit>,
    <enderio:item_item_conduit>
] as IItemStack[];
for i in 1 to 16{
    recipes.removeShapeless(<minecraft:wool>.definition.makeStack(i));
}
for i in 0 to 16{
    mods.botania.RuneAltar.removeRecipe(<botania:rune>.definition.makeStack(i));
}
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
for i in 0 to 16{
    d+=<thermalexpansion:machine>.definition.makeStack(i);
}
for i in 9 to 14{
    var temp=<enderio:item_material>.definition.makeStack(i);
    d+=temp;
    mods.tconstruct.Casting.removeTableRecipe(temp);
}
for i in d {
    recipes.removeShaped(i);
    recipes.removeShapeless(i);
    mods.avaritia.ExtremeCrafting.remove(i);
}