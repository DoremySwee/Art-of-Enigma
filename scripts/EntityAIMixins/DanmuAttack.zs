#loader crafttweaker reloadableevents
#priority 101
//#norun
import mods.randomtweaker.botania.IBotaniaFXHelper;
import crafttweaker.world.IVector3d;
import crafttweaker.world.IBlockPos;
import crafttweaker.util.Position3f;
import mods.ctutils.utils.Math;

import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntity;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;

import mods.zenutils.NetworkHandler;
import mods.zenutils.IByteBuf;

import scripts.EntityAIMixins.MiscLib as M;
import scripts.LibReloadable as L;
import scripts.libs.Vector3D as V;


zenClass Orb{
    static PlayerHits as long[string]={} as long[string];
    var data as IData={
        "lastX":0.0,
        "lastY":0.0,
        "lastZ":0.0,
        "x":0.0,
        "y":0.0,
        "z":0.0,
        "life":0,
        "removal":false,
        "color":0xFFFFFF,
        "damage":1.0,
        "radius":3.0,
        "DeleteRadius":500.0,
        "LifeLim":3000,
        "ClearOnPlayerHit":false,
        "LazyTimer":0,
        "maxPlayerSpeed":5.0,    //per GameTick
        "colli":true
    };
    function setData(dat as IData)as Orb{
        data=dat;return this;
    }
    function updateData(dat as IData)as Orb{
        data=data+dat;return this;
    }
    function isRemoved()as bool{return data.removal.asBool();}
    function remove()as Orb{
        updateData({"removal":true});return this;
    }
    function getData()as IData{return data;}
    function getX()as double{return getData().x.asDouble();}
    function getY()as double{return getData().y.asDouble();}
    function getZ()as double{return getData().z.asDouble();}
    function getV()as double[]{
        var dx=(data has"vx")?data.vx.asDouble():data.x.asDouble()-data.lastX.asDouble();
        var dy=(data has"vy")?data.vy.asDouble():data.y.asDouble()-data.lastY.asDouble();
        var dz=(data has"vz")?data.vz.asDouble():data.z.asDouble()-data.lastZ.asDouble();
        return [dx,dy,dz];
        /*/return [0.0,0.0,0.0];/**/
    }
    function inSphere(r as double, x as double, y as double, z as double)as bool{
        var dx=x-this.getX();
        var dy=y-this.getY();
        var dz=z-this.getZ();
        return dx*dx+dy*dy+dz*dz<r*r;
    }
    var logicTick as [function(IWorld,IData)IData];
    var removalTick as function(IWorld,IData)IData=
        function(world as IWorld, data as IData)as IData{
            if(this.isRemoved())return data;
            if(data.LifeLim.asInt()>0 && data.life.asInt()>data.LifeLim.asInt())return data+{"removal":true};
            if(data.DeleteRadius.asDouble()<0)return data;
            for player in world.getAllPlayers(){
                if(this.inSphere(data.DeleteRadius.asDouble(),player.x,player.y+player.eyeHeight,player.z))return data;
            }
            return data+{"removal":true};
        };
    var colliTick as function(IWorld,IPlayer,IData)bool=
        function(world as IWorld, player as IPlayer, data as IData)as bool{
            /*if(data.memberGet("LazyTimer")>0){
                this.updateData({"LazyTimer":data.memberGet("LazyTimer").asInt()- 1});
                return false;
            }*/
            if(this.isRemoved())return true;
            if(world.remote)return false;
            if(!data.memberGet("colli").asBool())return false;
            var d as IData=data;
            var dist as double=V.pointSegmentDistance([d.lastX,d.lastY,d.lastZ],[d.x,d.y,d.z],[player.x,player.y+player.eyeHeight,player.z])-d.radius;
            if(data.memberGet("ClearOnPlayerHit").asBool()){
                var diff as long=(PlayerHits has player.uuid)?(world.getWorldTime()-PlayerHits[player.uuid]):-1;
                if(diff>0 && diff<40 && this.inSphere(diff*5,player.x,player.y+player.eyeHeight,player.z)){
                    return true;
                }
            }
            if(dist<0){
                player.attackEntityFrom(<damageSource:MAGIC>,this.getData().damage);
                //PlayerHits[player.uuid]=world.getWorldTime();
                L.say("colli!");
                //L.say("pos:"~data.x~","~data.y~","~data.z);
                return true;
            }/*
            if(data.maxPlayerSpeed>0){
                var VMax=1.5*(((V.angle(this.getV(),V.subtract([player.x,player.y+player.eyeHeight,player.z],[d.x,d.y,d.z]))<90)?(V.length(this.getV())):(0.0))+data.maxPlayerSpeed);
                if(dist/VMax>3){
                    var timer as int=0+ dist/VMax- 2;
                    if(timer>30)timer=30;
                    this.updateData({"LazyTimer":timer});
                }
            }*/
            return false;
        };
    var renderTick as function(IWorld,IData)void=
        function(world as IWorld, data as IData)as void{
            if(this.isRemoved())return;
            if(!world.remote){
                var d as IData=this.getData();
                NetworkHandler.sendToAllAround("AOE_DanmuAttack_Orb",
                    d.x,d.y,d.z,d.DeleteRadius,
                    world.getDimension(),
                    function(buffer)as void{
                        //Position*3, Color*1, Radius*1, Motion*3, Age*1
                        var d as IData=this.getData();
                        buffer.writeDouble(d.x);
                        buffer.writeDouble(d.y);
                        buffer.writeDouble(d.z);
                        buffer.writeInt(d.color);
                        buffer.writeDouble(d.radius);
                        buffer.writeDouble(0);
                        buffer.writeDouble(0);
                        buffer.writeDouble(0);
                        buffer.writeDouble(0.3);
                    }
                );
            }
        };
    zenConstructor(logicTickIn as function(IWorld,IData)IData, x as double, y as double, z as double){
        logicTick=[logicTickIn];
        updateData({"x":x,"lastX":x,"y":y,"lastY":y,"z":z,"lastZ":z});
    }
    function setLogicTick(f as function(IWorld,IData)IData)as Orb{logicTick=[f];return this;}
    function addLogicTick(f as function(IWorld,IData)IData)as Orb{logicTick+=f;return this;}
    function setRemovalTick(f as function(IWorld,IData)IData)as Orb{removalTick=f;return this;}
    function setColliTick(f as function(IWorld,IPlayer,IData)bool)as Orb{colliTick=f;return this;}
    function setRenderTick(f as function(IWorld,IData)void)as Orb{renderTick=f;return this;}
    function smallOrb()as Orb{
        return updateData({"radius":0.3,"DeleteRadius":20});
    }
    function midOrb()as Orb{
        return updateData({"radius":1,"DeleteRadius":100});
    }
    function onLogicTick(world as IWorld)as bool{
        if(isRemoved())return false;
        var xt=getX();
        var yt=getY();
        var zt=getZ();
        for f in logicTick{updateData(f(world,data));}
        data=data+{
            "lastX":xt,
            "lastY":yt,
            "lastZ":zt,
            "life":data.life.asInt()+1
        };
        updateData(removalTick(world,data));
        return true;
    }
    function onRenderTick(world as IWorld)as bool{
        if(isRemoved())return false;
        renderTick(world,data);
        return true;
    }
    function onColliTick(world as IWorld)as bool{
        if(isRemoved())return false;
        for player in world.getAllPlayers(){
            updateData({"removal":colliTick(world,player,data)});
            if(isRemoved())return false;
        }
        return true;
    }

    static OrbList as [Orb][int]={} as [Orb][int];
    static RegiList as [Orb][int]={} as [Orb][int];
    function regi(world as IWorld)as bool{
        //L.say(data);
        //L.say(isRemoved());
        var dim as int=world.getDimension();
        if(RegiList has dim){
            RegiList[dim]=RegiList[dim]+this;
        }
        else{
            RegiList[dim]=[this];
        }
        return true;
    }
    function regiInner(dim as int)as bool{
        if(OrbList has dim){
            OrbList[dim]=OrbList[dim]+this;
        }
        else{
            OrbList[dim]=[this];
        }
        return true;
    }
    function useReducedRender()as Orb{
        setRenderTick(function(world as IWorld, data as IData)as void{
            if(data.removal.asBool())return;
            if(data.life.asInt()%7!=1)return;
            if(!world.remote){
                var d as IData=data;
                NetworkHandler.sendToAllAround("AOE_DanmuAttack_Orb",
                    d.x,d.y,d.z,d.DeleteRadius,
                    world.getDimension(),
                    function(buffer)as void{
                        //Position*3, Color*1, Radius*1, Motion*3, Age*1
                        var d as IData=data;
                        buffer.writeDouble(d.x);
                        buffer.writeDouble(d.y);
                        buffer.writeDouble(d.z);
                        buffer.writeInt(d.color);
                        buffer.writeDouble(d.radius);
                        buffer.writeDouble(d.x-d.lastX);
                        buffer.writeDouble(d.y-d.lastY);
                        buffer.writeDouble(d.z-d.lastZ);
                        buffer.writeDouble(0.7);
                    }
                );
            }
        });
        return this;
    }
}

