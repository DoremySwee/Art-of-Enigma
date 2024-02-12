#reloadable
#priority -10000
import scripts.advanced.libs.ParticleGenerator as P;
import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;
import scripts.advanced.libs.Data as D;

import crafttweaker.world.IBlockPos;
import mods.zenutils.NetworkHandler;
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import crafttweaker.util.Math;
import mods.zenutils.UUID;
static BOSSID as string="minecraft:witherDISABLED";
static TESTING_PAHSE as int = 0;
static BOSS_PHASE_LIST as string[] = ["REST","DRAG","CHOP","COMMET","REIMU","CHOPRAND"];

function drag(boss as IEntity,player as IPlayer){
    var vdiff=V.subtract(V.getPos(boss),V.getPos(player));
    if(V.length(vdiff)>50){
        var dis = V.length(vdiff);
        var v = V.scale(vdiff,0.002);
        if(dis>60) v=V.scale(v,(dis- 59)*(dis- 59));
        var pos = V.add(V.getPos(player),v);
        player.motionX=player.motionX*1.01 + v[0];
        player.motionY=player.motionY*1.01 + v[1];
        player.motionZ=player.motionZ*1.01 + v[2];
    }
}
function getData(entity as IEntity, key as string)as IData{
    return entity.nbt.deepGet("ForgeData.doremySweeDanmukuDesign."~key);
}
function getInt(entity as IEntity, key as string)as int{
    var d = entity.nbt.deepGet("ForgeData.doremySweeDanmukuDesign."~key);
    return isNull(d)?0:d.asInt();
}
function setData(entity as IEntity, key as string, value as IData)as void{
    entity.updateNBT(entity.nbt.deepSet(value,"ForgeData.doremySweeDanmukuDesign."~key));
}
function resetRand(boss as IEntity){
    setData(boss,"randTick",boss.world.random.nextInt(2100000000));
    setData(boss,"rand",boss.world.random.nextInt(2100000000));
}
function switchPhase(boss as IEntity, aimPhase as int=-1 as int){
    var a=aimPhase;
    if(aimPhase<0)a = (TESTING_PAHSE>0)?TESTING_PAHSE:boss.world.random.nextInt(BOSS_PHASE_LIST.length);
    for i in 0 to 10{
        print(boss.world.random.nextInt(BOSS_PHASE_LIST.length));
    }
    //print("switchPhase");
    //print(a);
    setData(boss,"phase",a);
    setData(boss,"tick",0);
    resetRand(boss);
}
NetworkHandler.registerServer2ClientMessage("FightAPreparationFX",function(p,b){
    var x0 = b.readDouble();
    var y0 = b.readDouble();
    var z0 = b.readDouble();
    var w = p.world;
    var p0 as double[]= V.add([x0,y0+1,z0],V.scale(V.randomUnitVector(w),0.5));
    var axis = V.randomUnitVector(w);
    var x = V.VX;
    var a1 = V.unify(V.cross(x,axis));
    var a2 = V.unify(V.cross(a1,axis));
    var R = V.randDouble(3,15,w)*1.4;
    var age = 4+w.random.nextInt(10);
    var vs = R/age;
    var N = 53 + w.random.nextInt(80);
    var colors as int[]= [0xFFAAAA,0xCCAACC,0xCCCCAA,0xFFFFFF];
    var color as int= colors[w.random.nextInt(4)];
    for i in 0 to N{
        var theta = 360.0/N*i;
        var vu = V.disc(a1,a2,theta);
        var rd1 = V.randDouble(0.8,1.3,w);
        var rd2 = V.randDouble(0.9,1.1,w);
        var p = V.add(p0,V.scale(vu,R*rd1));
        var v = V.scale(vu,-rd1*rd2*vs);
        var size = V.randDouble(0.7,1.3,w)*V.randDouble(0.7,1.3,w);
        M.createFX(V.asData(p)+V.asData(v,"v")+{"color":color,"a":0.2*age,"r":size});
    }
});
function prepare(boss as IEntity){
    var tick = getInt(boss,"tick");
    if(tick%9==0){
        NetworkHandler.sendToAllAround("FightAPreparationFX",
        boss.x,boss.y,boss.z,80,boss.world.getDimension(),function(b){
            b.writeDouble(boss.x);
            b.writeDouble(boss.y);
            b.writeDouble(boss.z);
        });
    }
}
function vdiff(a as IEntity,b as IEntity)as double[]{
    return V.subtract(V.getPos(b),V.getPos(a));
}
function move1(boss as IEntity,player as IPlayer,coef as double=1){
    var w = boss.world;
    var vdiff=V.subtract(V.getPos(boss),V.getPos(player));
    var v = V.stretch(V.eulaAng(V.unify(vdiff),V.randomUnitVector(w)),[0.3*coef,-0.1,0.3*coef]);
    boss.motionX=v[0];
    boss.motionY=v[1]+0.2;
    boss.motionZ=v[2];
}
function f1(boss as IEntity,player as IPlayer){
    var w = boss.world;
    var tick=getInt(boss,"totalTick");
    for i,vert in V.DODECA_HEDRON.vertexes{
        var colors as int[]= [0xFF6666,0x6666FF,0xFFFF00,0xFFAAAA];
        if(tick%3!=0)break;
        var v0=V.add(V.scale(V.eulaAng(vert,[tick*0.15,tick*0.5,tick*0.27]),0.3),V.scale([boss.motionX,boss.motionY,boss.motionZ],0.5));
        var accl=V.stretch(V.eulaAng(vert,[tick*0.5,tick*2,tick*0.7]),[0.03,0,0.03]);
        var dd=V.asData(V.getPos(boss))+V.asData(v0,"v")+V.asData(accl,"a")+
            {"renderTime":5,"effectiveRadius":80,"color":colors[i%4],"size":V.randDouble(2.0,3.0,w)}as IData;
        P.AcclOrb.create(w,dd);
    }
    var vdiff=V.subtract(V.getPos(boss),V.getPos(player));
    move1(boss,player,4);
}
function randomUnitVectorFromInt(seed as int,mod as int)as double[]{
    var v1 as double[]=[0.0+seed%mod,0.0+seed/mod/mod%mod,0.0+seed/mod%mod];
    var v2 as double[]=V.subtract(V.scale(v1,2.0/mod),[-1.0,-1.0,-1.0]);
    return V.unify(v2);
}
function f2(boss as IEntity,player as IPlayer){
    var w = boss.world;
    var rt=getInt(boss,"rand");
    var tick=getInt(boss,"tick");
    if(tick%50==0){
        resetRand(boss);
    }
    for i in 0 to 2{
        if(tick%50>10){
            var colors as int[]= [0xFF6666,0x6666FF,0xFFFF00,0xFFAAAA];
            var v1 as double[]=[0.0+rt%1000,0.0+rt/1000000%1000,0.0+rt/1000%1000];
            var v2=V.subtract(v1,[500,500,500]);
            var v0=V.subtract(V.getPos(player),V.getPos(boss));
            var v3=V.rotate(v0,v2,(0.0+tick- 30)*5);
            var v4=V.rotate(v3,V.randomUnitVector(w),0);
            var v5=V.scale(V.unify(v4),0.1+0.1*tick/100);
            var a0=V.add(V.scale(v0,0.001),v5);
            var dd=V.asData(V.getPos(boss))+V.asData(V.scale(v5,-3),"v")+V.asData(V.scale(a0,0.6),"a")+
                {"renderTime":5,"effectiveRadius":80,"color":colors[rt%4],"size":V.randDouble(3.0,6.0,w),"renderInterval":1}as IData;
            var dd2=V.asData(V.getPos(boss))+V.asData(V.scale(v5,3),"v")+V.asData(V.scale(a0,-0.6),"a")+
                {"renderTime":5,"effectiveRadius":80,"color":colors[(rt+2)%4],"size":V.randDouble(3.0,6.0,w),"renderInterval":1}as IData;
            P.AcclOrb.create(w,dd);
            P.AcclOrb.create(w,dd2);
        }
        tick+=25;
        rt+=1283765;
        //print("f2");
        //print(tick);
    }
    move1(boss,player,1.7);
}
static f3d as P.FXGenerator=P.LinearOrb.copy("FightAf3d");
f3d.updateDefaultData({"lifeLimit":40,"renderTime":5,"renderInterval":1,"effectiveRadius":140,"color":0xFFFFFF,"colli":false})
    .addTick(function(world as IWorld,data as IData)as IData{
        var pos = V.readFromData(data);
        var newDat as IData = IData.createEmptyMutableDataMap();
        var life as int = data.life.asInt();
        if(life%5==0){
            var v = V.unify(V.readFromData(data,"v"));
            var x = V.rot(v,V.randomUnitVector(world),V.randDouble(75.0,105.0,world));
            var pl = world.getClosestPlayer(pos[0],pos[1],pos[2],200,false);
            if(!isNull(pl) && V.randDouble(0,1,world)<0.3){
                x=V.unify(V.subtract(V.getPos(pl),pos));
                if(V.randDouble(0,1,world)<0.9)x=V.rot(x,V.randomUnitVector(world),V.randDouble(-15,15,world)+V.randDouble(-15,15,world));
            }
            var y = V.rot(v,V.randomUnitVector(world),V.randDouble(75.0,105.0,world));
            var dt = V.randDouble(60,300,world);
            var colors as int[]= [0x0000FF,0xAAAAFF,0xFF77FF,0xFF00FF];
            var color as int= colors[world.random.nextInt(4)];
            for i in 0 to 40+world.random.nextInt(3)*10{
                var t = 360.0/70*i;
                var v0 = V.disc(x,y,t);
                var a = V.scale(V.disc(x,y,t),0.05);
                var size = V.randDouble(1.5,3.0,world);
                P.AcclOrb.create(world,V.asData(pos)+V.asData(v0,"v")+V.asData(a,"a")+{
                    "lifeLimit":120,"renderSize":size,"size":size*1.2,"color":color,"renderTime":3,"renderInterval":1,"effectiveRadius":140
                });
            }
        }
        return data;
    })
    .setRender(function(player as IPlayer, data as IData)as void{
        var world as IWorld=player.world;
        for i in 0 to 7{
            M.createFX(
                data+{"r":data.size,"a":4}+V.asData(V.scale(V.randomUnitVector(world),0.07),"v")+
                V.asData(V.add(V.scale(V.randomUnitVector(world),0.5),V.readFromData(data)))
            );
        }
    }).regi();
