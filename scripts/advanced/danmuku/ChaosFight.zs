#reloadable
//#norun
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

//Config
    static difficulty as string=scripts.Config.danmukuDifficulty;
    static testingLastFightMode as bool=false;

//Basic Information
    static crystalID as string="draconicevolution:guardiancrystal";
    static dragonID as string="draconicevolution:chaosguardian";
    static projectileID as string="draconicevolution:guardianprojectile";
    static FightModes as string[]=[
        //"Soaring"//,"Throwing","SkyAttack","RegPolyHedron1","Rotating1"
        "Rotating1"
    ];

//Data
    function getData(entity as IEntity, key as string)as IData{
        return entity.nbt.deepGet("ForgeData.doremySweeDanmukuDesign."~key);
    }
    function setData(entity as IEntity, key as string, value as IData)as void{
        entity.updateNBT(entity.nbt.deepSet(value,"ForgeData.doremySweeDanmukuDesign."~key));
        //print(entity.nbt.deepSet(value,"ForgeData.doremySweeDanmukuDesign."~key));
    }

//Just for Testing
    static fightModeCounter as int[]= [-1 as int]as int[];
    function SwitchFightMode(dragon as IEntity, mode as string = "random"){
        if(FightModes has mode){
            setData(dragon,"FightMode",mode as IData);
            setData(dragon,"timerUnderFightMode",0 as IData);
        }
        else if(fightModeCounter[0]>=0){
            SwitchFightMode(dragon, FightModes[fightModeCounter[0]%FightModes.length]);
            fightModeCounter[0]=fightModeCounter[0]+1;
        }
        else{
            if(testingLastFightMode)SwitchFightMode(dragon, FightModes[FightModes.length- 1]);
            else SwitchFightMode(dragon, FightModes[dragon.world.random.nextInt(FightModes.length)]);
        }
    }

//Sound
    static FireSound as string="minecraft:entity.enderdragon.shoot";
    static FireSound1 as string="minecraft:entity.wither.shoot";
    static FireSound2 as string="minecraft:entity.ghast.shoot";
    static Explode as string="minecraft:entity.generic.explode";
    static Growl as string="minecraft:entity.enderdragon.growl";
    static WitherSpawn as string="minecraft:entity.wither.spawn";
    static Lightning as string="minecraft:entity.lightning.thunder";
    static Attunement as string="astralsorcery:attunement";
    static AttunementDone as string="astralsorcery:craftfinish";

    function dragonPlaySound(dragon as IEntity, soundName as string, volume as int = 100, pitch as double = 0){
        var world = dragon.world;
        for player in world.getAllPlayers(){
            var t1=V.subtract(V.getPos(player),V.getPos(dragon));
            if(V.dot(t1,t1)<250000){
                var command = "playsound "~soundName~" hostile "~player.name~" "~player.x~" "~player.y~" "~player.z~" "~volume~" "~pitch~" "~(volume>10?1:0.1*volume);
                //print(command);
                M.executeCommand(command);
            }
        }
    }

//Basic Tools for the Fight
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

//Basic Behaviors
    events.onEntityJoinWorld(function(event as crafttweaker.event.EntityJoinWorldEvent){
        var world as IWorld=event.world;
        if(world.remote)return;
        if(checkID(event.entity,projectileID))event.cancel();
        //else L.say(event.entity.definition.id);
    });
//Danmukus
    static Rotation1 as P.FXGenerator = P.segment.copy("ChaosFight_Rotation1")
        .updateDefaultData({
            "color":0x884444,
            "color2":0xAAAAFF,
            "wx":0.0,"wy":0.0,"wz":0.0,
            "lifeLimit":300,"renderInterval":5,
            "effectiveRadius":1000.0,
            "phaseSwitch":20,
            "renderNum":7,
            "particleLifeCoef":0.7,
            "usePlayerRenderer":false,
            "colli":false
        })
        //Initializing Data
        .addTick(function(world as IWorld, data as IData)as IData{
            //print(data);
            if(data has "Adx")return data;
            var A1 = V.readFromData(data,"A");
            var t= 10000.0;
            var p0 = [
                t*V.floor(A1[0]/t+0.5),
                160.0,
                t*V.floor(A1[2]/t+0.5)
            ]as double[];
            var A = V.subtract(A1,p0);
            var B = V.subtract(V.readFromData(data,"B"),p0);
            return data + V.asData(A,"Ad") + V.asData(B,"Bd") + V.asData(p0,"",false,"0") + V.asData(V.V000,"t");
        })
        //Moving to Wanted Position "Ax" (originally)
        .addTick(function(world as IWorld, data as IData)as IData{
            if(data.life.asInt()>data.phaseSwitch.asInt()) return data;
            var t0 = data.life.asInt();
            var t1 = (t0>60)?60:t0;
            var A = V.add(V.scale(V.readFromData(data,"Ad"),V.sinf(1.5*t1)),
                V.readFromData(data,"",false,"0"));
            var B = V.add(V.scale(V.readFromData(data,"Bd"),V.sinf(1.5*t1)),
                V.readFromData(data,"",false,"0"));
            return data+{"colli":false}+V.asData(A,"A")+V.asData(B,"B");
        })
        //Start Rotation
        .addTick(function(world as IWorld, data as IData)as IData{
            if(data.life.asInt()<=data.phaseSwitch.asInt()) return data;
            var t0 = (data.life.asInt() - data.phaseSwitch.asInt());
            var t1 = 1.0*V.sinf(((t0<90)?t0:90)as double);
            var ang = V.add(V.readFromData(data,"t"),V.scale(V.readFromData(data,"w"),t1));
            var o = V.readFromData(data,"",false,"0");
            var A = V.add(o,V.eulaAng(V.readFromData(data,"Ad"),ang));
            var B = V.add(o,V.eulaAng(V.readFromData(data,"Bd"),ang));
            return data + {"colli":true,"color":data.color2,"particleVelocityCeof":0.0} + V.asData(A,"A") + V.asData(B,"B") + V.asData(ang,"t");
        })
        .regi();