NetworkHandler.registerServer2ClientMessage("AOE_DanmuAttack_Orb",function(player,buffer){
    //Position*3, Color*1, Radius*1, Motion*3, Age*1
    var x as double=buffer.readDouble();
    var y as double=buffer.readDouble();
    var z as double=buffer.readDouble();
    var color as int=buffer.readInt();
    var r as double=buffer.readDouble();
    var vx as double=buffer.readDouble();
    var vy as double=buffer.readDouble();
    var vz as double=buffer.readDouble();
    var a as double=buffer.readDouble();
    var R as double=1.0*(color/65536)/255.0;
    var G as double=1.0*(color/256%256)/255.0;
    var B as double=1.0*(color%256)/255.0;
    IBotaniaFXHelper.wispFX(x,y,z,R,G,B,r,vx,vy,vz,a);
});

events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld=event.world;
    if(event.phase=="START"&&event.side=="SERVER"){
        var dim as int=world.getDimension();
        if(Orb.RegiList has dim){
            for i in Orb.RegiList[dim]{
                i.regiInner(dim);
            }
            Orb.RegiList[dim]=[];
        }
        if(Orb.OrbList has dim){
            //L.say("DanmuCount:"~Orb.OrbList[dim].length);
            var effectiveOrb as int=0;
            for orb in Orb.OrbList[dim]{
                if(orb.isRemoved())continue;
                orb.onLogicTick(world);
                orb.onColliTick(world);
                orb.onRenderTick(world);
                if(orb.isRemoved())continue;
                effectiveOrb+=1;
            }
            if(Orb.OrbList[dim].length>effectiveOrb+300){
                var list as [Orb]=[] as [Orb];
                for orb in Orb.OrbList[dim]{
                    if(!orb.isRemoved())list+=orb;
                }
                Orb.OrbList[dim]=list as [Orb];
            }
        }
    }
});

