#loader crafttweaker reloadableevents
import scripts.advanced.libs.StructureTester as ST;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import scripts.advanced.libs.Misc as M;

//StructureTester
/*
static pattern as string[]= [
    "AAAAA;AXXXA;AXXXA;AXXXA;AAAAA",
    ";XBBB;XBXB;XBBB",
    ";;XXC"
] as string[];
static map as IData= ST.convertMap({
    "A":<minecraft:lapis_block>,
    "B":<minecraft:diamond_block>
}as IItemStack[string])as IData + {
    "X":{},
    "C":{"id":"minecraft:chest","meta":4,"data":{"Items":[
        {"Slot":13 as byte, "id":"minecraft:nether_star", "Count":1 as byte, "Damage":0 as short}
    ]}, "info":"with a nether star in the centre slot"}
}as IData;
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    if(event.world.remote)return;
    var result = ST.match( map, pattern, event.world,event.position,[-2 as int, -2 as int, -2 as int] );
    if(result.length==0)M.shout("Success!");
    else for r in result{
        M.shout(r);
    }
});*
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    event.player.canFly=true;
    M.shout("AAA");
});*/