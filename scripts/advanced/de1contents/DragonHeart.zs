#reloadable
import mods.randomtweaker.botania.IBotaniaFXHelper;
import mods.zenutils.NetworkHandler;

import crafttweaker.util.Math;
import crafttweaker.data.IData;

import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;

import crafttweaker.entity.IEntityItem;
import crafttweaker.entity.IEntity;

import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;

<draconicevolution:dragon_heart>.maxStackSize=1;
static shoutEntityId as bool = false;

events.onExplosionDetonate(function(event as crafttweaker.event.ExplosionDetonateEvent){
    for i in event.affectedEntities{
        if(i instanceof IEntityItem){
            var item as IEntityItem=i;
            var world as IWorld=i.world;
            if(<draconicevolution:dragon_heart>.matches(item.item)){
                i.updateNBT({"ForgeData":{"shouldHaveBeenRemoved":true},"Invulnerable":true});
            }
        }
    }
});
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld = event.world;
    if(world.remote)return;
    if(event.phase=="START")return;
    for heart in world.getEntities(){
        if(isNull(heart))continue;
        if(isNull(heart.definition))continue;
        if(heart instanceof IEntityItem){
            var item as IEntityItem=heart;
            if(<draconicevolution:dragon_heart>.matches(item.item)){
                //print(heart.nbt);
                heart.updateNBT({"Health":10000});
                if(heart.nbt has "ForgeData" && heart.nbt.ForgeData has "shouldHaveBeenRemoved"){
                    var heart2=<entity:draconicevolution:dragonheartitem>.createEntity(event.world);
                    heart2.setNBT({
                        "dragonHeartCraftData":{
                            "x":item.x, "y":item.y, "z":item.z, "t":0, //Motion Related
                            "stage":0, "stageTimer":0, //0: Waiting, 1: Attracting Draconic Core, 2: Charging the charged draconium block
                            "coreNum":0 //Number of Core Absorbed
                        }
                    });
                    heart2.updateNBT({
                        "Invulnerable":true,
                        "Pos": [heart.x, heart.y, heart.z]
                    });
                    world.spawnEntity(heart2);
                    world.removeEntity(heart);
                }
            }
        }
        var id = heart.definition.id;
        if(heart.definition.id!="draconicevolution:dragonheartitem"){
            if(shoutEntityId){
                if(id.contains("burst"))continue;
                if(id.contains("spark"))continue;
                M.shout(id);
            }
            continue;
        }
        
        if(heart.nbt has "ForgeData" && heart.nbt.ForgeData has "dragonHeartCraftData"){
            var data as IData=heart.nbt.ForgeData.dragonHeartCraftData;
            heart.posY=data.y.asDouble()+(1.0-V.cosf(0.0+Math.min(180,data.t.asInt())))*0.3;
            var stage=data.stage.asInt();
            var timer=data.stageTimer.asInt()+1;
            var count = Math.min(16,data.coreNum.asInt());
            if(stage==0){
                if(timer>50){
                    stage=1;
                    timer=0;
                }
            }
            else if(stage==1){
                for i in M.getEntitiesAround(world,V.getPos(heart),10){
                    if(i instanceof IEntityItem){
                        var core as IEntityItem=i;
                        if(<draconicevolution:draconic_core>.matches(core.item)){
                            var diff=V.subtract(V.getPos(heart),V.getPos(core));
                            if(V.dot(diff,diff)<0.1){
                                var n = core.item.amount;
                                count=count+n;
                                world.removeEntity(core);
                                NetworkHandler.sendToAllAround("DragonHeartAttractionFX",
                                    heart.x,heart.y,heart.z,30,world.getDimension(),function(b){
                                        b.writeDouble(heart.x);
                                        b.writeDouble(heart.y);
                                        b.writeDouble(heart.z);
                                        b.writeDouble(0.0);
                                        b.writeDouble(0.0);
                                        b.writeDouble(1.0);
                                        b.writeInt(1);
                                    });
                            }
                            else{
                                var v = V.eulaAng(V.scale(V.unify(diff),Math.min(0.5,V.length(diff)/3)),[10.0,60.0,20.0]);
                                core.updateNBT({"Motion":[v[0],v[1],v[2]]});
                            }
                        }
                    }
                }
                if(timer%5==0){
                    NetworkHandler.sendToAllAround("DragonHeartAttractionFX",
                        heart.x,heart.y,heart.z,30,world.getDimension(),function(b){
                            b.writeDouble(heart.x);
                            b.writeDouble(heart.y);
                            b.writeDouble(heart.z);
                            b.writeDouble(1.0);
                            b.writeDouble(1.0- 1.0 * timer / 500);
                            b.writeDouble(1.0 * data.coreNum.asInt() /16);
                            b.writeInt(0);
                        });
                }
                if(count>16 && timer>100 && world.random.nextDouble() < 1.0*timer/250){
                    stage=2;
                    timer=0;
                }
                if(timer>250){
                    if(count>4){
                        stage=2;
                        timer=0;
                    }
                    else{
                        stage=-1 as int;
                        timer=0;
                    }
                    //world.removeEntity(heart);
                }
            }
            else if(stage==2){
                if(timer>130){
                    var flag=false;
                    for i in 0 to 4{
                        if(data.bpdata has "bp"~i){
                            var d=data.bpdata.memberGet("bp"~i);
                            var pos=IBlockPos.create(d.x.asInt(),d.y.asInt(),d.z.asInt());
                            if(M.checkBlock(world.getBlock(pos), "draconicevolution:draconium_block",1)){
                                world.setBlockState((<draconicevolution:draconic_block> as IBlock).definition.defaultState,pos);
                                world.performExplosion(null, 0.5+pos.x, 0.5+heart.y, 0.5+heart.z, 3.0f, false, false);
                                flag=true;
                            }
                        }
                    }
                    if(flag){
                        world.removeEntity(heart);
                        world.performExplosion(null, heart.x, heart.y, heart.z, 6.0f, false, false);
                    }
                    else{
                        stage=-1 as int;
                    }
                }
                else if(timer<2){
                    var bp as int[][]=[];
                    for r in 0 to 5{
                        if(bp.length>=count/4)break;
                        var t as int[][]=[];
                        if(r==0){
                            t=[[0,0,0]];
                        }
                        else{
                            t=[[r,r,r],[r,r,-r],[r,-r,r],[r,-r,-r],[-r,r,r],[-r,r,-r],[-r,-r,r],[-r,-r,-r]];
                            for i in 1 to r*2{
                                for k in[
                                    [r-i,r,r],[r,r-i,r],[r,r,r-i],
                                    [r-i,r,-r],[r,r-i,-r],[r,-r,r-i],
                                    [r-i,-r,r],[-r,r-i,r],[-r,r,r-i],
                                    [r-i,-r,-r],[-r,r-i,-r],[-r,-r,r-i]
                                ] as int[][]{t+=k;}
                                for j in 1 to r*2{
                                    for k in[
                                        [r-i,r-j,r],[r-i,r,r-j],[r,r-i,r-j],
                                        [r-i,r-j,-r],[r-i,-r,r-j],[-r,r-i,r-j]
                                    ] as int[][]{t+=k;}
                                }
                            }
                        }
                        for dpos in t{
                            if(bp.length>=count/4)break;
                            var pos = V.asIBlockPos([heart.x+dpos[0],heart.y+dpos[1],heart.z+dpos[2]]);
                            if(M.checkBlock(world.getBlock(pos),"draconicevolution:draconium_block",1)){
                                bp+=[pos.x,pos.y,pos.z] as int[];
                            }
                        }
                    }
                    var bpdata = IData.createEmptyMutableDataMap();
                    if(bp.length>0){
                        for i in 0 to bp.length{
                            bpdata.memberSet("bp"~i,{"x":bp[i][0],"y":bp[i][1],"z":bp[i][2]});
                        }
                    }
                    data=data+{"bpdata":bpdata};
                }
                else{
                    var bp as int[][]=[];
                    for i in 0 to 4{
                        if(data.bpdata has "bp"~i){
                            var d=data.bpdata.memberGet("bp"~i);
                            //print(d as IData);
                            var pos=[d.x.asInt(),d.y.asInt(),d.z.asInt()]as int[];
                            if(M.checkBlock(world.getBlock(IBlockPos.create(pos[0],pos[1],pos[2])),"draconicevolution:draconium_block",1)){
                                bp+=pos;
                                NetworkHandler.sendToAllAround("DragonHeartEjectionFX",
                                    heart.x,heart.y,heart.z,30,world.getDimension(),function(b){
                                        b.writeDouble(heart.x);
                                        b.writeDouble(heart.y);
                                        b.writeDouble(heart.z);
                                        b.writeInt(pos[0]);
                                        b.writeInt(pos[1]);
                                        b.writeInt(pos[2]);
                                    });
                            }
                        }
                    }
                    var bpdata = IData.createEmptyMutableDataMap();
                    if(bp.length>0){
                        for i in 0 to bp.length{
                            bpdata.memberSet("bp"~i,{"x":bp[i][0],"y":bp[i][1],"z":bp[i][2]});
                        }
                    }
                    data=data+{"bpdata":bpdata};
                }
            }
            heart.setNBT({"dragonHeartCraftData":data+{"t":data.t.asInt()+1, "stageTimer":timer, "stage":stage, "coreNum":count}});
        }
        else{
            heart.setNBT({
                "dragonHeartCraftData":{
                    "x":heart.x, "y":heart.y, "z":heart.z, "t":0, //Motion Related
                    "stage":0, "stageTimer":0, //0: Waiting, 1: Attracting Draconic Core, 2: Charging the charged draconium block
                    "coreNum":0 //Number of Core Absorbed
                }
            });
        }
    }
});
NetworkHandler.registerServer2ClientMessage("DragonHeartAttractionFX",function(p,b){
    var x0 = b.readDouble();
    var y0 = b.readDouble()+p.world.random.nextDouble(0.1,0.4)+0.3;
    var z0 = b.readDouble();
    var r = b.readDouble();
    var g = b.readDouble();
    var B = b.readDouble();
    var t = b.readInt();
    var axis=V.randomUnitVector(p.world);
    var angle=p.world.random.nextDouble(0.0,30.0);
    var N= 80;
    var rd1=p.world.random.nextDouble(0.1,1.0);
    if(t==0){
        for i in 0 to N{
            var v=V.rot(V.rot(V.scale(V.VX,rd1*p.world.random.nextDouble(0.9,1.2)),V.VY,360.0/N*i),axis,angle);
            var p0 = V.add([x0,y0,z0],V.scale(v,-20.0));
            IBotaniaFXHelper.wispFX(
                p0[0],p0[1],p0[2],
                r as float,g as float,B as float,
                0.13,v[0],v[1],v[2],1);
        }
    }
    else{
        var v1=V.rot(V.rot(V.VX,V.VY,0),axis,angle);
        var v2=V.rot(V.rot(V.VX,V.VY,90),axis,angle);
        var v3=V.unify(V.cross(v1,v2));
        for i in 0 to 30{
            var v0 = V.rot(V.scale(v3,p.world.random.nextDouble(2.0,3.5)*0.02),V.randomUnitVector(p.world),p.world.random.nextDouble(0.0,5.4));
            for j in 0 to 10{
                var v=V.scale(v0,0.0+j);
                IBotaniaFXHelper.wispFX(
                    x0,y0,z0,
                    0.7f,0.7f,1.0f,
                    0.23,v[0],v[1],v[2],1);
                IBotaniaFXHelper.wispFX(
                    x0,y0,z0,
                    0.7f,0.7f,1.0f,
                    0.23,-v[0],-v[1],-v[2],1);
            }
        }
    }
});
NetworkHandler.registerServer2ClientMessage("DragonHeartEjectionFX",function(p,b){
    var x0 = b.readDouble();
    var y0 = b.readDouble()+p.world.random.nextDouble(0.1,0.4)+0.3;
    var z0 = b.readDouble();
    var x1 = 0.5+b.readInt();
    var y1 = 0.5+b.readInt();
    var z1 = 0.5+b.readInt();
    var N= 7;
    var dv=V.subtract([x1,y1,z1],[x0,y0,z0]);
    for i in 0 to N{
        var axis=V.randomUnitVector(p.world);
        var angle=p.world.random.nextDouble(0.0,3.0);
        var v=V.rot(V.scale(dv,0.05/N*i),axis,angle);
        IBotaniaFXHelper.wispFX(x0,y0,z0,1.0f,0.2f,0.0f,0.24,v[0],v[1],v[2],1);
        //IBotaniaFXHelper.wispFX(x1,y1,z1,0.0f,0.0f,1.0f,0.24,-v[0],-v[1],-v[2],1);
    }
    N=20;
    var r=(V.angle(dv,V.VX)<30)?V.unify(V.cross(dv,V.VZ)):V.unify(V.cross(dv,V.VY));
    for i in 0 to N{
        var v=V.scale(V.rot(r,dv,360.0/N*i),0.25);
        IBotaniaFXHelper.wispFX(x0,y0,z0,1.0f,0.0f,0.0f,0.12,v[0],v[1],v[2],1);
    }
});