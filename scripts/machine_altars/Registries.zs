#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.ISubTileEntityGenerating;
import crafttweaker.data.IData;
import scripts.CotLib;
val flower as ISubTileEntityGenerating = VanillaFactory.createSubTileGenerating("irisotos");
flower.range = 1;
flower.maxMana = 10000000;
flower.register();
CotLib.createItem("divisionsigil",{"maxStackSize":1});
CotLib.createItem("divisionsigilactivated",{
    "maxDamage":256,"maxStackSize":1,"glowing":true});
CotLib.createItem("psuinversigil",{
    "maxDamage":256,"maxStackSize":1,"glowing":true});