#loader contenttweaker
#priority 1919810
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.CreativeTab;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;
import mods.contenttweaker.Item;
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
function editItem(item as Item, attributes as IData, creativeTab as CreativeTab)as Item{
    if(attributes has "beaconPayment")item.beaconPayment=attributes.beaconPayment as bool;
    if(attributes has "glowing")item.glowing=attributes.glowing as bool;
    if(attributes has "maxDamage")item.maxDamage=attributes.maxDamage as int;
    if(attributes has "toolLevel")item.toolLevel=attributes.toolLevel as int;
    if(attributes has "maxStackSize")item.maxStackSize=attributes.maxStackSize as int;
    if(attributes has "toolClass")item.toolClass=attributes.toolClass as string;
    if(attributes has "resourceLocation")
        item.textureLocation=mods.contenttweaker.ResourceLocation.create(attributes.resourceLocation);
    if(attributes has "textureLocation")
        item.textureLocation=mods.contenttweaker.ResourceLocation.create(attributes.textureLocation);
    item.creativeTab=creativeTab;
    return item;
}
function createItem(id as string,attributes as IData={},creativeTab as CreativeTab=<creativetab:misc>,register as bool=true)as Item{
    var item as Item=VanillaFactory.createItem(id);
    editItem(item,attributes,creativeTab);
    if(register)item.register();
    return item;
}
function createItemFood(id as string,attributes as IData={},creativeTab as CreativeTab=<creativetab:misc>,register as bool=true)as mods.contenttweaker.ItemFood{
    var item as mods.contenttweaker.ItemFood=VanillaFactory.createItemFood(id,4);
    editItem(item,attributes,creativeTab);
    if(attributes has "healAmount")item.healAmount=attributes.healAmount as int;
    if(attributes has "alwaysEdible")item.alwaysEdible=attributes.alwaysEdible as bool;
    if(attributes has "wolfFood")item.wolfFood=attributes.wolfFood as bool;
    if(attributes has "saturation")item.saturation=attributes.saturation as float;
    if(register)item.register();
    return item;
}