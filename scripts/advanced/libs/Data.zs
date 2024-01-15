#reloadable
#priority 1000000030
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.data.IData;

function get(data as IData, path as string)as IData{
    var d as IData= data;
    for key in path.split("[.\\[\\]]"){
        if(key=="")continue;
        if(!isNull(d.asMap())){
            if(!(d has key))return null;
            d = d.memberGet(key);
            continue;
        }
        else if(!isNull(d.asList())){
            if(key.matches("\\d+")){
                var n = key as int;
                if(n < d.asList().length){
                    d = d.asList()[n];
                    continue;
                }
            }
            else if(key=="last"){
                d = d.asList()[d.asList().length- 1];
                continue;
            }
        }
        return null;
    }
    return d;
}
$ expand IData $ deepGet(path as string)as IData{
    return get(this,path);
}
function setRaw(data as IData, data2 as IData, path as string, index as int, isList as bool)as IData{
    var TESTING=false;
    if(index>=path.length)return data2;
    var key = "";
    var isNextList = isList;
    var jt = 0;
    for j in index to path.length{
        jt=j;
        //if(path[j]=="]")continue;
        if(path[j]=="["){
            isNextList = true;
            break;
        }
        if(path[j]=="." || path[j]=="]"){
            isNextList = false;
            break;
        }
        key+=path[j];
    }
    if(key==""){
        return setRaw(data, data2, path, jt+1, isNextList);
    }
    if(!isList){
        var d = IData.createEmptyMutableDataMap();
        if(isNull(data.asMap())){
            if ( TESTING ) print("key:"~key~";  return:"~(d));
            return d;
        }
        else{
            var flag = true;
            for k,v in data.asMap(){
                if(k==key){
                    d.memberSet(key, setRaw(data.memberGet(key), data2, path, jt+1, isNextList));
                    flag=false;
                }
                else d.memberSet(k,v);
            }
            if(flag)d.memberSet(key, setRaw({}, data2, path, jt+1, isNextList));
            if ( TESTING ) print("key:"~key~";  return:"~(d));
            return d;
        }
    }
    else{
        if(!key.matches("\\d+") && key!="last")return data;
        if(isNull(data.asList()))return data;
        var n = (key=="last")?data.asList().length:(key as int);
        if(n > data.asList().length)return data;
        var d=setRaw({}, data2, path, jt+1, isNextList);
        var list =[]as IData;
        for i in 0 to data.asList().length{
            if(i==n)list=list+[d];
            else list=list+[data.asList()[i]];
            //print(i~"  "~list);
        }
        if(data.asList().length==n)list=list+[d];
        if ( TESTING ) print("key:"~key~";  return:"~list);
        return list as IData;
    }
}
function set(data as IData, data2 as IData, path as string)as IData{
    return setRaw(data,data2,path,0,false);
}
$ expand IData $ deepSet(data as IData,path as string)as IData{
    return set(this,data,path);
}
function matches(data as IData, data2 as IData)as bool{
    return data==({}as IData + data).deepUpdate(data2,mods.zenutils.DataUpdateOperation.MERGE);
}
$ expand IData $ matches(data as IData)as bool{
    return matches(this,data);
}

/*
//Example
    var data = {
        "a":[{"b":114},{"b":514}]
    } as IData;
    data=set(data,{"aaa":1919},"a[last]b");
    data=set(data,data,"a[last].b");
    print(data);
    print(get(data,"a[last].b.a.[0].b"));
    print( matches({"a":114,"b":[{"x":1},{"x":2}]},{"b":[{"x":2}]}));  //true
*/

function copyMap(data as IData)as IData{
    if(isNull(data.asMap()))return {}as IData;
    var result = IData.createEmptyMutableDataMap();
    for k,v in data.asMap(){
        result.memberSet(k,v);
    }
    return result;
}


function fromStack(stack as IItemStack)as IData{
    var d = IData.createEmptyMutableDataMap();
    d.memberSet("id",stack.definition.id);
    d.memberSet("Damage",stack.damage);
    d.memberSet("Count", stack.amount);
    if(stack.hasTag)d.memberSet("tag",stack.tag);
    return d;
}
function getStack(data as IData)as IItemStack{
    if(data has "id"){
        var stack as IItemStack=itemUtils.getItem(data.id as string);
        if(data has "Damage")stack=stack.definition.makeStack(data.Damage as int);
        if(data has "tag")stack=stack.withTag(data.tag);
        if(data has "Count") stack = stack.withAmount(data.Count as int);
        return stack;
    }
    return null;
}

$ expand IData $ asStack()as IItemStack{
    return getStack(this);
}

function fromBlockPos(pos as IBlockPos)as IData{
    return {
        "x":pos.x,
        "y":pos.y,
        "z":pos.z
    }as IData;
}
function getBlockPos(data as IData)as IBlockPos{
    if(data has "x" && data has "y" && data has "z"){
        return IBlockPos.create(data.x.asInt(),data.y.asInt(),data.z.asInt());
    }
    return IBlockPos.create(0,0,0);
}

$ expand IData $ asBlockPos()as IBlockPos{
    return getBlockPos(this);
}

function fromFluid(stack as ILiquidStack)as IData{
    var d = IData.createEmptyMutableDataMap();
    d.memberSet("FluidName",stack.name);
    d.memberSet("Amount",stack.amount);
    if(!isNull(stack.tag))d.memberSet("Tag",stack.tag);
    return d;
}
/*
function asFluid(data as IData)as ILiquidStack{
    if(data has "id"){
        var stack as IItemStack=itemUtils.getItem(data.id as string);
        if(data has "Damage")stack=stack.definition.makeStack(data.Damage as int);
        if(data has "tag")stack=stack.withTag(data.tag);
        return stack;
    }
    return null;
}*/