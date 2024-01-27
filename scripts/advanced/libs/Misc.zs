#reloadable
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

import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Data as D;

import crafttweaker.text.ITextComponent;

//FX Table
    //{"type":?}
    static DE_PARTICLE_TYPES as int[string]={
        "energyParticle" :  0,  //RGB, alpha
        //"energyCore" :    1,
        "infuser":          2,
        "lineIndicator":    3,  //a(Age), RGB
        "chaosProjectile":  4,  //RGB
        "chaosImplosion":   5,  //implosionType
        "portal":           6,  //No Parameter
        "dragonHeart":      7,  //RGB, expired
        "axeSelection":     8,  //No Parameter
        "soulExtraction":   9,  //Size, RGB
        "arrowShockWave":   10,  //Size
        //The main FX We use is [custom]
        "custom":           11
            //RGB, alpha, r, a, textureIndex, collideWithBlock(default: false)
    };
    //{"implosionType":?}
    static IMPLOSIONTYPES as int[string]={
        "tracer":0, "orginExpand":1, "orginContract":2, 
        "expandingWave":3, "contractingWave":4, "final":5
    };

IBotaniaFXHelper.setWispFXDistanceLimit(false);
IBotaniaFXHelper.setWispFXDistanceLimit(false);
IBotaniaFXHelper.setSparkleFXNoClip(true);

