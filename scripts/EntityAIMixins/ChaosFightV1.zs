#loader crafttweaker reloadableevents
//#norun
import scripts.EntityAIMixins.DanmuAttack as D;
import scripts.EntityAIMixins.MiscLib as M;
import scripts.LibReloadable as L;
import scripts.libs.Vector3D as V;

import crafttweaker.world.IBlockPos;
import mods.zenutils.NetworkHandler;
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import mods.ctutils.utils.Math;
import mods.zenutils.UUID;

static crystalID as string="draconicevolution:guardiancrystal";
static dragonID as string="draconicevolution:chaosguardian";
static projectileID as string="draconicevolution:guardianprojectile";

static difficulty as string="Ultra";
static testingLastFightMode as bool=false;

function checkID(entity as IEntity, id as string)as bool{
    if(isNull(entity))return false;
    if(isNull(entity.definition))return false;
    return entity.definition.id==id;
}

function isCrystalAlive(entity as IEntity)as bool{
    return checkID(entity, crystalID) && entity.nbt.Health.asDouble()>0.0;
}

function isCrystalOuter(entity as IEntity)as bool{
    var dx=entity.x-(500+entity.x)/10000*10000;
    var dz=entity.z-(500+entity.z)/10000*10000;
    //print(dx);
    //print(dz);
    if(dx*dx+dz*dz<3600)return false;
    else return true;
}

function getEntitiesAround(world as IWorld, centre as double[], range as double)as [IEntity]{
    return world.getEntitiesInArea(IBlockPos.create(
        (centre[0]-range) as int, (centre[1]-range) as int, (centre[2]-range) as int
    ), IBlockPos.create(
        (centre[0]+range) as int, (centre[1]+range) as int, (centre[2]+range) as int
    ));
}

function getHomePos(dragon as IEntity)as double[]{
    if(!checkID(dragon,dragonID))return V.V000;
    return [
        0.0+dragon.nbt.HomeXCoord.asInt(),
        0.0+dragon.nbt.HomeYCoord.asInt(),
        0.0+dragon.nbt.HomeZCoord.asInt()
    ];
}
function getInnerCrystals(dragon as IEntity)as IEntity[]{
    var world as IWorld=dragon.world;
    if(!checkID(dragon,dragonID))return [];
    var result as IEntity[]=[] as IEntity[];
    for i in 0 to 7{
        var R=45.0;
        var theta=360.0/7*i;
        var p as double[]=V.add(getHomePos(dragon),V.rot([0.0,0.0,R],V.VY,theta));
        p[1]=111;
        var t as IEntity[]=[] as IEntity[];
        for j in getEntitiesAround(world,p,10){
            if(checkID(j,crystalID))t+=j;
        }
        if(t.length!=1){
            //L.say("ERROR: Crystal not found / excessive crystals found");
            //L.say("pos:"~p[0]~","~p[1]~","~p[2]);
        }
        else{
            result+=t[0];
        }
    }
    return result;
}
function getOuterCrystals(dragon as IEntity)as IEntity[]{
    var world as IWorld=dragon.world;
    if(!checkID(dragon,dragonID))return [];
    var result as IEntity[]=[] as IEntity[];
    for i in 0 to 14{
        var R=90.0;
        var theta=360.0/14*i;
        var p as double[]=V.add(getHomePos(dragon),V.rot([0.0,0.0,R],V.VY,theta));
        p[1]=131;
        var t as IEntity[]=[] as IEntity[];
        for j in getEntitiesAround(world,p,10){
            if(checkID(j,crystalID))t+=j;
        }
        if(t.length!=1){
            //L.say("ERROR: Crystal not found / excessive crystals found");
            //L.say("pos:"~p[0]~","~p[1]~","~p[2]);
        }
        else{
            result+=t[0];
        }
    }
    return result;
}
function getCrystals(dragon as IEntity)as IEntity[]{
    var result as IEntity[]=getInnerCrystals(dragon);
    for i in getOuterCrystals(dragon){
        result+=i;
    }
    return result;
}
static FightModes as string[]=[
    "Soaring","Throwing","SkyAttack","RegPolyHedron1","Rotating1"
    //"Rotating1"
];
static fightModeCounter as int[]= [-1 as int]as int[]; //defalut:-1 (random)    Positive Value for testing. This variable breaks down if multiple chaos guardian fights take place simultaneously 
function SwitchFightMode(dragon as IEntity, mode as string = "random"){
    if(FightModes has mode){
        M.setData(dragon,"FightMode", mode);
        M.setData(dragon,"timerUnderFightMode",0);
    }
    else if(fightModeCounter[0]>=0){
        //L.say(fightModeCounter[0]);
        SwitchFightMode(dragon, FightModes[fightModeCounter[0]%FightModes.length]);
        fightModeCounter[0]=fightModeCounter[0]+1;
        //L.say(fightModeCounter[0]);
    }
    else{
        if(testingLastFightMode)SwitchFightMode(dragon, FightModes[FightModes.length- 1]);
        else SwitchFightMode(dragon, FightModes[dragon.world.random.nextInt(FightModes.length)]);
    }
}
function dragonPlaySound(dragon as IEntity, soundName as string, volume as int = 100, pitch as double = 0){
    var world = dragon.world;
    for player in world.getAllPlayers(){
        var t1=V.subtract(V.getPos(player),V.getPos(dragon));
        if(V.dot(t1,t1)<250000){
            var command = "playsound "~soundName~" hostile "~player.name~" "~player.x~" "~player.y~" "~player.z~" "~volume~" "~pitch~" "~(volume>10?1:0.1*volume);
            print(command);
            L.executeCommand(command);
        }
    }
}
static FireSound as string="minecraft:entity.enderdragon.shoot";
static FireSound1 as string="minecraft:entity.wither.shoot";
static FireSound2 as string="minecraft:entity.ghast.shoot";
static Explode as string="minecraft:entity.generic.explode";
static Growl as string="minecraft:entity.enderdragon.growl";
static WitherSpawn as string="minecraft:entity.wither.spawn";
static Lightning as string="minecraft:entity.lightning.thunder";