//Attack
    events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
        //M.shout(scripts.advanced.libs.Misc.counter[0]);
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
                var dat0 = getData(dragon,"time");
                var dat1 = getData(dragon,"timerUnderFightMode");
                var time0 as int=isNull(dat0)?0:dat0.asInt();
                var time=isNull(dat1)?0:dat1.asInt();
                setData(dragon,"time",(time0+1)as IData);
                setData(dragon,"timerUnderFightMode",(time+1)as IData);
                time0-=time;
                var dat2 = getData(dragon,"FightMode");
                var mode=isNull(dat2)?"":dat2.asString();
                var player as IPlayer=world.getClosestPlayerToEntity(dragon, 1000, false);
                if(isNull(player))continue;
                //M.shout(time);
                var diff as string= difficulty;
                if(mode=="Rotating1"){
                    var omegaR=0.9*({"Ultra":1.3, "Lunatic":1.0, "Hard":0.8, "Normal":0.6, "Easy":0.4}as double[string])[diff]as double;
                    var omegaX=(0.6+0.2*V.sinfR(1.0*(time0/(300 as long))*163))*omegaR;
                    var omegaY=(1.0+0.6*V.sinfR(1.0*(time0/(300 as long))*173))*omegaR;
                    var omegaZ=(0.5+0.3*V.sinfR(1.0*(time0/(300 as long))*183))*omegaR;
                    
                    if(time>420){
                        SwitchFightMode(dragon);
                    }
                    else if(time<70){
                        var p0 = V.getPos(dragon);
                        for iiii in 0 to 10{
                            var a=({"Ultra":2, "Lunatic":1, "Hard":0, "Normal":1, "Easy":1}as int[string])[diff]as int;
                            var b=({"Ultra":1, "Lunatic":1, "Hard":1, "Normal":0, "Easy":0}as int[string])[diff]as int;
                            if(iiii+1>((time%3==0)?a:b))break;
                            if(time==5){
                                var pd=V.getPos(dragon);
                                var ph=getHomePos(dragon);
                                var v=V.scale(V.subtract(ph,pd),1.0/85);
                            }
                            var vertexes as double[][]=[];
                            var sidePoints as double[][]=[];
                            var r0 = (world.random.nextDouble())/1.0*400 - 30;
                            var N=({"Ultra":10, "Lunatic":8, "Hard":7, "Normal":5, "Easy":4}as int[string])[diff]as int;
                            var p=({"Ultra":0.12, "Lunatic":0.15, "Hard":0.23, "Normal":0.7, "Easy":0.9}as double[string])[diff]as double;
                            var r=(300.0+r0)/8.0*(300.0+r0)/500.0*1.2*({"Ultra":2.0, "Lunatic":1.8, "Hard":1.8, "Normal":1.6, "Easy":1.4}as double[string])[diff]as double;
                            var p1 = V.scale(V.randomUnitVector(),r0);
                            for i in 0 to N{
                                var A=V.scale(V.randomUnitVector(),world.random.nextDouble()*r);
                                vertexes+=A;
                                if(i>0){
                                    for j in 0 to i{
                                        if(world.random.nextDouble()>p)continue;
                                        Rotation1.create(world,{
                                            "phaseSwitch":135-time,
                                            "lifeLimit":420-time,
                                            //"type":"custom",
                                            "textureIndex":0,
                                            "size":10 + (r0+200)/40,
                                            "viewRange":1000.0
                                        } + V.asData(V.add(V.add(p0,p1),vertexes[i]),"A")
                                          + V.asData(V.add(V.add(p0,p1),vertexes[j]),"B")
                                          + V.asData([omegaX,omegaY,omegaZ]as double[],"w"));
                                    }
                                }
                            }
                        }
                    }
                    else{
                        if(V.length(V.subtract(getHomePos(dragon),V.getPos(dragon)))>3)dragon.updateNBT({"Behaviour":"GO_HOME"});
                        else dragon.updateNBT({"Behaviour":"FIREBOMB"});
                    }
                    if(time>120 && time<350 && time%1==0)dragonPlaySound(dragon,Attunement, 0+5.0*V.sinf(0.6*(time - 100)), 0.5+V.sinf(0.6*(time - 70)));
                    if(time>400 && time%5==0)dragonPlaySound(dragon, "botania:divinationrod");
                    
                }
                else{
                    SwitchFightMode(dragon);
                }/** */
            }





        }
    });
/** */