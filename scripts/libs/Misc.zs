#loader crafttweaker reloadableevents
#priority 1000000005

import mods.randomtweaker.botania.IBotaniaFXHelper;
import mods.randomtweaker.draconicevolution.IDraconicEvolutionFXHelper as DEFX;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;

import scripts.libs.Vector3D as V;
import scripts.libs.Data as D;


//FX Table
    //{"type":?}
    static DE_PARTICLE_TYPES as int[string]={
        "energyParticle" :  0,  //RGB, alpha
        //"energyCore" :      1,
        "lineIndicator":    2,  //a(Age), RGB
        "chaosProjectile":  3,  //RGB
        "chaosImplosion":   4,  //implosionType
        "portal":           5,  //No Parameter
        "dragonHeart":      6,  //RGB, expired
        "axeSelection":     7,  //No Parameter
        "soulExtraction":   8,  //Size, RGB
        "arrowShockWave":   9,  //Size
        //The main FX We use is [custom]
        "custom":           10
            //RGB, alpha, r, a, textureIndex, collideWithBlock(default: false)
    };
    //{"implosionType":?}
    static IMPLOSIONTYPES as int[string]={
        "tracer":0, "orginExpand":1, "orginContract":2, 
        "expandingWave":3, "contractingWave":4, "final":5
    };

IBotaniaFXHelper.setWispFXDistanceLimit(false);
IBotaniaFXHelper.setSparkleFXNoClip(true);

function executeCommand(s as string){
    server.commandManager.executeCommandSilent(server,s);
}
function shout(s as string){
    executeCommand("say "~s);
}
function say(s as string, world as IWorld, pos as double[], range as double=100){
    for player in world.getAllPlayers(){
        var diff=V.subtract(pos,V.getPos(player));
        if(V.dot(diff,diff)<range*range)player.sendChat(s);
    }
}

function shiftIBlockPos(a as IBlockPos, x as int, y as int, z as int)as IBlockPos{
    return IBlockPos.create(a.x+x,a.y+y,a.z+z);
}
function shiftBlockPos(a as IBlockPos, x as int, y as int, z as int)as IBlockPos{
    return IBlockPos.create(a.x+x,a.y+y,a.z+z);
}

function checkEntity(entity as IEntity, id as string)as bool{
    return !isNull(entity) && !isNull(entity.definition) && entity.definition.id==id;
}
function checkBlock(block as IBlock, id as string, meta as int=32767 as int)as bool{
    if(!isNull(block.fluid)){
        return block.fluid.name==id && (meta==32767 || block.meta==meta);
    }
    else if(!isNull(block.definition)){
        //shout(block.definition.id~"    vs    "~id);
        return block.definition.id==id && (meta==32767 || block.meta==meta);
    }
    return false;
}
function getItemsInChest(block as IBlock)as IItemStack[]{
    if(block.definition.id!="minecraft:chest")return [];
    if(isNull(block.data))return [];
    var data as IData=block.data;
    if(!(data has "Items"))return [];
    var data1 as [IData]=data.Items.asList();
    var result as IItemStack[]=[];
    for data2 in data1{
        var stack=D.getStack(data2);
        result+=stack;
    }
    return result;
}
function getEntitiesAround(world as IWorld, centre as double[], range as double)as [IEntity]{
    return world.getEntitiesInArea(IBlockPos.create(
        (centre[0]-range) as int, (centre[1]-range) as int, (centre[2]-range) as int
    ), IBlockPos.create(
        (centre[0]+range) as int, (centre[1]+range) as int, (centre[2]+range) as int
    ));
}
function Lightning(world as IWorld, pos as IBlockPos, effectOnly as bool=false){
    world.addWeatherEffect(world.createLightningBolt(0.0+pos.x,0.0+pos.y,0.0+pos.z,effectOnly));
}
function Explode(world as IWorld, pos as IBlockPos, strength as float = 5.0f, causeFire as bool=true, breakBlock as bool=true, entity as IEntity=null){
    world.performExplosion(entity, 0.5+pos.x, 0.5+pos.y, 0.5+pos.z, strength, causeFire, breakBlock);
}
function displayBlockPos(pos as IBlockPos)as string{
    return "( "~pos.x~" , "~pos.y~" , "~pos.z~" )";
}
function displayIBlockPos(pos as IBlockPos)as string{
    return "( "~pos.x~" , "~pos.y~" , "~pos.z~" )";
}

