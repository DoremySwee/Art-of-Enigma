#loader crafttweaker reloadableevents
import scripts.advanced.libs.Vector3D as V;
import crafttweaker.event.BlockPlaceEvent;
import mods.zenutils.ICatenationBuilder;
import scripts.advanced.libs.Misc as M;
import crafttweaker.data.IData;
events.onBlockPlace(function(event as BlockPlaceEvent){
    val blockId = "botania:cocoon";
    val dataKey = "cocoonMooshroom";
    var world = event.world;
    if(world.remote)return;
    var pos = event.position;
    if(world.getBlock(pos).definition.id==blockId){
        var uuid = event.player.uuid;
        world.catenation().sleep(2398).run(function(world,c){
            var block = world.getBlock(pos);
            if(block.definition.id==blockId && block.data.CustomTab == {}as IData &&
                block.data.emeraldsGiven.asInt() + block.data.chorusFruitGiven.asInt() ==0 ){
                var num = 0;
                var t = world.getCustomWorldData().deepGet(dataKey~"."~uuid);
                if(!isNull(t)) num=t.asInt();
                num+=1;
                world.updateCustomWorldData(world.getCustomWorldData().deepSet(num as IData, dataKey~"."~uuid));
                if(num%100==0){
                    world.setBlockState(<blockstate:minecraft:air>, pos);
                    var e as crafttweaker.entity.IEntityAgeable=
                        <entity:minecraft:mooshroom>.createEntity(world);
                    e.posX=0.5+pos.x;
                    e.posY=0.5+pos.y;
                    e.posZ=0.5+pos.z;
                    e.growingAge=-24000;
                    world.spawnEntity(e);
                }
            }
        }).start();
    }
});