function f3(boss as IEntity,player as IPlayer){
    var w = boss.world;
    var world = boss.world;
    var rd=getInt(boss,"rand");
    var tick=getInt(boss,"tick");
    if(V.length(vdiff(boss,player))>10){
        prepare(boss);
    }
    if(tick>60){
        if(tick%23==0){
            var p0 = V.add(V.scale(V.unify(V.stretch(V.subtract(V.getPos(boss),V.getPos(player)),[1.0,0.0,1.0])),40),V.add([0,50,0],V.add(V.getPos(boss),V.stretch(V.disc(V.VX,V.VY,V.randDouble(0,360,w)),[50.0,10.0,50.0]))));
            var v0 = V.add(V.scale(V.randomUnitVector(w),0.3),[0.0,-4.0,0.0]);
            f3d.create(world,V.asData(v0,"v")+V.asData(p0));
        }
    }
    move1(boss,player,-0.1);
}
static f4d as P.FXGenerator=P.LinearOrb.copy("FightAf4d");
f4d.updateDefaultData({"tier":2,"lifeLimit":40,"renderTime":5,"renderInterval":1,"effectiveRadius":80,"color":0xFFFFFF,"size":1.5,"renderSize":3.0})
    .addTick(function(world as IWorld,data as IData)as IData{
        var pos = V.readFromData(data);
        var pl as IPlayer = world.getClosestPlayer(pos[0],pos[1],pos[2],300,false);
        var newDat as IData = IData.createEmptyMutableDataMap();
        var life as int = data.life.asInt();
        if(!isNull(pl)){
            var v0 = V.readFromData(data,"v");
            var coef = (life>20)?0.0:(20.0-life)/(21.0-life);
            var v = V.scale(v0,coef);
            newDat = V.asData(v,"v");
            var tier = data.tier.asInt();
            if(life>30){
                var c = tier>1?0xFF0000:0xFF00FF;
                newDat = {"color":c};
            }
            if(life>38){
                var pdiff = V.subtract(V.getPos(pl),pos);
                var v = V.scale(V.unify(pdiff),3.5);
                if(tier>1){

                    f4d.create(world,{"tier":tier - 1,"color":0xFF0000}+V.asData(v,"v")+V.asData(pos));
                }
                else{
                    P.LinearOrb.create(world,data+V.asData(pos)+V.asData(v,"v")+{"lifeLimit":100});
                }
            }
        }
        //print(newDat);
        return data+newDat;
    }).regi();