function LinearOrb(x as double, y as double, z as double,vx as double, vy as double, vz as double, reducedRenderer as bool=true)as Orb{
    if(reducedRenderer)
    return Orb(
        function(world as IWorld, data as IData)as IData{
            return data+{
                "x":data.x.asDouble()+data.vx,
                "y":data.y.asDouble()+data.vy,
                "z":data.z.asDouble()+data.vz
            };
        },x,y,z)
        .useReducedRender().updateData({
            "vx":vx,"vy":vy,"vz":vz
        });
    return Orb(
        function(world as IWorld, data as IData)as IData{
            return data+{
                "x":data.x.asDouble()+data.vx,
                "y":data.y.asDouble()+data.vy,
                "z":data.z.asDouble()+data.vz
            };
        },x,y,z)
        .updateData({
            "vx":vx,"vy":vy,"vz":vz
        });
}

function getV(d as IData)as double[]{
    var dx=(d has"vx")?d.vx.asDouble():d.x.asDouble()-d.lastX.asDouble();
    var dy=(d has"vy")?d.vy.asDouble():d.y.asDouble()-d.lastY.asDouble();
    var dz=(d has"vz")?d.vz.asDouble():d.z.asDouble()-d.lastZ.asDouble();
    return [dx,dy,dz];
}
function setV(d as IData, v as double)as IData{
    var vv=V.scale(V.unify(getV(d)), v);
    return d+{
        "vx":vv[0], "vy":vv[1], "vz":vv[2]
    };
}

