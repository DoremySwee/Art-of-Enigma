#reloadable
#priority 114514
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
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
});
events.onPlayerRespawn(function(event as crafttweaker.event.PlayerRespawnEvent){
    setPlayerContainerCounter(0,event.player);
});
events.onPlayerOpenContainer(function(event as crafttweaker.event.PlayerOpenContainerEvent){
    var p as IPlayer=event.player;
    var w as IWorld=p.world;
    if(w.remote)return;
    setPlayerContainerCounter(1+getPlayerContainerCounter(p),p);
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

recipes.addShaped("unstable_ingot_unstable",<extrautils2:unstableingots>,[
    [<minecraft:diamond>],
    [<contenttweaker:division_sigil_activated>.anyDamage().transformDamage()],
    [<minecraft:iron_ingot>]],
    function(out,ins,info){
        if(isNull(info.player))return null;
        return out;
    },function(out,cInfo,player){
        if(isNull(player))out.mutable().shrink(1);
        out.mutable().withTag(getUnstableIngot(player,player.world).tag);
        print(out.commandString);
    });

recipes.remove(<extrautils2:unstableingots>);
recipes.remove(<extrautils2:unstableingots:1>);
recipes.remove(<extrautils2:unstableingots:2>);
recipes.addShaped(<extrautils2:unstableingots:2>,[[<minecraft:diamond>],[M.reuse(<contenttweaker:psu_inver_sigil>)],[<minecraft:iron_ingot>]]);

mods.jei.JEI.addDescription([<contenttweaker:division_sigil>,<contenttweaker:division_sigil_activated>, <contenttweaker:psu_inver_sigil>],game.localize("jei.description.exu_sigils"));