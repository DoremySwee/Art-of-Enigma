#loader contenttweaker
import scripts.CotLib;
val lightStill="astralsorcery:blocks/fluid/starlight_still";
val lightFlow="astralsorcery:blocks/fluid/starlight_flow";
val moltStill="base:fluids/molten";
val moltFlow="base:fluids/molten_flowing";
CotLib.createFluid("molten_essence","AA99FF55",{
    density:1,luminosity:15,
    stillLocation:moltStill,
    flowingLocation:moltFlow
});
CotLib.createFluid("bot_mana","7799AAFF",{
    density:1,luminosity:15,
    stillLocation:lightStill,
    flowingLocation:lightFlow
});