/*
events.onEntityLivingUpdate(function(event as crafttweaker.event.EntityLivingUpdateEvent){
    var entity=event.entity;
    var world=entity.world;
    if(world.remote)return;
    if(isNull(entity))return;
    if(isNull(entity.definition))return;
    if(isNull(entity.definition.id))return;
    if(entity.definition.id=="minecraft:zombie"){
        var t0 as double=1.0*((world.getWorldTime()as long)%(1200 as long))/1200;
        var N as int = 7;
        for i in 0 to N{
            var t1=t0*t0*360+360.0/N*i;
            LinearOrb(entity.x,entity.y,entity.z,Math.cos(t1)/10,0.01*Math.sin(t0+360.0/N*i),Math.sin(t1)/10).regi(world);   
        }
    }
    if(entity.isBoss){
        //print(entity.definition.id);
    }
    if(entity.definition.id=="draconicevolution:chaosguardian"){
        
    }
});*/

//Example
/*
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld=event.world;
    var tick=(world.getWorldTime()as long);
    if(world.remote)return;
    if(event.phase=="START")return;
    for entity in world.getEntities(){
        if(isNull(entity))continue;
        if(isNull(entity.definition))continue;
        var id as string=entity.definition.id;
        if(id=="draconicevolution:guardiancrystal"){
            //continue;
            if(entity.nbt.Health.asDouble()==0.0)continue;
            var t as int=(tick%(700 as long))as int;
            if(([0,50,200,300,500,600]as int[])has t){
                var N=50;
                var axis=V.randomUnitVector();
                var angle=Math.random()*360;
                for i in 0 to N{
                    var v=V.scale(V.rot(V.rot(V.VX,V.VY,360.0/N*i),axis,angle),2);
                    LinearOrb(entity.x,entity.y,entity.z,v[0],v[1],v[2])
                    .updateData({
                        "radius":4,
                        "color":0xFF0000,
                        "DeleteRadius":300,
                        "LifeLim":300
                    }).regi(world);  
                }
            }
            else if(t>200 && t<300 || t>600 && t<700){
                if(t%2>0)continue;
                if(t<600 && t%40>10)continue;
                else if(t>600&&t%50>45)continue;
                var player as IPlayer=world.getClosestPlayerToEntity(entity, 300, false);
                var v=2+((t>600)?(0.05*(t%50)):2.5);
                var vv=V.scale(V.unify(V.subtract(V.getPos(player),V.getPos(entity))),v);
                var rr=0.3*((t>600)?(t%50):((t%30)*2));
                LinearOrb(entity.x,entity.y,entity.z,vv[0],vv[1],vv[2])
                .updateData({
                    "radius":7,
                    "color":0xFF00FF,
                    "DeleteRadius":300,
                    "LifeLim":400
                }).regi(world);
                for i in 0 to 2{
                    var vv2=V.rot(vv,V.randomUnitVector(),rr);
                    LinearOrb(entity.x,entity.y,entity.z,vv2[0],vv2[1],vv2[2])
                    .updateData({
                        "radius":3,
                        "color":0xFF0099,
                        "DeleteRadius":300,
                        "LifeLim":400
                    }).regi(world);
                }
            }
            else if(t>300 && t<500){
                if(t%5>0)continue;
                var i=(t- 300);
                var theta0X=Math.cos(1.0*(tick/(300 as long))*113)*360;
                var theta0Y=Math.sin(1.0*(tick/(300 as long))*133)*360;
                var theta0Z=Math.sin(1.0*(tick/(300 as long))*153)*360;
                var omegaX=2.0/3;
                var omegaY=6.0/5;
                var omegaZ=3.0/3;
                var v=1.0;
                var counter as int=0;
                var colors as int[]=[0xCCCCFF,0xAACCFF,0xAAAAFF,0xCCAAFF,0xAAFFFF,0xFFAAFF];
                for t in V.cube{
                    var vv as double[]=V.scale(t,v);
                    var vv2=V.rot(V.rot(V.rot(vv,V.VX,theta0X+omegaX*i),V.VY,theta0Y+omegaY*i),V.VZ,theta0Z+omegaZ*i);
                    LinearOrb(entity.x,entity.y,entity.z,vv2[0],vv2[1],vv2[2])
                    .updateData({
                        "radius":4,
                        "color":colors[counter%6],
                        "DeleteRadius":200,
                        "LifeLim":200
                    }).regi(world);
                    counter+=1;
                }
            }
        }
        else if(id=="draconicevolution:chaosguardian"){
        }
        else if(id=="draconicevolution:guardianprojectile"){
            //L.say("nbt printed");
            //print(entity.nbt as string);
            world.removeEntity(entity);
        }
        //else if(id.contains("draconic"))L.say(id);
    }
});
*/