//#loader crafttweaker reloadableevents
#priority 114514
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import scripts.LibReloadable as L;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import crafttweaker.data.IData;
static tagName as string="unstableIngotContainerCounter";
function setPlayerContainerCounter(n as int, player as IPlayer){
    var data as IData=IData.createEmptyMutableDataMap();
    data.memberSet(tagName,n);
    player.update(data);
}
function getPlayerContainerCounter(player as IPlayer)as int{
    if(player.data has tagName)return player.data.memberGet(tagName).asInt();
    else return 0;
}
events.onPlayerLoggedIn(function(event as crafttweaker.event.PlayerLoggedInEvent){
    setPlayerContainerCounter(0,event.player);
    L.say("Player Logged In!");
});
events.onPlayerRespawn(function(event as crafttweaker.event.PlayerRespawnEvent){
    setPlayerContainerCounter(0,event.player);
    L.say("Player Resapwned!");
});
function getUnstableIngot(p as IPlayer,w as IWorld)as IItemStack{
    return <extrautils2:unstableingots>.withTag({
        "owner": {
            UUIDL:  p.getUUIDObject().getLeastSignificantBits() as long, 
            Name:   p.name, 
            UUIDU:  p.getUUIDObject().getMostSignificantBits() as long
        },
        "container": getPlayerContainerCounter(p), 
        "dim": w.getDimension(), 
        "time": w.getWorldTime() as long
    });
}
events.onPlayerOpenContainer(function(event as crafttweaker.event.PlayerOpenContainerEvent){
    var p as IPlayer=event.player;
    var w as IWorld=p.world;
    if(w.remote)return;
    setPlayerContainerCounter(1+getPlayerContainerCounter(p),p);
    //L.say(getPlayerContainerCounter(p));
    //p.give(getUnstableIngot(p,w));
});
recipes.remove(<extrautils2:unstableingots>);
recipes.addShaped("unstable_ingot_unstable",<extrautils2:unstableingots>,[
    [null,<minecraft:diamond>,null],
    [null,<tconstruct:large_plate>.withTag({Material: "xu_enchanted_metal"}),null],
    [null,<minecraft:iron_ingot>,null]],
    function (out,ins,info){
        return getUnstableIngot(info.player,info.player.world);
    },null);