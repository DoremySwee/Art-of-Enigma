#loader crafttweaker reloadableevents
//#norun
import scripts.EntityAIMixins.DanmuAttack as D;
import scripts.EntityAIMixins.MiscLib as M;
import scripts.LibReloadable as L;
import scripts.libs.Vector3D as V;

import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import mods.ctutils.utils.Math;
import mods.zenutils.UUID;

static crystalID as string="draconicevolution:guardiancrystal";
static dragonID as string="draconicevolution:chaosguardian";
static projectileID as string="draconicevolution:guardianprojectile";

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

events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld=event.world;
    if(world.remote || event.phase=="START" || event.side=="CLIENT")return;
    for entity in world.getEntities(){
        if(checkID(entity,projectileID) && !(entity.nbt has "doremySweeDanmukuDesign")){
            //L.say(entity.nbt.Type);
            world.removeEntity(entity);
        }
        if(checkID(entity,dragonID)){
            var dragon=entity;
            dragon.updateNBT({"Behaviour":"CIRCLE_PLAYER"});
            var time as int=M.getIntFromData(dragon,"time");
            M.setData(entity,"time",(time+1) as IData);
            
            if(time%1000<300){
                var i=time%1000;
                var theta0X=Math.cos(1.0*(time/(300 as long))*113)*360;
                var theta0Y=Math.sin(1.0*(time/(300 as long))*133)*360;
                var theta0Z=Math.sin(1.0*(time/(300 as long))*153)*360;
                var omegaX=2.0;
                var omegaY=6.0;
                var omegaZ=3.0;
                var v=0.001*i+0.5+0.15*V.sin(i);
                var counter as int=0;
                var colors as int[]=[0xFFCCCC,0xFFCCAA,0xFFAACC,0xFFAAAA,0xFF7777,0xFF77AA];
                for t in V.dodecaHedron{
                    var vv as double[]=V.scale(t,v);
                    var vv2=V.rot(V.rot(V.rot(vv,V.VX,theta0X+omegaX*i),V.VY,theta0Y+omegaY*i),V.VZ,theta0Z+omegaZ*i);
                    D.LinearOrb(entity.x,entity.y,entity.z,vv2[0],vv2[1],vv2[2])
                    .updateData({
                        "radius":4,
                        "color":colors[counter%6],
                        "DeleteRadius":200,
                        "LifeLim":200
                    }).regi(world);
                    counter+=1;
                }
            }
            if([300,350,370,390] as int[] has time%1000){
                for crystal in getCrystals(dragon){
                    if(!isCrystalAlive(crystal))continue;
                    var N as int=(45- (time%1000)/20)/3*2;
                    var axis=V.randomUnitVector();
                    var angle=Math.random()*360;
                    var colors as int[int]={
                        300:0xFF0000,
                        350:0xFF3333,
                        370:0xFF6666,
                        390:0xFF9999
                    }as int[int];
                    for i in 0 to N{
                        var p0=V.getPos(crystal);
                        for j in 0 to 3{
                            var v=V.scale(V.rot(V.rot(V.VX,V.VY,360.0/N*i),axis,angle),0.3+0.01*(time%1000- 300));
                            var p=V.add(p0,V.scale(v,-4.0*j));
                            D.LinearOrb(p[0],p[1],p[2],v[0],v[1],v[2])
                            .updateData({
                                "radius":5,
                                "color":colors[time%1000] as int,
                                "DeleteRadius":300,
                                "LifeLim":300
                            })
                            .addLogicTick(function(world as IWorld, data as IData)as IData{
                                return D.setV(data,V.length(D.getV(data))+0.01);
                            })
                            .regi(world);
                        }
                    }
                }
            }
            if(time%1000==700){

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
