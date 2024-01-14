#reloadable
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
var oreIngots as IItemStack[IIngredient]={
    <ore:oreGold>:<minecraft:gold_ingot>,
    <ore:oreIron>:<minecraft:iron_ingot>,
    <ore:oreCopper>:<thermalfoundation:material:128>,
    <ore:oreLead>:<thermalfoundation:material:131>,
    <ore:oreSilver>:<thermalfoundation:material:130>,
    <ore:oreAluminum>|<ore:oreAluminium>:<thermalfoundation:material:132>,
    <ore:oreNickel>:<thermalfoundation:material:133>,
    <ore:oreTin>:<thermalfoundation:material:129>,
    <thermalfoundation:ore:6>:<thermalfoundation:material:134>
};
for ore,ingot in oreIngots{
    recipes.addShapeless(ingot*6,[
        ore,
        M.reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"})),
        <mysticalagriculture:stone_essence>,
        <mysticalagriculture:stone_essence>,
        <mysticalagriculture:stone_essence>,
        <mysticalagriculture:stone_essence>
    ]);
}
