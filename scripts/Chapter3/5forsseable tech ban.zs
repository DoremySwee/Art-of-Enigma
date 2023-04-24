#priority 114514
#norun
import crafttweaker.mods.IMod;
import crafttweaker.mods.ILoadedMods;
val MA=loadedMods["mysticalagriculture"] as IMod;
for i in MA.items{
    recipes.remove(i);
}