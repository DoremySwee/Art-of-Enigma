#priority 114514
import crafttweaker.mods.IMod;
import crafttweaker.mods.ILoadedMods;
import scripts.Lib;

mods.botania.Orechid.removeOre(<ore:oreCinnabar>);
mods.botania.Orechid.removeOre(<ore:oreUranium>);
mods.botania.Orechid.removeOre(<ore:oreAmber>);
val MA=loadedMods["mysticalagriculture"] as IMod;
for i in MA.items{
    if(i.definition.id.contains("reprocessor"))recipes.remove(i);
    if(i.definition.id.contains("storage"))recipes.remove(i);
    if(i.definition.id.contains("tinkering"))recipes.remove(i);
	if(i.definition.id.contains("crafting"))recipes.remove(i);
	if(i.definition.id.contains("seeds"))recipes.remove(i);	
    if(i.definition.id.contains("apple"))recipes.remove(i);	
    if(i.definition.id.contains("coal"))recipes.remove(i);	
    if(i.definition.id.contains("can"))recipes.remove(i);	
    if(i.definition.id.contains("infusion"))recipes.remove(i);	
    if(i.definition.id.contains("gear"))recipes.remove(i);	
}
for i in 0 to 9{
    recipes.remove(<extrautils2:passivegenerator>.definition.makeStack(i));
}