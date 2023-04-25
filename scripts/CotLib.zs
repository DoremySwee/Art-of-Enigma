#loader contenttweaker
#priority 1919810
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;
import crafttweaker.data.IData;
function createFluid(id as string, c as string, attributes as IData={}){
    var fluid=VanillaFactory.createFluid(id,Color.fromHex(c));
    if(attributes has "density")fluid.density=attributes.density as int;
    if(attributes has "gaseous")fluid.gaseous=attributes.gaseous as bool;
    if(attributes has "luminosity")fluid.luminosity=attributes.luminosity as int;
    if(attributes has "temperature")fluid.temperature=attributes.temperature as int;
    if(attributes has "colorize")fluid.colorize=attributes.colorize as bool;
    if(attributes has "rarity")fluid.rarity=attributes.rarity as string;
    if(attributes has "viscosity")fluid.viscosity=attributes.viscosity as int;
    if(attributes has "vaporize")fluid.vaporize=attributes.vaporize as bool;
    if(attributes has "stillLocation")fluid.stillLocation=attributes.stillLocation as string;
    if(attributes has "flowingLocation")fluid.flowingLocation=attributes.flowingLocation as string;
    /*print("registeringFluid"~id);
    print(fluid.flowingLocation);
    print(c)*/
    fluid.register();
}