function executeCommand(s as string){
    server.commandManager.executeCommandSilent(server,s);
}
function isNumber(s as string)as bool{
    return ["0","1","2","3","4","5","6","7","8","9"] as string[] has s;
}
function isAlphabet(s as string)as bool{
    return [
        "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
    ] as string[] has s;
}
function canFromTranslationKey(s as string)as bool{
    return isNumber(s) || isAlphabet(s) || s=="_" || s==".";
}
function translationAutoFix(s as string, index as int=0)as ITextComponent{
    if(index>=s.length)return ITextComponent.fromString("");
    var i=index;
    while(i+1<s.length){
        i=i+1;
        if(i+1>=s.length)break;
        if(s[i]=="."&&canFromTranslationKey(s[i+1])&&canFromTranslationKey(s[i - 1]) && !isNumber(s[i+1])){
            var l= i - 1;
            while(l>=index){
                if(!canFromTranslationKey(s[l])) break;
                l-=1;
            }
            var r= i+1;
            while(r<s.length){
                if(!canFromTranslationKey(s[r])) break;
                r+=1;
            }
            var pre = "";
            var key = "";
            l+=1;
            for j in index to l{
                pre+=s[j];
            }
            for j in l to r{
                key+=s[j];
            }
            return ITextComponent.fromString(pre) + ITextComponent.fromTranslation(key) + translationAutoFix(s,r);
        }
    }
    var result = "";
    for i in index to s.length{
        result+=s[i];
    }
    return ITextComponent.fromString(result);
}
//Deprecated, only for test
function shout(s as string){
    executeCommand("say "~s);
}
function sayOld(s as string, world as IWorld, pos as double[], range as double=100, autoTrans as bool = true){
    for player in world.getAllPlayers(){
        var diff=V.subtract(pos,V.getPos(player));
        if(V.dot(diff,diff)<range*range)player.sendRichTextStatusMessage(translationAutoFix(s),false);
    }
}
function say(s as ITextComponent, world as IWorld, pos as double[], range as double=100, autoTrans as bool = true){
    for player in world.getAllPlayers(){
        var diff=V.subtract(pos,V.getPos(player));
        if(V.dot(diff,diff)<range*range)player.sendRichTextStatusMessage(s,false);
    }
}
function tellAuto(p as IPlayer, s as string){
    p.sendRichTextStatusMessage(translationAutoFix(s),false);
}
function localize(key as string)as ITextComponent{
    return ITextComponent.fromTranslation(key);
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

static counter as int[] = [0] as int[];

function createBotFX(data as IData){
    var c as double[]= (data has "color")?(getDoubleRGB(data.memberGet("color").asInt())):(getDoubleRGB(data.memberGet("c").asInt()));
    var p as double[]= V.readFromData(data);
    var v as double[]= V.readFromData(data,"v");
    var r = data.memberGet("r");
    var a = 0.2*data.memberGet("a").asDouble();
    IBotaniaFXHelper.wispFX(p[0],p[1],p[2],c[0],c[1],c[2],r,v[0],v[1],v[2],a);
    counter[0]=counter[0]+1;
}/*
function createBotSparkle(data as IData){
    var c as double[]= getDoubleRGB(data.memberGet("color").asInt());
    var p as double[]= V.readFromData(data);
    var r = data.memberGet("r");
    shout("AAA");
    IBotaniaFXHelper.sparkleFX(p[0],p[1],p[2],c[0],c[1],c[2],10,300,false);
}*/

function createFX(data as IData)as void{
    var typeD = D.get(data,"type");
    if(isNull(typeD)) createBotFX(data);
    else{
        counter[0]=counter[0]+1;
        var type as string= typeD.asString();
        if(DE_PARTICLE_TYPES has type){
            var p as double[] = V.readFromData(data);
            var v as double[] = V.readFromData(data,"v");
            var viewRD as IData = D.get(data,"viewRange");
            var t as int = DE_PARTICLE_TYPES[type]as int;
            var args as int[] = [];
            var alpha as double = (data has "alpha")?(data.memberGet("alpha").asDouble()):1.0;
            var c as int[] = (data has "color")?(getIntRGB(data.memberGet("color").asInt())):(getIntRGB(data.memberGet("c").asInt()));
            if(t==0){
                args=[c[0],c[1],c[2],(alpha*100)as int];
            }
            else if(t==3){
                args=[c[0],c[1],c[2],data.memberGet("a").asDouble()];
            }
            else if(t==4){
                args=[0,c[0],c[1],c[2]];
            }
            else if(t==5){
                var type2d = D.get(data,"implosionType");
                var type2 = "tracer";
                if(!isNull(type2d))type2 = type2d.asString();
                var type2i as int= (IMPLOSIONTYPES has type2)?IMPLOSIONTYPES[type2]as int:0;
                args=[type2i];
            }
            else if(t==7){
                var expired = (data has "expired") && D.get(data,"expired").asBool();  //Create the particles when the heart expires
                args=c;
                if(expired)args+=0;
            }
            else if(t==10 || t==9){
                var r = (data has "size")?(data.memberGet("size").asInt()):(data.memberGet("r").asDouble() as int);
                args=[r,c[0],c[1],c[2]];
            }
            else if(t==11){
                var r = ((data has "size")?(data.memberGet("size").asDouble()):(data.memberGet("r").asDouble()))*3;
                var a = data.memberGet("a").asDouble()*5;
                var colli = (data has "collideWithBlock") && data.memberGet("collideWithBlock").asBool();
                var i = (data has "textureIndex")?(data.memberGet("textureIndex").asInt()):0;
                args=[c[0],c[1],c[2],(alpha*255)as int,
                    0+r*10000,a as int,0,0,i,colli?1:0];
            }
            //print("A");
            //for tt in args{print(tt);}
            var vt = V.asIVector3d(V.scale(v,1.0));
            if(!isNull(viewRD))DEFX.spawnFX(t,V.asIVector3d(p),vt,viewRD.asDouble(),args);
            else DEFX.spawnFX(t,V.asIVector3d(p),vt,args);
        }
        else createBotFX(data);
    }
}
function announceColli(player as IPlayer){
    tellAuto(player,"Miss!");
}

function stringToInt(ins as string, starting as int)as int{
    
    val map1 = {"1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"0":0}as int[string];
    var i=starting;
    var a=0;
    while(i<ins.length){
        if(map1 has ins[i]){
            a=a*10+map1[ins[i]];
            i+=1;
        }
        else return a;
    }
    return a;
}