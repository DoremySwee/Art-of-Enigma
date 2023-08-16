#loader crafttweaker reloadableevents
#priority -1
recipes.removeByRecipeName("embers:ember_emmiter");
recipes.removeByRecipeName("tconstruct:common/flint");
for i in 0 to 16{
    <entity:botania:doppleganger>.removeDrop(<botania:rune>.definition.makeStack(i));
}
var t1 = <mysticalagriculture:crafting:33>;
recipes.addShaped(<mysticalagriculture:ingot_storage:1>,[[t1,t1,t1],[t1,t1,t1],[t1,t1,t1]]);
var t2 = <appliedenergistics2:material:25>;
recipes.addShaped(<appliedenergistics2:material:53>*64,[[t2,t2,t2],[t2,<minecraft:crafting_table>,t2],[t2,t2,t2]]);