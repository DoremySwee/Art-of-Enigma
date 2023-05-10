#loader crafttweaker reloadableevents
#norun
import scripts.LibReloadable as L;
import mods.thaumcraft.ArcaneWorkbench as AWB;
import thaumcraft.aspect.CTAspectStack;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import mods.thaumicwands.WandCaps;
import mods.thaumicwands.WandRods;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import mods.ctutils.utils.Math;

zenClass capData{
    var aspects as CTAspectStack[];
    var vis as float;
    zenConstructor(aspectIn as CTAspectStack[],visIn as float){
        if(aspectIn.length>0)for a in aspectIn{aspects+=a;}
        vis=visIn;
    }
}
static capDiscounts as[capData[string]]=[{}as capData[string]]; 
static RodCapacities as [int[string]]=[{}as int[string]];
function A(item as IItemStack)as string{
    var vis as double=77.7;//(0.0+(0+getVis(item.tag)*100))/100;
    var cap as int=RodCapacities[0][item.tag.rod as string]as int;
    var p as string="";
    if(0+vis>cap)p="§r§o§5";
    else if(vis>0.75*cap)p="§r§o§9";
    else if(vis>0.50*cap)p="§r§o§b";
    else if(vis>0.30*cap)p="§r§o§a";
    else if(vis>0.15*cap)p="§r§o§3";
    else if(vis>0.99)p="§r§o§c";
    else p="§r§o§4";
    return p~vis~"/"~cap~".00";
}
//Show discounts
function B(item as IItemStack)as string{
    var cap as string=item.tag.cap as string;
    var dis as capData=capDiscounts[0][cap];
    return "§r§k**§r*"~(100*dis.vis)~"%"~"       "~
        "§r§o§e-"~dis.aspects[0].amount~"  "~
        "§r§o§2-"~dis.aspects[1].amount~"  "~
        "§r§o§c-"~dis.aspects[2].amount~"  "~
        "§r§o§b-"~dis.aspects[3].amount~"  "~
        "§r§o§f-"~dis.aspects[4].amount~"  "~
        "§r§o§7-"~dis.aspects[5].amount~"  ";
}
events.onItemToss(function(event as crafttweaker.event.ItemTossEvent){
    L.say(A(event.item.item));
    L.say(B(event.item.item));
});