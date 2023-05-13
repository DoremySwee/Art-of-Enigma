#loader crafttweaker reloadableevents
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import scripts.LibReloadable as L;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import crafttweaker.data.IData;
function isMidNight(world as IWorld)as bool{
    var time as int=(world.getProvider().getWorldTime()%(24000 as long))as int;
    return (time<=18500)&&(time>17500);
}
events.onItemToss(function(event as crafttweaker.event.ItemTossEvent){
    L.say(isMidNight(event.item.world)?"MIDNIGHT!":"not the time");
});