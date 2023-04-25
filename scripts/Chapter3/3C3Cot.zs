import mods.contenttweaker.VanillaFactory as VF;
import mods.contenttweaker.Fluid;
if(true){
    var x=VF.createFluid("molten_essence", 0x55338811);
    x.density=1;
    x.luminosity=15;
    x.temperature=0;
    x.viscosity=2000;
    x.register();
}
if(true){
    var x=VF.createFluid("bot_mana", 0x775555FF);
    x.density=1;
    x.luminosity=15;
    x.temperature=0;
    x.viscosity=2000;
    x.stillLocation="astralsorcery:fluid/starlight_still";
    x.flowingLocation="astralsorcery:fluid/starlight_flow";
    x.register();
}
