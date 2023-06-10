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
function cap(name as string,resourceLocation as string=""){
    if(resourceLocation=="")
        CotLib.createItem("wand_cap_"~name,{},<creativetab:materials.base>);
    else
        CotLib.createItem("wand_cap_"~name,{
            "textureLocation":resourceLocation
        },<creativetab:materials.base>);
}
function rod(name as string,resourceLocation as string=""){
    if(resourceLocation=="")
        CotLib.createItem("wand_rod_"~name,{},<creativetab:materials.base>);
    else
        CotLib.createItem("wand_rod_"~name,{
            "textureLocation":resourceLocation
        },<creativetab:materials.base>);
}
function rodInert(name as string){
    rod(name);
    rod(name~"_inert");
}
function capInert(name as string){
    cap(name);
    cap(name~"_inert");
}
function copyCap(name as string){
    cap(name,"thaumicwands:items/wand_cap_"~name);
}
function copyRod(name as string){
    rod(name,"thaumicwands:items/wand_rod_"~name);
}
copyCap("iron");
cap("manasteel");
capInert("elementium");
rod("livingwood");
rodInert("dreamwood");

//Marshmallow
var marshmallow as mods.contenttweaker.ItemFood=
CotLib.createItemFood("dezil_marshmallow",{
    "healAmount":100,
    "alwaysEdible":true,
    "saturation":20,
    "glowing":true
});
marshmallow.onItemFoodEaten=function(stack, world, player) {
    if (!world.isRemote()) {
        player.addPotionEffect(<potion:minecraft:speed>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:haste>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:strength>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:jump_boost>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:regeneration>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:resistance>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:water_breathing>.makePotionEffect(600, 1));
        player.addPotionEffect(<potion:minecraft:luck>.makePotionEffect(600, 1));
    }
};
CotLib.createItem("shard_aqua");
CotLib.createItem("shard_ignis");
CotLib.createItem("shard_aer");
CotLib.createItem("shard_terra");
CotLib.createItem("shard_ordo");
CotLib.createItem("shard_perditio");
CotLib.createItem("shard_balanced");