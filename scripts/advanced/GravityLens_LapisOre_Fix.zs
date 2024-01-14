#reloadable
import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import crafttweaker.entity.IEntityItem;
import crafttweaker.entity.IEntity;
import scripts.advanced.libs.Misc as M;
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld = event.world;
    if(world.remote)return;
    if(event.phase=="START")return;
    for ore in world.getEntities(){
        if(isNull(ore))continue;
        if(isNull(ore.definition))continue;
        if(ore instanceof IEntityItem){
            var item as IEntityItem = ore;
            if(<minecraft:lapis_ore:4>.matches(item.item)){
                print(ore.nbt);
                ore.updateNBT(ore.nbt.deepSet(0,"Item.Damage"));
            }
        }
    }
});