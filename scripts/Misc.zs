#loader crafttweaker reloadableevents
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;

import crafttweaker.world.IFacing;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;

import crafttweaker.event.BlockNeighborNotifyEvent;
import crafttweaker.event.BlockHarvestDropsEvent;
import crafttweaker.event.BlockPlaceEvent;
import crafttweaker.event.CommandEvent;

import mods.ctutils.utils.Math;
import scripts.Altars.L;
import crafttweaker.command.ICommandSender;
import mods.zenutils.ICatenationBuilder;

//Nether Portal Ban
events.onPortalSpawn(function (event as crafttweaker.event.PortalSpawnEvent){
    event.cancel();
    L.say(game.localize("quests.ch2.portalCancel.des"));
});

//Command Scare
events.onCommand(function(event as CommandEvent){
    if(event.command.name=="say")return;
    if(event.command.name=="tellraw")return;
    if(event.command.name=="forge")return;
    if(event.command.name=="ftbquests")return;
    if(event.command.name=="crafttweaker")return;
    if(event.commandSender instanceof IPlayer){
        val p as IPlayer=event.commandSender;
        var t as string[]=[
            "You feel an evil presence watching you",
            "A horrible chill goes down your spine...",
            //"Screams echo around you...",
            //"This is going to be a terrible night...",
            "You feel vibrations from deep below...",
            "The air is getting colder around you...",
            //"What a horrible night to have a curse.",
            "Your mind goes numb...",
            "You are overwhelmed with pain...",
            "Otherworldly voices linger around you...",
            "Impending doom approaches...",
            "The ancient spirits of light and dark have been released.",
            "The Moon Lord has been defeated !"
            ] as string[];
        var r as int=((Math.random()*10) as int)%10;
        var s as string=t[r];
        p.server.commandManager.executeCommand(server,"tellraw "+/*p.displayName*/"@p"+" [{\"text\":\""+s+"\",\"color\":\"dark_purple\",\"bold\":\"true\",\"italic\":\"true\"}]");
    }
});

//Balance 20221214
events.onBlockHarvestDrops(function(event as BlockHarvestDropsEvent){
    if(event.block.definition.id=="minecraft:leaves"){
        event.drops += <minecraft:sapling>.weight(0.3);
        event.drops += <minecraft:golden_apple>.weight(0.005);
    }
});

//endofalme
events.onBlockNeighborNotify(function(event as BlockNeighborNotifyEvent){
    var w0 as IWorld=event.world;
    var p as IBlockPos=event.position;
    var d0 as IData=w0.getBlock(p).data;
    if(w0.isRemote())return;
    if(!isNull(d0)) if(d0 has "subTileName"){
        server.commandManager.executeCommandSilent(server,"say BBBB");
        w0.catenation().run(function(w,c){
            var dt=w.getBlock(p).data;
            if(!isNull(dt)) if(dt has "subTileName") if(dt.subTileName=="endoflame"){

                var dd as IData=w.getCustomChunkData(p);
                if(!(dd has "EndoResV3")){
                    w.setCustomChunkData({"EndoResV3":{"num":1,"x":[p.x]as int[],"y":[p.y]as int[],"z":[p.z]as int[]}},p);
                    w.updateCustomChunkData({"EndoResV3":{"num":1,"x":[p.x]as int[],"y":[p.y]as int[],"z":[p.z]as int[]}},p);
                    return;
                }
                else{
                    var d as IData=dd.EndoResV3;
                    var x as int[]=[p.x];
                    var y as int[]=[p.y];
                    var z as int[]=[p.z];
                    var n as int=1;
                    for i in 0 to d.num{
                        var p1 as IBlockPos= crafttweaker.util.Position3f.create(d.x[i], d.y[i], d.z[i])as IBlockPos;
                        var d1 as IData=w.getBlock(p1).data;
                        if(!isNull(d1)) if(d1 has "subTileName") if(d1.subTileName=="endoflame") if((p1.x!=p.x)||(p1.y!=p.y)||(p1.z!=p.z)){
                            x+=p1.x;    y+=p1.y;    z+=p1.z;    n+=1;
                        }
                    }

                    if(n>8){
                        L.say(game.localize("info.crt.endoFlameRes.exceed"));
                        w.setBlockState(<blockstate:minecraft:air>, p);
                        w.spawnEntity(<botania:specialflower>.withTag({type: "endoflame"}).createEntityItem(w,p.x,p.y+1,p.z));
                    }
                    else w.updateCustomChunkData({"EndoResV3":{"num":n,"x":x,"y":y,"z":z}},p);
                }
            }
        }).start();
    }
});

//cocoon - Mooshroom
events.onBlockPlace(function(event as BlockPlaceEvent){
    var w0 as IWorld=event.world;
    var p as IBlockPos=event.position;
    var b0 as IBlock=w0.getBlock(p);
    var uuid as string=event.player.uuid;
    if(w0.isRemote())return;
    if(b0.definition.id=="botania:cocoon"){
        var num as int= -11 as int;
        if(w0.getCustomWorldData() has "cocoonDat"){
            var l as IData[]=w0.getCustomWorldData().cocoonDat.asList()as IData[];
            for d in l{
                if(uuid==d.uuid){
                    num=(d.num as int)+1;
                    break;
                }
            }
            if(num== -11){
                num=1;
            }
            var l1 as IData=[{"uuid":uuid,"num":num}as IData]as IData;
            for d1 in l{
                if(uuid!=d1.uuid)l1+=d1;
            }
            w0.updateCustomWorldData({"cocoonDat":l1 as IData});
        }
        else{
            num=1;
            w0.setCustomWorldData({"cocoonDat":[{"uuid":uuid,"num":num}]});
        }
        if(num%100==0){
            w0.catenation().sleep(2398).run(function(w,c){
                if(w.getBlock(p).definition.id=="botania:cocoon"){
                    w.setBlockState(<blockstate:minecraft:air>, p);
                    var e as crafttweaker.entity.IEntityAgeable=
                        <entity:minecraft:mooshroom>.createEntity(w);
                    e.posX=0.5+p.x;
                    e.posY=0.5+p.y;
                    e.posZ=0.5+p.z;
                    e.growingAge=-24000;
                    w.spawnEntity(e);
                }
                else{
                    var n=(num/10)*10- 1;
                    var l1 as IData=[{"uuid":uuid,"num":n}as IData]as IData;
                    for d1 in w0.getCustomWorldData().cocoonDat.asList()as IData[]{
                        if(uuid!=d1.uuid)l1+=d1;
                    }
                    w0.updateCustomWorldData({"cocoonDat":l1 as IData});
                }
            }).start();
        }
    }
});
//golden_apple
events.onEntityLivingUseItemFinish(function(event as crafttweaker.event.EntityLivingUseItemEvent.Finish){
    if(event.isPlayer&&(event.item.definition.id==<minecraft:golden_apple>.definition.id)){
        event.player.addPotionEffect(<potion:minecraft:haste>.makePotionEffect(1800,2));
    }
});
events.onItemExpire(function(event as crafttweaker.event.ItemExpireEvent){
    if(event.item.item.definition.id==<botania:terraplate>.definition.id){
        event.extraLife=1919810;
        event.cancel();
    }
});
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    if(event.block.definition.id==<botania:cocoon>.definition.id){
        event.cancel();
    }
});