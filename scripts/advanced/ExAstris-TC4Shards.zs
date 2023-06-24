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

import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;

//Anvils work as Ex Astris Hammers
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld=event.world;
    if(world.remote)return;
    for i in world.getEntities(){
        if(isNull(i.definition))continue;
        if(i.definition.id!="minecraft:falling_block")continue;
        if(i.getNBT().Block!="minecraft:anvil")continue;
        var x1 as double=i.x+i.motionX;
        var y1 as double=i.y+i.motionY;
        var z1 as double=i.z+i.motionZ;
        var blockPos as IBlockPos=V.asIBlockPos([x1,y1,z1]);
        var block as IBlock=world.getBlock(blockPos);
        if(isNull(block))continue;
        if(isNull(block.definition))continue;
        var id as string=block.definition.id;
        val block_drop as IItemStack[string]={
            "minecraft:tnt":<contenttweaker:shard_perditio>,
            "minecraft:ice":<contenttweaker:shard_aqua>,
            "minecraft:grass":<contenttweaker:shard_terra>,
            "minecraft:nether_brick":<contenttweaker:shard_ignis>
        };
        var drop as IItemStack=null;
        if(id=="minecraft:double_stone_slab"){
            if(block.meta==0){
                drop=<contenttweaker:shard_ordo>;
            }
            if(block.meta==1){
                drop=<contenttweaker:shard_aer>;
            }
        }
        else if (block_drop has id){
            drop=block_drop[id];
        }
        if(isNull(drop))continue;
        //world.setBlockState(<blockstate:minecraft:air>, blockPos);
        world.destroyBlock(blockPos,false);
        world.spawnEntity(drop.createEntityItem(world,blockPos));
    }
});