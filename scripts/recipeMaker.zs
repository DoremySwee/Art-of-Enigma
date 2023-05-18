#loader crafttweaker reloadableevents
import scripts.LibReloadable as L;
import crafttweaker.events.IEventManager;
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
var wand=<minecraft:iron_axe>;
events.onPlayerLeftClickBlock(function(event as crafttweaker.event.PlayerLeftClickBlockEvent){
    //if(event.world.isRemote)return;
    if(isNull(event.item))return;
    if(event.item.definition.id==wand.definition.id){
        if(event.block.definition.id==<avaritia:extreme_crafting_table>.definition.id){
            var dat as IData=event.block.data;
            if(isNull(dat))return;
            var inputs=[] as string[];
            for i in 0 to 81 {
                var key as string="Craft"~i;
                var p as IData=dat.memberGet(key)as IData;
                var t="null";
                if(!isNull(p))t=L.NBTToString(p);
                inputs+=t;
            }
            print(L.getReducedIIngredientArray(inputs,9));
            L.tell(event.player,"Recipe has been outputed to crafttweaker.log!");
            event.cancel();
        }
    }
});
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    if(event.player.world.remote)return;
    if(!isNull(event.block)&&event.block.definition.id=="minecraft:chest"){
        var logstring as string="";
        for i in L.getItemsInChest(event.block){
            logstring=logstring~i.commandString~",\n";
        }
        print(logstring);
        L.say("contents have been listed in the log!");
    }
});