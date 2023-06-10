#loader crafttweaker reloadableevents
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.player.IPlayer;
import scripts.LibReloadable as L;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import crafttweaker.data.IData;
function isMidNight(world as IWorld)as bool{
    var time as int=(world.getProvider().getWorldTime()%(24000 as long))as int;
    return (time<=18500)&&(time>17500);
}/*
events.onItemToss(function(event as crafttweaker.event.ItemTossEvent){
    L.say(isMidNight(event.item.world)?"MIDNIGHT!":"not the time");
});*/
static BRIGHTNESS as int=4;
function getBrightness(world as IWorld, pos as IBlockPos)as int{
    //return world.getBlockState(pos).getLightValue(world,pos);
    //return world.getBrightness(pos);
    return world.getBrightnessSubtracted(pos);
}
function checkRitual(world as IWorld, pos as IBlockPos)as int{
    var result as int=0;
    if(world.getBlock(pos).definition.id!="minecraft:enchanting_table")result+=1;
    if(getBrightness(world,pos)>BRIGHTNESS)result=result|2;
    for i in -2 as int to 3{
        for j in -2 as int to 3{
            var pos2 as IBlockPos=IBlockPos.create(pos.x+i,pos.y- 1,pos.z+j);
            if(getBrightness(world,pos2)>BRIGHTNESS)result=result|2;
            if(!(["minecraft:dirt","extrautils2:cursedearth"]as string[] has 
                world.getBlock(pos2).definition.id))result=result|4;
        }
    }
    for i in -1 as int to 2{
        for j in -1 as int to 2{
            if(i==0&&j==0)continue;
            var pos2 as IBlockPos=IBlockPos.create(pos.x+i,pos.y,pos.z+j);
            if(getBrightness(world,pos2)>BRIGHTNESS)result=result|2;
            if(world.getBlock(pos2).definition.id!="minecraft:redstone_wire")result=result|8;
        }
    }
    if(!isMidNight(world))result=result|16;
    return result;
}
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    var world as IWorld=event.world;
    if(world.remote)return;
    if(!isNull(event.block) && !isNull(event.item)){
        var pos as IBlockPos=event.position;
        var player as IPlayer=event.player;
        if(event.block.definition.id=="minecraft:enchanting_table"
            &&event.item.definition.id=="contenttweaker:division_sigil"){
            var check as int=checkRitual(world,pos);
            if(check<1){
                player.sendChat(game.localize("chat.crt.exu1sigil.prepared"));
                player.sendChat(game.localize("chat.crt.exu1sigil.sacrifice"));
            }
            else{
                if((check&2)>0)player.sendChat(game.localize("chat.crt.exu1sigil.bright"));
                if((check&4)>0)player.sendChat(game.localize("chat.crt.exu1sigil.dirt"));
                if((check&8)>0)player.sendChat(game.localize("chat.crt.exu1sigil.wire"));
                if((check&16)>0)player.sendChat(game.localize("chat.crt.exu1sigil.time"));
            }
        }
    }
});
events.onEntityLivingDeath(function(event as crafttweaker.event.EntityLivingDeathEvent){
    var entity as crafttweaker.entity.IEntity=event.entity;
    var world as IWorld=entity.world;
    if(world.remote)return;
    if(entity instanceof crafttweaker.entity.IEntityAnimal) {
        if(event.damageSource.immediateSource instanceof IPlayer){
            var player as IPlayer=event.damageSource.immediateSource;
            for i in -1 as int to 2{
                for j in -1 as int to 2{
                    var pos as IBlockPos=IBlockPos.create(entity.x as int+i,entity.y as int,entity.z as int+j);
                    var check as int=checkRitual(world,pos);
                    if(check<1){
                        var flag=false;
                        for i in 0 to player.inventorySize{
                            if(!isNull(player.getInventoryStack(i))&&(player.getInventoryStack(i).definition.id=="contenttweaker:division_sigil")){
                                player.replaceItemInInventory(i,<contenttweaker:division_sigil_activated>);
                                flag=true;
                            }
                        }
                        if(flag){
                            //L.say("Suceess!");
                            world.addWeatherEffect(world.createLightningBolt(0.5+pos.x,0.5+pos.y,0.5+pos.z,true));
                            for i in -2 as int to 3{
                                for j in -2 as int to 3{
                                    var pos2 as IBlockPos=IBlockPos.create(pos.x+i,pos.y- 1,pos.z+j);
                                    world.setBlockState((<extrautils2:cursedearth>as IBlock).definition.defaultState,pos2);
                                }
                            }
                        }
                    }
                    else if(check%2==0){
                        if((check&2)>0)player.sendChat(game.localize("chat.crt.exu1sigil.bright"));
                        if((check&4)>0)player.sendChat(game.localize("chat.crt.exu1sigil.dirt"));
                        if((check&8)>0)player.sendChat(game.localize("chat.crt.exu1sigil.wire"));
                        if((check&16)>0)player.sendChat(game.localize("chat.crt.exu1sigil.time"));
                    }
                }
            }
        }
    }
});