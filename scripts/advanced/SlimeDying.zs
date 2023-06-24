#loader crafttweaker reloadableevents
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityMob;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
//Turn slimes blue in liquid bot mana
events.onEntityLivingUpdate(function(event as crafttweaker.event.EntityLivingUpdateEvent){
    var entity as crafttweaker.entity.IEntity=event.entity;
    var world as IWorld=entity.world;
    if(world.remote)return;
    if(isNull(entity))return;
    if(isNull(entity.definition))return;
    if(isNull(entity.definition.id))return;
    if(entity.definition.id=="minecraft:slime"){
        var pos as IBlockPos = entity.position;
        if(isNull(world.getBlock(pos))){
            return;
        }
        if(isNull(world.getBlock(pos).fluid)){
            return;
        }
        if(world.getBlock(pos).fluid.name!="bot_mana")return;
        var newSlime = <entity:tconstruct:blueslime>.createEntity(world);
        newSlime.updateNBT(entity.nbt);
        world.spawnEntity(newSlime);
    }
});