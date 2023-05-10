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