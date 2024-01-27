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
static BOSSID as string="minecraft:wither";
function drag(boss as IEntity,pid as UUID){
    var player=boss.world.getPlayerByUUID(pid);
    var vdiff=V.subtract(V.getPos(boss),V.getPos(player));
    if(V.length(vdiff)>50){
        var dis = V.length(vdiff);
        var v = V.scale(vdiff,0.001);
        var pos = V.add(V.getPos(player),v);
        player.motionX=player.motionX*1.01 + v[0];
        player.motionY=player.motionY*1.01 + v[1];
        player.motionZ=player.motionZ*1.01 + v[2];
    }
}
function getData(entity as IEntity, key as string)as IData{
    return entity.nbt.deepGet("ForgeData.doremySweeDanmukuDesign."~key);
}
function setData(entity as IEntity, key as string, value as IData)as void{
    entity.updateNBT(entity.nbt.deepSet(value,"ForgeData.doremySweeDanmukuDesign."~key));
    //print(entity.nbt.deepSet(value,"ForgeData.doremySweeDanmukuDesign."~key));
}
function tick(boss as IEntity,pid as UUID)as void{
    drag(boss,pid);
    var player=boss.world.getPlayerByUUID(pid);
    var w = boss.world;
    if(w.remote)return;
    var d=getData(boss,"tick");
    var tick=0;
    if(!isNull(d)) tick = d.asInt();
    for i,vert in V.DODECA_HEDRON.vertexes{
        var colors as int[]= [0xFF6666,0x6666FF,0xFFFF00,0xFFAAAA];
        if(tick%3!=0)break;
        var dd=V.asData(V.getPos(boss))+V.asData(V.scale(V.eulaAng(vert,[tick*0.15,tick*0.5,tick*0.27]),0.3),"v")+V.asData(V.stretch(V.eulaAng(vert,[tick*0.5,tick*2,tick*0.7]),[0.03,0,0.03]),"a")+
            {"renderTime":5,"EffectiveRadius":80,"color":colors[i%4],"size":V.randDouble(2.0,3.0,w)}as IData;
        P.AcclOrb.create(w,dd);
        //print("AAA");
    }
    var vdiff=V.subtract(V.getPos(boss),V.getPos(player));
    var v = V.stretch(V.eulaAng(V.unify(vdiff),V.randomUnitVector(w)),[0.6,0.1,0.7]);
    boss.motionX=v[0];
    boss.motionY=v[1];
    boss.motionZ=v[2];
    setData(boss,"tick",(tick+1)as IData);
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
                tick(entity,player.getUUIDObject());
            }
        }
    }
});