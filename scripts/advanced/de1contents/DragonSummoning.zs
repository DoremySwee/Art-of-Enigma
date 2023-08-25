#loader crafttweaker reloadableevents
import mods.randomtweaker.botania.IBotaniaFXHelper;
import mods.contenttweaker.VanillaFactory;
import mods.zenutils.NetworkHandler;

import mods.ctutils.utils.Math;
import crafttweaker.data.IData;

import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;

import crafttweaker.entity.IEntityItem;
import crafttweaker.entity.IEntity;

import scripts.advanced.libs.ParticleGenerator as P;
import scripts.advanced.libs.StructureTester as ST;
import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;
import scripts.advanced.libs.Data as D;

//Killing the crystals, to ban the vanilla summoning
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var world as IWorld = event.world;
    if(world.remote) return;
    if(world.getDimension()!=1)return;
    if(event.phase=="START")return;
    for entity in world.getEntities(){
        if(isNull(entity))continue;
        if(isNull(entity.definition))continue;
        if(entity.definition.id=="minecraft:ender_dragon")print(entity.nbt);
        if(entity.definition.id!="minecraft:ender_crystal")continue;
        if(entity.nbt has "ShowBottom" && entity.nbt.memberGet("ShowBottom").asByte()==1){
            world.setCustomWorldData(world.getCustomWorldData().deepUpdate({
                "OriginalEnderCrystals":[{"x":Math.floor(entity.x),"y":Math.floor(entity.y),"z":Math.floor(entity.z)}]
            },mods.zenutils.DataUpdateOperation.MERGE));
            //print(world.getCustomWorldData());
        }
        if(entity.x>4.0)continue;
        if(entity.x<-3.0)continue;
        if(entity.z>4.0)continue;
        if(entity.z<-3.0)continue;
        world.addWeatherEffect(world.createLightningBolt(
            entity.x, entity.y, entity.z, false));
        world.removeEntity(entity);
        M.say(game.localize("crt.chat.dragon.deny"),world,[0.0,64.0,0.0]);
    }
});


static pattern as string[] = [
    "00000M0M;0V00M0B0M00V;00000q0q;000Q00O00Q;0M00d0O0d00M;M0q00V0V00q0M;0B0OO000OO0B0;M0q00V0V00q0M;0M00d0O0d00M;000Q00O00Q;00000q0q;0V00M0B0M00V;00000M0M;",
    ";0C000000000C;000V0N0N0V;00VQ00000QV;0000D0b0D;00N000b000N;0000bb0bb;00N000b000N;0000D0b0D;00VQ00000QV;000V0N0N0V;0C000000000C;",
    ";;;000P00000P;0000E000E;;000000c;;0000E000E;000P00000P;",
    ";;;000G00000G;;;;;;000G00000G;"
] as string[];
static map as IData= {
    "0":{},
    "G":{"id":"botania:pylon","meta":2},
    "P":{"id":"minecraft:purpur_pillar","meta":0,"info":game.localize("crt.chat.resurrection.pillar")},
    "E":{"id":"draconicevolution:energy_crystal","meta":8},
    "c":{"id":"botania:spawnerclaw"},
    "C":{"id":"extrautils2:opinium","data":{"stack":{"Damage":8 as short}},"info":game.localize("tile.extrautils2:opinium.8.name"),"default":false},
    "V":{"id":"chisel:energizedvoidstone","meta":7,"info":"meta:7"},
    "Q":{"id":"minecraft:quartz_block","meta":2,"info":game.localize("crt.chat.resurrection.pillar")},
    "N":{"id":"botania:pylon","meta":1},
    "D":{"id":"draconicevolution:draconium_block","meta":1},
    "b":{"id":"minecraft:iron_bars"},
    "M":{"id":"avaritia:block_resource","meta":2},
    "q":{"id":"botania:quartztypelavender","meta":2,"info":game.localize("crt.chat.resurrection.pillar")},
    "d":{"id":"botania:storage","meta":4},
    "O":{"id":"draconicevolution:infused_obsidian"},
    "B":{"id":"minecraft:beacon"}
}as IData;
function checkStructure(world as IWorld, pos as IBlockPos)as string{
    var invalid0 as string[]=[];
    if(Math.abs(pos.x)+Math.abs(pos.z)>30){
        invalid0+=game.localize("crt.chat.resurrection.too_far");
    }
    if(pos.y<60){
        invalid0+=game.localize("crt.chat.resurrection.too_low");
    }
    if(pos.y>66){
        invalid0+=game.localize("crt.chat.resurrection.too_high");
    }
    var invalid as string[]=(invalid0.length>0)?invalid0:ST.match(map,pattern,world,pos,[-1 as int, -6 as int, -6 as int]);
    if(invalid.length<1)return "";
    else{
        var ans = game.localize("crt.chat.resurrection.incomplete");
        if(invalid0.length<1)ans=ans~"\n"~game.localize("crt.chat.resurrection.missing");
        var counter = 0;
        for i in invalid{
            if(counter==11){
                ans=ans~"\n ...... ";
                return ans;
            }
            ans=ans~"\n    "~i;
            counter+=1;
        }
        return ans;
    }/**/
}

