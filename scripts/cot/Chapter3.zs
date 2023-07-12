#loader contenttweaker
import crafttweaker.data.IData;
import scripts.cot.CotLib;
CotLib.createFluid("molten_essence","D099FF55",{
    density:1,luminosity:15,
    stillLocation:CotLib.moltStill,
    flowingLocation:CotLib.moltFlow
});
CotLib.createFluid("bot_mana","BB9999FF",{
    density:1,luminosity:15,
    stillLocation:CotLib.lightStill,
    flowingLocation:CotLib.lightFlow
});
CotLib.createBlock("chlorophyte_ore",{"lightValue":5});
CotLib.createItem("chlorophyte_ingot");
CotLib.createFluid("molten_chloroyphyte","FF00FF77",{
    density:1000,luminosity:15,
    stillLocation:CotLib.moltStill,
    flowingLocation:CotLib.moltFlow
});
CotLib.createFluid("bot_elf","77FF99FF",{
    density:1,luminosity:15,
    stillLocation:CotLib.lightStill,
    flowingLocation:CotLib.lightFlow
});