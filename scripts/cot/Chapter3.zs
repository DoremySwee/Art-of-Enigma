#loader contenttweaker
import crafttweaker.data.IData;
import scripts.cot.CotLib;
CotLib.createFluid("molten_essence","B099FF55",{
    density:1,luminosity:15,
    stillLocation:CotLib.lightStill,
    flowingLocation:CotLib.lightFlow
});
CotLib.createFluid("bot_mana","BB9999FF",{
    density:1,luminosity:15,
    stillLocation:CotLib.lightStill,
    flowingLocation:CotLib.lightFlow
});
CotLib.createBlock("chlorophyte_ore",{"lightValue":5});
CotLib.createItem("chlorophyte_ingot");
CotLib.createItem("pattern_wand");
/*
CotLib.createFluid("molten_chlorophyte","E077FF77",{
    density:1000,luminosity:15,
    stillLocation:CotLib.potionStill,
    flowingLocation:CotLib.potionFlow
});*/
CotLib.createFluid("molten_chlorophyte","E0FFFFFF",{
    density:1000,luminosity:15,
    stillLocation:"contenttweaker:fluids/chlorohpyte_still",
    flowingLocation:"contenttweaker:fluids/chlorohpyte_flow"
});
CotLib.createFluid("bot_elf","77FF99FF",{
    density:1,luminosity:15,
    stillLocation:CotLib.lightStill,
    flowingLocation:CotLib.lightFlow
});

CotLib.createItem("calc_sigil_addition");
CotLib.createItem("calc_sigil_subtraction");
CotLib.createItem("calc_sigil_multiplication");
CotLib.createItem("calc_sigil_division");