events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    var b = event.block;
    var w = event.world;
    var p = event.position;
    if(isNull(b) || isNull(b.definition) || w.remote)return;
    if(b.definition.id=="contenttweaker:resurrection_stone"){
        if(checkStructure(w,p)==""){
            w.setBlockState(w.getBlockState(p),(({}+b.data)as IData).deepUpdate({"CustomData":{"clicked":true}},mods.zenutils.DataUpdateOperation.MERGE),p);
        }
        else{
            M.tellAuto(event.player,checkStructure(w,p));
        }
    }
});

function ResurrectionTerminate(world as IWorld, pos as IBlockPos, destructCrystals as bool=true){
    var map2={
        "D":{"id":"draconicevolution:draconium_block"},
        "O":{"id":"minecraft:obsidian"},
        "G":{"id":"botania:pylon","meta":1},
        "N":{"id":"botania:pylon","meta":0},
        "d":{"id":"botania:storage","meta":3},
        "M":{"id":"appliedenergistics2:matrix_frame"}
    } as IData;
    var dy=-1 as int;
    var xshift=-6 as int;
    var zshift=-6 as int;
    for p in pattern{
        var i=0;
        var j=0;
        var k=0;
        for k in 0 to p.length{
            if(p[k]==";"){
                j=0;i+=1;
            }
            else if(map has p[k]){
                var pos2 = M.shiftIBlockPos(pos,i+xshift,dy,j+zshift);
                if(ST.matchBlock(map.memberGet(p[k]),world.getBlock(pos2))==""){
                    if(map2 has p[k]){
                        var d2=map2.memberGet(p[k]);
                        var meta=((d2 has "meta")?(d2.meta.asInt()):0);
                        var item=itemUtils.getItem(d2.id.asString());
                        world.setBlockState((item as IBlock).definition.getStateFromMeta(meta),pos2);
                    }
                    if((["E","B","C"]as string[]) has p[k]){
                        world.performExplosion(null, 0.5+pos2.x, 0.5+pos2.y, 0.5+pos2.z, 
                            (world.random.nextDouble(1.0,2.2)+world.random.nextDouble(1.0,2.2)+world.random.nextDouble(1.0,2.2))as float,
                            true, true);
                    }
                }
                else{
                    world.addWeatherEffect(world.createLightningBolt(0.5+pos2.x,0.5+pos2.y,0.5+pos2.z,true));
                }
                j+=1;
            }
        }
        dy+=1;
    }
    world.setBlockState((<draconicevolution:draconium_block>as IBlock).definition.defaultState,pos);
    if(destructCrystals){
        for i in world.getCustomWorldData().memberGet("OriginalEnderCrystals").asList(){
            M.Lightning(world,IBlockPos.create(i.x.asInt(),i.y.asInt(),i.z.asInt()));
        }
    }
}


static draggonSummoningSpecialOrb1 as P.FXGenerator = P.SingleOrb.copy("draggonSummoningSpecialOrb1")
    .updateDefaultData({
        "x0":0.5,"y0":0.5,"z0":0.5,"timerAltar":0,
        "colli":false,"radius":0.3, "effectiveRadius":100.0,"lifeLim":30
    })
    .addTick(function(world as IWorld, data as IData)as IData{
        var dx = data.x - data.x0;
        var dy = data.y - data.y0;
        var dz = data.z - data.z0;
        var t = 1.0*data.timerAltar.asInt();
        var d0 as double[]= V.scale(V.rotate([dx,dy,dz]as double[],V.VY,2.0 + t/500 ), 0.97 - t/50000);
        var d1 as double[]= [d0[0],(d0[1]+0.5+1) * (0.97 - t/50000 - 1.0*data.life/200)- 1, d0[2]];
        return data+{
            "x":data.x0+d1[0],
            "y":data.y0+d1[1],
            "z":data.z0+d1[2],
            "removed":(V.length(d1)<0.3)as bool
        };
    })
    .regi();