function getDoubleRGB(color as int)as double[]{
    var t = 1.0/255;
    var R = t* (color/65536%256);
    var G = t* (color/256%256);
    var B = t* (color%256);
    return [R,G,B]as double[];
}
function getIntRGB(color as int)as int[]{
    var R = (color/65536%256);
    var G = (color/256%256);
    var B = (color%256);
    return [R,G,B]as int[];
}

function createBotFX(data as IData){
    var c as double[]= getDoubleRGB(data.memberGet("color").asInt());
    var p as double[]= V.readFromData(data);
    var v as double[]= V.readFromData(data,"v");
    var r = data.memberGet("r");
    var a = 0.2*data.memberGet("a").asDouble();
    IBotaniaFXHelper.wispFX(p[0],p[1],p[2],c[0],c[1],c[2],r,v[0],v[1],v[2],a);
}/*
function createBotSparkle(data as IData){
    var c as double[]= getDoubleRGB(data.memberGet("color").asInt());
    var p as double[]= V.readFromData(data);
    var r = data.memberGet("r");
    shout("AAA");
    IBotaniaFXHelper.sparkleFX(p[0],p[1],p[2],c[0],c[1],c[2],10,300,false);
}*/

function createFX(data as IData)as void{
    //var p as double[] = V.readFromData(data);
    //var v as double[] = V.readFromData(data,"v");
    //DEFX.spawnFX(10,V.asIVector3d(p),V.asIVector3d(V.scale(v,0)),[0,180,255,255,10000,120,10,10,10,1]as int[]);
    //DEFX.spawnFX(2,V.asIVector3d(p),V.asIVector3d(V.scale(v,0)),[0,180,255,255,10000,120,10,10,10,1]as int[]);
    //return;
    var typeD = D.get(data,"type");
    if(isNull(typeD)) createBotFX(data);
    else{
        var type as string= typeD.asString();
        //print(type);
        if(DE_PARTICLE_TYPES has type){
            var p as double[] = V.readFromData(data);
            var v as double[] = V.readFromData(data,"v");
            var viewRD as IData = D.get(data,"viewRange");
            var t as int = DE_PARTICLE_TYPES[type]as int;
            var args as int[] = [];
            var alpha as double = (data has "alpha")?(data.memberGet("alpha").asDouble()):1.0;
            var c as int[] = getIntRGB(data.memberGet("color").asInt());
            print(t);
            if(t==0){
                args=[c[0],c[1],c[2],(alpha*100)as int];
            }
            else if(t==2){
                args=[c[0],c[1],c[2],data.memberGet("a").asDouble()];
            }
            else if(t==3){
                args=[0,c[0],c[1],c[2]];
            }
            else if(t==4){
                var type2d = D.get(data,"implosionType");
                var type2 = "tracer";
                if(!isNull(type2d))type2 = type2d.asString();
                var type2i as int= (IMPLOSIONTYPES has type2)?IMPLOSIONTYPES[type2]as int:0;
                args=[type2i];
            }
            else if(t==6){
                var expired = (data has "expired") && D.get(data,"expired").asBool();  //Create the particles when the heart expires
                args=c;
                if(expired)args+=0;
            }
            else if(t==8 || t==9){
                var r = (data has "size")?(data.memberGet("size").asInt()):(data.memberGet("r").asDouble() as int);
                args=[r,c[0],c[1],c[2]];
            }
            else if(t==10){
                var r = (data has "size")?(data.memberGet("size").asDouble()):(data.memberGet("r").asDouble());
                var a = data.memberGet("a").asDouble()*20;
                var colli = (data has "collideWithBlock") && data.memberGet("collideWithBlock").asBool();
                var i = (data has "textureIndex")?(data.memberGet("textureIndex").asInt()):0;
                args=[c[0],c[1],c[2],(alpha*255)as int,
                    0+r*10000,a as int,0,0,i,colli?1:0];
                print("args:");
                for pp in args{
                    print(pp);
                }
            }
            
            if(!isNull(viewRD))DEFX.spawnFX(t,V.asIVector3d(p),V.asIVector3d(v),viewRD.asDouble(),args);
            else DEFX.spawnFX(t,V.asIVector3d(p),V.asIVector3d(v),args);
            
        }
        else createBotFX(data);
    }
}