static Attunement as string="astralsorcery:attunement";
static AttunementDone as string="astralsorcery:craftfinish";
events.onEntityJoinWorld(function(event as crafttweaker.event.EntityJoinWorldEvent){
    var world as IWorld=event.world;
    if(world.remote)return;
    if(checkID(event.entity,projectileID))event.cancel();
    //else L.say(event.entity.definition.id);
});
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld=event.world;
    if(world.remote || event.phase!="START" || event.side=="CLIENT")return;
    for entity in world.getEntities(){
        if(checkID(entity,projectileID) && !(entity.nbt has "doremySweeDanmukuDesign")){
            //L.say(entity.nbt.Type);
            world.removeEntity(entity);
        }
        if(checkID(entity,dragonID)){
            var dragon=entity;
            dragon.updateNBT({"Behaviour":"ROAMING"});
            var time0 as int=M.getIntFromData(dragon,"time");
            M.setData(entity,"time",(time0+1) as IData);
            var time=M.getIntFromData(dragon,"timerUnderFightMode");
            M.setData(entity,"timerUnderFightMode",(time+1) as IData);
            time0-=time;
            var mode=M.getStringFromData(dragon,"FightMode");
            var player as IPlayer=world.getClosestPlayerToEntity(dragon, 1000, false);
            if(isNull(player))continue;



            var diff as string= difficulty;
            if(mode=="Soaring" || mode==""){
                if(time<300){
                    var ratio as double=({"Ultra":2.0,"Lunatic":1.3,"Hard":1.0,"Normal":0.6,"Easy":0.3}as double[string])[diff]as double;
                    var ratio2 as double=({"Ultra":2.0,"Lunatic":1.3,"Hard":0.8,"Normal":1.0,"Easy":0.8}as double[string])[diff]as double;
                    var PartialFrameNum as int=({"Ultra":3,"Lunatic":2,"Hard":1,"Normal":1,"Easy":1}as int[string])[diff]as int;
                    if(time%35==0)dragonPlaySound(dragon,Growl);
                    for iii in 0 to PartialFrameNum{
                        var i= 1.0/PartialFrameNum*iii + time%1000;
                        var theta0X=L.cosfR(1.0*(time0/(300 as long))*113)*360;
                        var theta0Y=L.sinfR(1.0*(time0/(300 as long))*133)*360;
                        var theta0Z=L.sinfR(1.0*(time0/(300 as long))*153)*360;
                        var omegaX=(2.5+0.5*L.sinfR(1.0*(time0/(300 as long))*163))*ratio;
                        var omegaY=(6.0+1.3*L.sinfR(1.0*(time0/(300 as long))*173))*ratio;
                        var omegaZ=(3.0+0.5*L.sinfR(1.0*(time0/(300 as long))*183))*ratio;
                        var v=(0.004*i+0.4+0.15*L.sinf(i))*ratio2;
                        var counter as int=0;
                        var colors as int[]=[0xFFCCCC,0xFFCCAA,0xFFAACC,0xFFAAAA,0xFF7777,0xFF77AA];
                        for t in V.dodecaHedron{
                            var vv as double[]=V.scale(t,v);
                            var vv2=V.rot(V.rot(V.rot(vv,V.VX,theta0X+omegaX*i),V.VY,theta0Y+omegaY*i),V.VZ,theta0Z+omegaZ*i);
                            D.LinearOrb(entity.x,entity.y,entity.z,vv2[0],vv2[1],vv2[2])
                            .updateData({
                                "radius":5.5,
                                "color":colors[counter%6],
                                "DeleteRadius":200,
                                "LifeLim":200
                            }).regi(world);
                            counter+=1;
                        }
                    }
                }
                if(time==300){
                    dragonPlaySound(dragon,WitherSpawn);
                    for crystal in getOuterCrystals(dragon){
                        if(!isCrystalAlive(crystal))continue;
                        var N=({"Ultra":30,"Lunatic":30,"Hard":50,"Normal":30,"Easy":20}as int[string])[diff]as int;
                        var m=({"Ultra":3, "Lunatic":2, "Hard":1, "Normal":1, "Easy":1}as int[string])[diff]as int;
                        var accl=({"Ultra":0.05, "Lunatic":0.05, "Hard":0.03, "Normal":0.02, "Easy":0.01}as double[string])[diff]as double;
                        var v0=({"Ultra":1.5, "Lunatic":1.0, "Hard":0.3, "Normal":0.3, "Easy":0.04}as double[string])[diff]as double;
                        for iii in 0 to m{
                            var axis=V.randomUnitVector();
                            var angle=Math.random()*360;
                            var colors as int[]=[0xFF0000, 0xFF3300, 0xFF7700];
                            for i in 0 to N{
                                var p0=V.getPos(crystal);
                                //L.say(accl);
                                for j in 0 to 3{
                                    var v=V.scale(V.rot(V.rot(V.VX,V.VY,360.0/N*i),axis,angle),v0);
                                    var p=V.add(p0,V.scale(v,-14.0*j));
                                    D.LinearOrb(p[0],p[1],p[2],v[0],v[1],v[2])
                                    .updateData({
                                        "radius":5,
                                        "color":colors[iii] as int,
                                        "DeleteRadius":300,
                                        "LifeLim":300,
                                        "acclx":V.scale(V.unify(v),accl*(1-iii*2))[0],
                                        "accly":V.scale(V.unify(v),accl*(1-iii*2))[1],
                                        "acclz":V.scale(V.unify(v),accl*(1-iii*2))[2]
                                    })
                                    .addLogicTick(function(world as IWorld, d as IData)as IData{
                                        var v=V.add(D.getV(d),[d.acclx,d.accly,d.acclz]);
                                        return d+{"vx":v[0],"vy":v[1],"vz":v[2]};
                                    })
                                    .regi(world);
                                }
                            }
                        }
                    }
                }
                if(time==305){
                    dragonPlaySound(dragon,Lightning);
                }
                if(time==310){
                    dragonPlaySound(dragon,Explode);
                }
                if(time>=400){
                    SwitchFightMode(dragon);
                }
            }
            else if(mode=="Throwing"){
                //L.say(time);
                if(time>=320){
                    SwitchFightMode(dragon);
                }
                var times=[50,80,100,120,140,160,170,180,190,200]as int[];
                if(times has time+30){
                    dragonPlaySound(dragon,FireSound);
                    var N=({"Ultra":20,"Lunatic":30,"Hard":15,"Normal":10,"Easy":7}as int[string])[diff]as int;
                    var m=({"Ultra":2,"Lunatic":1,"Hard":1,"Normal":1,"Easy":1}as int[string])[diff]as int;
                    var intv=({"Ultra":8,"Lunatic":8,"Hard":10,"Normal":15,"Easy":30}as int[string])[diff]as int;
                    var rv=({"Ultra":13.0, "Lunatic":9.0, "Hard":7.3, "Normal":5.3, "Easy":2.4}as double[string])[diff]as double;
                    var axis=V.randomUnitVector();
                    var angle=world.random.nextDouble(0,360);
                    var color=0xCC00FF;
                    for i in 0 to m{
                        var vCentre=V.scale(V.unify(V.subtract(V.getPos(player),V.getPos(dragon))),1.7);
                        if(i==1)vCentre=V.scale(vCentre,-1.0);
                        for i in 0 to N{
                            D.Orb(function(world as IWorld, d as IData)as IData{
                                var d1 as IData={
                                    "x0":d.x0+d.vx0,"y0":d.y0+d.vy0,"z0":d.z0+d.vz0,
                                    "radius":0.1*d.orbitRadius, "theta":d.theta+0.6,
                                    "orbitRadius":(d.orbitRadius<100)?(d.orbitRadius+0.4):d.orbitRadius,
                                };
                                var axis as double[]=[d.axisx,d.axisy,d.axisz];
                                var pos=V.add([d1.x0,d1.y0,d1.z0],V.rot(V.rot([d.orbitRadius,0,0],V.VY,d.theta),axis,d.rotAng));
                                var d2 as IData={
                                    "x":pos[0],"y":pos[1],"z":pos[2]
                                };
                                var dp=D.getV(d);
                                var r1=d.rv; var r2=d.rv- 0.9;
                                var vv=V.subtract(V.scale(dp,r1),V.scale([d.vx0,d.vy0,d.vz0],r2));
                                if(d.orbitRadius>10 && d.life%d.intv == 0 && d.life<200){
                                    D.LinearOrb(pos[0],pos[1],pos[2],vv[0],vv[1],vv[2])
                                    .updateData({
                                        "color":0x5555FF,"DeleteRadius":300,"LifeLim":300/(1+V.length(vv)),"radius":3.0+V.length(vv)*0.3
                                    }).regi(world);
                                }
                                return d+d1+d2;
                            },dragon.x,dragon.y,dragon.z)
                            .updateData({
                                "x0":dragon.x,"y0":dragon.y,"z0":dragon.z,
                                "vx0":vCentre[0],"vy0":vCentre[1],"vz0":vCentre[2],
                                "color":color,"DeleteRadius":300,"LifeLim":300,
                                "axisx":axis[0],"axisy":axis[1],"axisz":axis[2],
                                "orbitRadius":4.5,"theta":360.0/N*i,"rotAng":angle,
                                "intv":intv, "rv":rv
                            }as IData).regi(world);
                        }
                    }
                }
                if(times has time+28 || times has time+26){
                    dragonPlaySound(dragon,FireSound);
                }
            }
            else if(mode=="SkyAttack"){
                var times = [40,60,80,100,110,120,130,140,150,160,170]as int[];
                if(times has time){
                    var p0 as double[][]=[V.getPos(dragon)];
                    for i in getCrystals(dragon){
                        p0+=V.getPos(i);
                    }
                    for i in p0{
                        var v=V.rot([0.0,9.0,0.0],V.randomUnitVector(),world.random.nextDouble(0,40));
                        var v2=({"Ultra":12.0, "Lunatic":12.0, "Hard":9.3, "Normal":7.3, "Easy":5.3}as double[string])[diff]as double;
                        var v3=({"Ultra":4.0, "Lunatic":2.5, "Hard":2.0, "Normal":1.3, "Easy":0.7}as double[string])[diff]as double;
                        var intv=({"Ultra":5,"Lunatic":7,"Hard":10,"Normal":10,"Easy":10}as int[string])[diff]as int;
                        D.LinearOrb(i[0],i[1],i[2],v[0],v[1],v[2])
                            .addLogicTick(function(world as IWorld,d as IData)as IData{
                                var vt0=V.scale(D.getV(d),0.1);
                                D.LinearOrb(d.x,d.y,d.z,vt0[0],vt0[1],vt0[2]).updateData({
                                    "color":d.color,"LifeLim":3,"DeleteRadius":d.DeleteRadius,"radius":d.radius
                                }).regi(world);
                                if(d.life==20){
                                    var player=world.getClosestPlayer(d.x,d.y,d.z,700,false);
                                    var v=V.V000;
                                    if(!isNull(player))v=V.scale(V.unify(V.subtract(V.getPos(player),[d.x,d.y,d.z])),d.v2);
                                    D.LinearOrb(d.x,d.y,d.z,v[0],v[1],v[2])
                                        .addLogicTick(function(world as IWorld,d as IData)as IData{
                                            var vt0=V.scale(D.getV(d),0.1);
                                            D.LinearOrb(d.x,d.y,d.z,vt0[0],vt0[1],vt0[2]).updateData({
                                                "color":d.color,"LifeLim":3,"DeleteRadius":d.DeleteRadius,"radius":d.radius
                                            }).regi(world);
                                            if(d.life%d.intv==0){
                                                var axis=D.getV(d);
                                                var t=V.VX;
                                                if(V.angle(V.VX,axis)<10)t=V.VY;
                                                var r=V.scale(V.unify(V.cross(t,axis)),d.v3);
                                                var N=Math.min(30,10+d.v3*10 as int);
                                                for i in 0 to N{
                                                    var v=V.rot(r,axis,360.0/N*i);
                                                    D.LinearOrb(d.x,d.y,d.z,v[0],v[1],v[2])
                                                        .updateData({
                                                            "color":0xFF9900,"DeleteRadius":300,"LifeLim":20,"radius":3
                                                        }).regi(world);
                                                }
                                            }
                                            return d;
                                        }).updateData({
                                            "color":0xFFFF00,"DeleteRadius":300,"LifeLim":Math.min(100,10+400/(1+V.length(D.getV(d)))),"radius":7,"v3":d.v3,"intv":intv
                                        }).regi(world);
                                    return d+{"removal":true};
                                }
                                return d;
                            }).updateData({
                                "color":0xFF5555,"DeleteRadius":3000,"LifeLim":21,"radius":7,"v2":v2,"v3":v3,"intv":intv
                            }).regi(world);
                    }
                }
                if(times has time- 20){
                    dragonPlaySound(dragon, Lightning);
                }
                if(time>250){
                    SwitchFightMode(dragon);
                }
            }
            else if(mode=="RegPolyHedron1"){
                dragon.updateNBT({"Behaviour":"CHARGING"});

                var omegaR=({"Ultra":3.0, "Lunatic":2.0, "Hard":1.0, "Normal":0.7, "Easy":0.4}as double[string])[diff]as double;
                var vpara1=({"Ultra":2.3, "Lunatic":1.8, "Hard":1.5, "Normal":1.0, "Easy":0.7}as double[string])[diff]as double;
                var vpara2=({"Ultra":0.005, "Lunatic":0.004, "Hard":0.003, "Normal":0.002, "Easy":0.001}as double[string])[diff]as double;
                var intv=[20,15,10,3,1]as int[];
                if(diff=="Ultra")intv=[16,12,7,3,1]as int[];
                if(diff=="Hard")intv=[20,20,14,5,2]as int[];
                if(diff=="Normal")intv=[25,20,14,10,5]as int[];
                if(diff=="Easy")intv=[50,30,20,15,15]as int[];
                var sides=V.dodecaHedronSides;
                var vertexes=V.dodecaHedron;
                if(diff=="Easy" || diff=="Normal"){
                    sides=V.octaHedronSides;
                    vertexes=V.octaHedron;
                }
                var theta0X=L.cosfR(1.0*(time0/(300 as long))*113)*360;
                var theta0Y=L.sinfR(1.0*(time0/(300 as long))*133)*360;
                var theta0Z=L.sinfR(1.0*(time0/(300 as long))*153)*360;
                var omegaX=(0.6+0.2*L.sinfR(1.0*(time0/(300 as long))*163))*omegaR;
                var omegaY=(1.0+0.6*L.sinfR(1.0*(time0/(300 as long))*173))*omegaR;
                var omegaZ=(0.5+0.3*L.sinfR(1.0*(time0/(300 as long))*183))*omegaR;
                if(time>350){
                    SwitchFightMode(dragon);
                }
                if(time>=50 && time<150 && time%intv[0]==50%intv[0] || time>=150 && time<210 && time%intv[1]==0 || time>=210 && time<=280 && time%intv[2]==0 || time>280 && time<290 && time%intv[3]==0 || time>290 && time<=300 && time%intv[4]==0){
                    dragonPlaySound(dragon,WitherSpawn);
                    for side in sides{
                        var A = vertexes[side[0]];
                        var B = vertexes[side[1]];
                        var N = 17;
                        var r = 5.0;
                        if(time==50) {N=25; r=3.0;}
                        if( time>280 && time<290 && time%3==0 || time>290 && time<300) {N=9;r=6.0;}
                        for j in 0 to N{
                            var v = V.eulaAng(V.scale(V.combine(A,B,1.0/N*j),vpara1 + vpara2*time ),theta0X+omegaY*time,theta0X+omegaY*time,theta0Z+omegaZ*time);
                            D.LinearOrb(dragon.x,dragon.y,dragon.z,v[0],v[1],v[2])
                                .updateData({
                                    "color":0x00FF00,"DeleteRadius":300,"LifeLim":100,"radius":r
                                })
                                .regi(world);
                        }
                    }
                }
                if(time>50 && time<300){
                    for i in vertexes{
                        var v = V.eulaAng(V.scale(i,vpara1 + vpara2*time ),theta0X+omegaY*time,theta0X+omegaY*time,theta0Z+omegaZ*time);
                        D.LinearOrb(dragon.x,dragon.y,dragon.z,v[0],v[1],v[2])
                            .updateData({
                                "color":0xFFFF00,"DeleteRadius":300,"LifeLim":100,"radius":4
                            })
                            .regi(world);
                    }
                }
            }
            else if(mode=="Rotating1"){
                var omegaR=1.3*({"Ultra":1.3, "Lunatic":1.0, "Hard":0.5, "Normal":0.2, "Easy":0.1}as double[string])[diff]as double;
                var omegaX=(0.6+0.2*L.sinfR(1.0*(time0/(300 as long))*163))*omegaR;
                var omegaY=(1.0+0.6*L.sinfR(1.0*(time0/(300 as long))*173))*omegaR;
                var omegaZ=(0.5+0.3*L.sinfR(1.0*(time0/(300 as long))*183))*omegaR;
                if(time>420){
                    SwitchFightMode(dragon);
                }
                else if(time<70){
                    for iiii in 0 to (time%3==0)?2:1{
                        if(time==5){
                            var pd=V.getPos(dragon);
                            var ph=getHomePos(dragon);
                            var v=V.scale(V.subtract(ph,pd),1.0/85);
                            D.LinearOrb(dragon.x,dragon.y,dragon.z,v[0],v[1],v[2])
                                .updateData({
                                    "radius0":60,"color":0xFF7700,"LifeLim": 90-time,
                                    "omegaX":omegaX,"omegaY":omegaY,"omegaZ":omegaZ, "colli":false
                                })
                                .addLogicTick(function(world as IWorld, data as IData)as IData{
                                    var rl=data.LifeLim.asInt()-data.life.asInt();
                                    if(rl==20){
                                        return data+{"vx":0,"vy":0,"vz":0};
                                    }
                                    if(rl==3){
                                        D.Orb(function(world as IWorld, data as IData)as IData{
                                            var x0 = 0.0 + (1000+data.x.asDouble())/10000*10000;
                                            var z0 = 0.0 + (1000+data.z.asDouble())/10000*10000;
                                            var y0 = 80.0;
                                            var dx = data.x1.asDouble()-x0;
                                            var dy = data.y1.asDouble()-y0;
                                            var dz = data.z1.asDouble()-z0;
                                            var d = [dx,dy,dz]as double[];
                                            var rotRatio = L.sinf(Math.min(data.life.asInt()*2 , 90)) *2;
                                            var thetaX = data.thetaX.asDouble() + data.omegaX.asDouble() * rotRatio;
                                            var thetaY = data.thetaY.asDouble() + data.omegaY.asDouble() * rotRatio;
                                            var thetaZ = data.thetaZ.asDouble() + data.omegaZ.asDouble() * rotRatio;
                                            var p = V.add([x0,y0,z0],V.eulaAng(d,thetaX,thetaY,thetaZ));
                                            return data + {
                                                "x":p[0], "y":p[1], "z":p[2],
                                                "thetaX":thetaX, "thetaY":thetaY, "thetaZ":thetaZ
                                            };
                                        },data.x,data.y,data.z)
                                        .setRenderTick(
                                            function(world as IWorld, d as IData)as void{
                                                if(d.removal.asBool())return;
                                                if(!world.remote){
                                                    for iii in 0 to 3{
                                                        NetworkHandler.sendToAllAround("AOE_DanmuAttack_Orb",
                                                            d.x,d.y,d.z,d.DeleteRadius,
                                                            world.getDimension(),
                                                            function(buffer)as void{
                                                                //Position*3, Color*1, Radius*1, Motion*3, Age*1
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
                                                }
                                            })
                                        .updateData({
                                            "color":data.color.asInt()*2,"radius":data.radius,"LifeLim":280,
                                            "omegaX":omegaX,"omegaY":omegaY,"omegaZ":omegaZ,
                                            "thetaX":0.0,"thetaY":0.0,"thetaZ":0.0,
                                            "x1":data.x,"y1":data.y,"z1":data.z
                                        }).regi(world);
                                        return data+{"removal":true};
                                        //return data+{"LifeLim":400};
                                    }
                                    return data+{"radius":data.radius0.asDouble()*(0.2+1.0*data.life.asInt()/90)};
                                })
                                .regi(world);/**/
                        }
                        var vertexes as double[][]=[];
                        var sidePoints as double[][]=[];
                        var N=({"Ultra":10, "Lunatic":8, "Hard":7, "Normal":5, "Easy":3}as int[string])[diff]as int;
                        var p=({"Ultra":0.12, "Lunatic":0.15, "Hard":0.23, "Normal":0.7, "Easy":0.9}as double[string])[diff]as double;
                        var r=1.2*({"Ultra":2.0, "Lunatic":1.8, "Hard":1.5, "Normal":1.2, "Easy":0.7}as double[string])[diff]as double;
                        for i in 0 to N{
                            var A=V.scale(V.randomUnitVector(),world.random.nextDouble()*r);
                            vertexes+=A;
                            if(i>0){
                                for j in 0 to i{
                                    if(world.random.nextDouble()>p)continue;
                                    var m = 0+4.0*r;
                                    for k in 1 to m{
                                        var P=V.combine(vertexes[i],vertexes[j],1.0*k/m);
                                        sidePoints+=P;
                                    }
                                }
                            }
                        }
                        for i in sidePoints{
                            vertexes+=i;
                        }
                        var counter=0;
                        var v0=V.scale(V.randomUnitVector(),5.0);
                        for i in vertexes{
                            var color=0x777777;
                            var radius=7.0;
                            if(counter<N){
                                color=0x555577;
                                radius=17.0;
                            }
                            counter+=1;
                            var v=V.add(v0,i);
                            D.LinearOrb(dragon.x,dragon.y,dragon.z,v[0],v[1],v[2])
                                .updateData({
                                    "radius0":radius,"color":color,"LifeLim": 90-time,
                                    "omegaX":omegaX,"omegaY":omegaY,"omegaZ":omegaZ, "colli":false
                                })
                                .addLogicTick(function(world as IWorld, data as IData)as IData{
                                    var rl=data.LifeLim.asInt()-data.life.asInt();
                                    if(rl==20){
                                        return data+{"vx":0,"vy":0,"vz":0};
                                    }
                                    if(rl==3){
                                        D.Orb(function(world as IWorld, data as IData)as IData{
                                            var x0 = 0.0 + (1000+data.x.asDouble())/10000*10000;
                                            var z0 = 0.0 + (1000+data.z.asDouble())/10000*10000;
                                            var y0 = 80.0;
                                            var dx = data.x1.asDouble()-x0;
                                            var dy = data.y1.asDouble()-y0;
                                            var dz = data.z1.asDouble()-z0;
                                            var d = [dx,dy,dz]as double[];
                                            var rotRatio = L.sinf(Math.min(data.life.asInt()*2 , 90)) *2;
                                            var thetaX = data.thetaX.asDouble() + data.omegaX.asDouble() * rotRatio;
                                            var thetaY = data.thetaY.asDouble() + data.omegaY.asDouble() * rotRatio;
                                            var thetaZ = data.thetaZ.asDouble() + data.omegaZ.asDouble() * rotRatio;
                                            var p = V.add([x0,y0,z0],V.eulaAng(d,thetaX,thetaY,thetaZ));
                                            return data + {
                                                "x":p[0], "y":p[1], "z":p[2],
                                                "thetaX":thetaX, "thetaY":thetaY, "thetaZ":thetaZ
                                            };
                                        },data.x,data.y,data.z)
                                        //.useReducedRender()
                                        .updateData({
                                            "color":data.color.asInt()*2,"radius":data.radius,"LifeLim":280,
                                            "omegaX":omegaX,"omegaY":omegaY,"omegaZ":omegaZ,
                                            "thetaX":0.0,"thetaY":0.0,"thetaZ":0.0,
                                            "x1":data.x,"y1":data.y,"z1":data.z
                                        }).regi(world);
                                        return data+{"removal":true};
                                        //return data+{"LifeLim":400};
                                    }
                                    return data+{"radius":data.radius0.asDouble()*(0.2+1.0*data.life.asInt()/90)};
                                })
                                .regi(world);/**/
                        }/**/
                    }
                }
                else{
                    if(V.length(V.subtract(getHomePos(dragon),V.getPos(dragon)))>3)dragon.updateNBT({"Behaviour":"GO_HOME"});
                    else dragon.updateNBT({"Behaviour":"FIREBOMB"});
                    }
                //if(time<70)dragonPlaySound(dragon,)
                if(time>70 && time<300 && time%1==0)dragonPlaySound(dragon,Attunement, 0+5.0*L.sinf(0.6*(time- 50)), 0.5+L.sinf(0.6*time));
                if(time==380)dragonPlaySound(dragon, "botania:divinationrod");
            }
            else{
                SwitchFightMode(dragon);
            }
        }





    }
});










var dragonBehaviours as string[]=[
    "FIREBOMB", //Sitting in the centre, Firebombing the player continuosly.
    "GUARDING", //Moving around the crystals, throwing various bullets
    "CHARGING",  //Charging towards the player, throwing fast fire balls
    "DEAD",
    "CIRCLE_PLAYER", //Flying around the player, throwing various bullets

    //LOW_HEALTH_STRATEGY
    //GO_HOME
] as string[];

var ExampleDragonNBT as IData=
{
    HomeXCoord: 10000, 
    HomeYCoord: 80, 
    HomeZCoord: 10000, 
    Behaviour: "FIREBOMB", 
    HomeSet: 1 as byte, 
    ForgeData: {}, 
    Attributes: [
        {Base: 0.0, Name: "generic.scales"}, 
        {Base: 2000.0, Name: "generic.maxHealth"}, 
        {Base: 0.0, Name: "generic.knockbackResistance"}, 
        {Base: 0.699999988079071, Name: "generic.movementSpeed"}, 
        {Base: 0.0, Name: "generic.armor"}, 
        {Base: 0.0, Name: "generic.armorToughness"}, 
        {Base: 1.0, Name: "forge.swimSpeed"}, 
        {Base: 16.0, Name: "generic.followRange"}
    ], 
    Pos: [9998.393322666483, 109.99999999999999, 10002.447817907452], 
    Motion: [0.6120758604064783, 4.9073511329025744E-15, -0.9325912909009305], 
    Rotation: [33.27974 as float, 0.79797107 as float], 
    Invulnerable: 0 as byte, 
    Health: 1024.0 as float, 
    Fire: 0 as short, 

    Dimension: 1, 
    PortalCooldown: 0, 
    Air: 300 as short, 
    HurtByTimestamp: 0, 
    Leashed: 0 as byte, 
    OnGround: 0 as byte, 
    HurtTime: 0 as short,
    FallFlying: 0 as byte, 
    LeftHanded: 0 as byte, 
    DeathTime: 0 as short, 
    CanPickUpLoot: 0 as byte, 
    UpdateBlocked: 0 as byte, 
    FallDistance: 0.0 as float, 
    AbsorptionAmount: 0.0 as float, 
    PersistenceRequired: 1 as byte, 

    HandItems: [{}, {}], 
    HandDropChances: [0.085 as float, 0.085 as float], 
    ArmorItems: [{}, {}, {}, {}], 
    ArmorDropChances: [0.085 as float, 0.085 as float, 0.085 as float, 0.085 as float], 
    UUIDMost: -3433377839301375490 as long, 
    UUIDLeast: -7121530018717612308 as long, 
};
var ExampleProjectileNBT as IData=
{
    Type: 1, 
    Pos: [10012.578207294448, 153.4503364773143, 9927.7738239207], 
    Motion: [0.6462374329566956, -0.5096413567662239, -4.9317991733551025], 
    Rotation: [187.4692 as float, 5.8548913 as float], 
    Invulnerable: 0 as byte, 
    UpdateBlocked: 0 as byte, 
    Dimension: 1, 
    Air: 300 as short, 
    OnGround: 0 as byte, 
    PortalCooldown: 0, 
    FallDistance: 0.50964135 as float, 
    UUIDLeast: -5927248248174137534 as long, 
    UUIDMost: 5952856414599203425 as long, 
    Fire: -1 as short
};
