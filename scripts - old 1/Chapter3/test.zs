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
events.onItemToss(function(event as crafttweaker.event.ItemTossEvent){
    L.say(event.item.item.commandString);
    print(event.item.item.commandString);
});
function aa()as int{
    return 1;
}
print(scripts.Chapter3.test2.bb());