#loader crafttweaker reloadableevents
#priority 102
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
function getFromData(entity as IEntity, key as string)as IData{
    if(entity.nbt has "ForgeData" && entity.nbt.ForgeData has "doremySweeDanmukuDesign"){
        var temp as IData=entity.nbt.ForgeData.doremySweeDanmukuDesign;
        if(temp has key)return temp.memberGet(key);
    }
    return null;
}
function hasData(entity as IEntity, key as string)as bool{
    if(entity.nbt has "ForgeData" && entity.nbt.ForgeData has "doremySweeDanmukuDesign"){
        var temp as IData=entity.nbt.ForgeData.doremySweeDanmukuDesign;
        if(temp has key)return true;
    }
    return false;
}
function setData(entity as IEntity, key as string, value as IData)as void{
    var rawData=IData.createEmptyMutableDataMap();
    rawData.memberSet(key,value);
    entity.updateNBT({
        ForgeData:{
            "doremySweeDanmukuDesign":
                (entity.nbt has "doremySweeDanmukuDesign")?
                entity.nbt.doremySweeDanmukuDesign + rawData :
                rawData
        }
    });
}
function getIntFromData(entity as IEntity, key as string)as int{
    if(hasData(entity,key))return getFromData(entity,key).asInt();
    return -1 as int;
}
function getDoubleFromData(entity as IEntity, key as string)as double{
    if(hasData(entity,key))return getFromData(entity,key).asDouble();
    return 0.0;
}
function getStringFromData(entity as IEntity, key as string)as string{
    if(hasData(entity,key))return getFromData(entity,key).asString();
    return "";
}