#loader contenttweaker
import scripts.CotLib;
val lightStill="astralsorcery:blocks/fluid/starlight_still";
val lightFlow="astralsorcery:blocks/fluid/starlight_flow";
val moltStill="base:fluids/molten";
val moltFlow="base:fluids/molten_flowing";
val exu2Molt="extrautils2:molten_fluid_base";
CotLib.createFluid("molten_essence","D099FF55",{
    density:1,luminosity:15,
    stillLocation:moltStill,
    flowingLocation:moltFlow
});
CotLib.createFluid("bot_mana","BB9999FF",{
    density:1,luminosity:15,
    stillLocation:lightStill,
    flowingLocation:lightFlow
});