function ResurrectionStoneTick(te as mods.zenutils.cotx.TileEntityInGame, world as IWorld, pos as IBlockPos)as void{
    if(world.remote)return;
    var data as IData = te.data;
    var activated = (data has "activated") && data.memberGet("activated").asBool();
    var timer as int = (data has "timer")?data.memberGet("timer").asInt():0;
    var time = timer;
    if((data has "clicked") && data.memberGet("clicked").asBool()){
        if(!activated){
            te.updateCustomData(data+{
                "clicked":false,
                "activated":true,
                "timer":0,
            });
        }
        if(activated && timer>20){
            ResurrectionTerminate(world,pos);
            te.updateCustomData(data+{
                "clicked":false,
                "activated":false,
                "timer":0
            });
        }
        else{
            te.updateCustomData(data+{
                "clicked":false
            });
        }
    }
    else if(activated){
        var struct = checkStructure(world,pos);
        if(struct!=""){
            te.updateCustomData(data+{
                "clicked":false,
                "activated":false,
                "timer":0
            });
            ResurrectionTerminate(world,pos);
        }
        else{
            te.updateCustomData(data+{
                "clicked":false,
                "activated":true,
                "timer":timer+1
            });
            //Lightning
            if(time<20 || time%3==0 && time<50 || time%12==0 && time<120 || time%20==0 && time<600 || world.random.nextDouble()<0.03){
                var dps as int[][]= [[4,0,1],[5,0,0],[2,1,2],[3,2,3]];
                if(world.random.nextDouble()<0.5)M.Lightning(world,pos);
                else{
                    var dp = dps[world.random.nextInt(0,dps.length- 1)];
                    if(world.random.nextDouble()<0.5)dp[0]=-dp[0];
                    if(world.random.nextDouble()<0.5)dp[1]=-dp[1];
                    if(world.random.nextDouble()<0.5){
                        var temp = dp[0];
                        dp[0]=dp[1];
                        dp[1]=temp;
                    }
                    M.Lightning(world,M.shiftIBlockPos(pos,dp[0],dp[1],dp[2]));
                }
            }
            //Respawn Crystals
            if(time<2000){
                if(time>320 && time<330){
                    for i in world.getCustomWorldData().memberGet("OriginalEnderCrystals").asList(){
                        M.Lightning(world,IBlockPos.create(i.x.asInt(),i.y.asInt(),i.z.asInt()));
                    }
                }
                if(time>=400){
                    var n = world.getCustomWorldData().memberGet("OriginalEnderCrystals").asList().length;
                    var n2 = (time- 400) / (1600/n) ;
                    for i in world.getCustomWorldData().memberGet("OriginalEnderCrystals").asList(){
                        var f = false;
                        for entity in M.getEntitiesAround(world, [0.5+i.x.asInt(),0.5+i.y.asInt(),0.5+i.z.asInt()],1){
                            if(isNull(entity))continue;
                            if(isNull(entity.definition))continue;
                            if(entity.definition.id!="minecraft:ender_crystal")continue;
                            f=true;
                            break;
                        }
                        if((time- 400) % (1600/n) == 0){
                            if(n2<0)break;
                            n2-=1;
                            if(f)continue;
                            var crystal = <entity:minecraft:ender_crystal>.createEntity(world);
                            crystal.posX=0.5+i.x.asInt();
                            crystal.posY=i.y.asInt();
                            crystal.posZ=0.5+i.z.asInt();
                            crystal.updateNBT({"ShowBottom":1 as byte});
                            if(world.random.nextDouble()*1500<time)
                                crystal.updateNBT({"BeamTarget":{
                                    "X":pos.x,"Y":128,"Z":pos.z
                                }});
                            else
                                crystal.updateNBT({"BeamTarget":{
                                    "X":pos.x,"Y":pos.y- 2,"Z":pos.z
                                }});
                            M.Lightning(world,IBlockPos.create(i.x.asInt(),i.y.asInt(),i.z.asInt()),true);
                            M.Explode(world,IBlockPos.create(i.x.asInt(),i.y.asInt(),i.z.asInt()),6.0f,false,false);
                            world.spawnEntity(crystal);
                        }
                    }
                }
            }
            if(time>2500){
                for i in world.getCustomWorldData().memberGet("OriginalEnderCrystals").asList(){
                    for entity in M.getEntitiesAround(world, [0.5+i.x.asInt(),0.5+i.y.asInt(),0.5+i.z.asInt()],1){
                        if(isNull(entity))continue;
                        if(isNull(entity.definition))continue;
                        if(entity.definition.id!="minecraft:ender_crystal")continue;
                        world.removeEntity(entity);
                    }
                    var crystal = <entity:minecraft:ender_crystal>.createEntity(world);
                    crystal.posX=0.5+i.x.asInt();
                    crystal.posY=i.y.asInt();
                    crystal.posZ=0.5+i.z.asInt();
                    crystal.updateNBT({"ShowBottom":1 as byte});
                    world.spawnEntity(crystal);
                }
                var dragon= <entity:minecraft:ender_dragon>.createEntity(world);
                dragon.posX=0.0+pos.x;dragon.posY=128.0;dragon.posZ=0.0+pos.z;
                dragon.updateNBT({"DragonPhase":0,"Health":30,});
                world.spawnEntity(dragon);
                //dragon.addPotionEffect(<potion:minecraft:regeneration>.makePotionEffect(30,4));
                ResurrectionTerminate(world,pos,false);
            }
            //FX
                //TODO
        }
    }
}
NetworkHandler.registerServer2ClientMessage("ResurrectionOrb",function(p,b){
});
VanillaFactory.putTileEntityTickFunction(1, function(te,w,p){
    ResurrectionStoneTick(te,w,p);
});