function f4(boss as IEntity,player as IPlayer){
    //梦想天生
    var w = boss.world;
    var rd=getInt(boss,"rand");
    var tick=getInt(boss,"tick");
    if(tick%50==0){
        resetRand(boss);
    }
    if(tick%80<35){
        if(tick%4==0){
            for i in 1 to 7{
                var coef = 1.2*i;
                var pd = V.subtract(V.getPos(player),V.getPos(boss));
                var axis = randomUnitVectorFromInt(rd,1000);
                var v0 = V.unify(V.cross(pd,axis));
                var v1 = V.unify(V.cross(v0,pd));
                var v = V.scale(V.disc(v0,v1,0.3*tick*(rd%34+3)),coef);
                //M.shout(V.asString(v));
                f4d.create(w,V.asData(v,"v")+V.asData(V.getPos(boss)));
            }
        }
    }
    else{
        prepare(boss);
    }
    move1(boss,player);
}
function f5(boss as IEntity,player as IPlayer){
    var w = boss.world;
    var rt=getInt(boss,"rand");
    var tick=getInt(boss,"tick");
    if(tick%50==0){
        resetRand(boss);
    }
    for i in 0 to 5{
        if(tick%50>10){
            var colors as int[]= [0xFF6666,0x6666FF,0xFFFF00,0xFFAAAA];
            var v1 as double[]=[0.0+rt%1000,0.0+rt/1000000%1000,0.0+rt/1000%1000];
            var v2=V.subtract(v1,[500,500,500]);
            var v0=randomUnitVectorFromInt(rt,794);
            var v3=V.rotate(v0,v2,(0.0+tick- 30)*5);
            var v5=V.scale(V.unify(v3),0.1+0.1*tick/100);
            var a0=V.add(V.scale(v0,0.001),v5);
            var dd=V.asData(V.getPos(boss))+V.asData(V.scale(v5,-1.5),"v")+V.asData(V.scale(a0,0.3),"a")+
                {"renderTime":5,"effectiveRadius":80,"color":colors[rt%4],"size":V.randDouble(3.0,6.0,w),"renderInterval":1}as IData;
            P.AcclOrb.create(w,dd);
        }
        tick+=25;
        rt+=1283765;
        //print("f2");
        //print(tick);
    }
    move1(boss,player,0.5);
}
function tick(boss as IEntity,player as IPlayer)as void{
    drag(boss,player);
    var w = boss.world;
    if(w.remote)return;
    //ticking
        //Check if it's repeated ticking, avoid multiplayer causing too many tickings.
        var t00=getData(boss,"worldTime");
        var t01=-1;
        var t02=w.getWorldTime();
        if(!isNull(t00))t01=t00.asInt();
        if(t01==t02)return;
        setData(boss,"worldTime",t02 as IData);

        //GetBossTicking&Phase
        var phase=getInt(boss,"phase");
        var tick=getInt(boss,"tick");
        var totalTick=getInt(boss,"totalTick");
        var randTick=getInt(boss,"randTick");
        setData(boss,"tick",tick+1);
        setData(boss,"totalTick",totalTick+1);
        setData(boss,"randTick",randTick+1);
        setData(boss,"phase",phase);
    //print("tick-phase");
    //print(phase);
    //Attacks
    if(tick>400)switchPhase(boss,0);
    if(phase==0){ //Rest
        prepare(boss);
        if(tick>50){
            //print("tick-phase=0");
            switchPhase(boss);
        }
    }
    if(phase==1){
        f5(boss,player);
    }
    if(phase==2){
        f2(boss,player);
        if(tick>250)switchPhase(boss,0);
    }
    if(phase==3){
        f3(boss,player);
    }
    if(phase==4){
        f4(boss,player);
    }
    if(phase==5){
        f5(boss,player);
    }
    //print("tick");
    //print(tick);
}
events.onPlayerTick(function(event as crafttweaker.event.PlayerTickEvent){
    var player=event.player;
    var world as IWorld=player.world;
    if(event.phase!="START")return;
    for entity in world.getEntities(){
        if(isNull(entity.definition))continue;
        if(entity.definition.id==BOSSID){
            var vdiff=V.subtract(V.getPos(entity),V.getPos(player));
            if(V.dot(vdiff,vdiff)<100*100){
                tick(entity,player);
            }
        }
    }
});