#reloadable
#priority 1000000004
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;

import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Data as D;
import scripts.advanced.libs.Misc as M;



//Can match Tile Data, can be used for special blocks (e.g. Liquid, RedstoneWire)
//If more complicated matching is wanted, please manually write it. This is just for convenience and massive checking.
var ExampleBlockMatcher = {
    "id":"minecraft:chest", 
    "meta": 0, //If meta is not given, then all metas are acceptable
    //"metas": [0,1,3] So that all these meta are acceptable
    "data": {"Items":[{"Slot":13 as byte, "id":"minecraft:nether_star", "Count":1 as byte, "Damage":0 as short}]} 
        // Elements inside a DataList (The square brackets) Matches Exactly. Though if there are more elements than wanted, the test may pass still.
        // So, if more complicated test is wanted, still write it manually.
    //Following datas are for outputs.
    //"itemMeta": int. If assigned, the blockName would be overwritten by <id:itemMeta>
    //"itemId": in case if the block id doesn't match the itemId.
    //"info": following the default info. Example Usage: Quartz Pillar (vertically placed)
    //"default": bool. If assigned as false, defalut info (blockName) would not be displayed in the ouput. Instead, only manually asigned "info" may appear.
}as IData;


function matchBlock ( matcher as IData, block as IBlock )as string{
    var flag = false;
    if(!(matcher has "id"))return "";
    if( M.checkBlock( block , matcher.memberGet("id").asString(), ((matcher has "meta") ? matcher.memberGet("meta").asInt() : 32767)as int/**/) &&
        (!(matcher has "data") || !isNull(block.data) && D.matches(block.data, matcher.memberGet("data")))
    ){
        if(!(matcher has "metas"))return "";
        for meta in matcher.memberGet("metas").asList(){
            if(block.meta==meta.asInt())return "";
        }
    }

    var itemMeta as int = (matcher has "itemMeta") ? matcher.memberGet("itemMeta").asInt() :
        ((matcher has "metas") ? 0 : ((matcher has "meta") ? matcher.memberGet("meta").asInt() : 0) );
    var itemId as string = (matcher has "itemId") ? matcher.memberGet("itemId").asString() : matcher.memberGet("id").asString();
    return (((matcher has "default")&&!matcher.memberGet("default").asBool())?"":itemUtils.getItem(itemId,itemMeta).displayName)
            ~((matcher has "info")?matcher.memberGet("info").asString():"");
    return "";
}
function sigleConvertion ( stack as IItemStack ) as IData{
    return {
        "id":stack.definition.id,
        "meta":stack.metadata
    }as IData;
}
function convertMap ( stacks as IItemStack[string] ) as IData{
    var d = IData.createEmptyMutableDataMap();
    for k,v in stacks{
        d.memberSet(k,sigleConvertion(v));
    }
    return d;
}
function shiftPosWithAxisOrder(pos as IBlockPos, a as int, b as int, c as int, axisOrder as string)as IBlockPos{
    var y=0; var x=0; var z=0;
    var d = [a,b,c] as int[];
    for i in 0 to 3{
        if(i>=axisOrder.length)break;
        if(axisOrder[i]=="x") x = d[i];
        if(axisOrder[i]=="y") y = d[i];
        if(axisOrder[i]=="z") z = d[i];
    }
    return M.shiftBlockPos(pos,x,y,z);
}
function matchExact ( map as IData, pattern as string[], world as IWorld, pos as IBlockPos, shifts as int[], axisOrder as string = "yxz", reverse as bool[] = [false,false,false] ) as string[]{
    var result as string[] = [] as string[];
    for i,face in pattern{
        for j,line in face.split(";"){
            if(line.length<1)continue;
            for k in 0 to line.length{
                var c = line[k];
                if( map has c ){
                    var ds as int[] = [ i+shifts[0], j+shifts[1], k+shifts[2] ];
                    for ii in 0 to 3{
                        if(reverse[ii])ds[ii]=-ds[ii];
                    }
                    var pos2 as IBlockPos=shiftPosWithAxisOrder(pos,ds[0],ds[1],ds[2],axisOrder);
                    var t as string= matchBlock(map.memberGet(c),world.getBlock(pos2));
                    if(t=="")continue;
                    result+=(M.displayBlockPos(pos2)~":  "~t);
                }
            }
        }
    }
    return result;
}
function match ( map as IData, pattern as string[], world as IWorld, pos as IBlockPos, shifts as int[], axisOrder as string = "yxz" ) as string[]{
    var results as string[][]= [] as string[][];
    var temp = [["yxz","yzx"],["xyz","zyx"],["zxy","xzy"]] as string[][];
    var temp2= [[1,2],[0,2],[0,1]] as int[][];
    var ti = 0;
    for i in 0 to 3{
        if(temp[i] has axisOrder)ti=i;
    }
    for i in 0 to 2{
        for j in 0 to 2{
            for k in 0 to 2{
                var p = [false,false,false] as bool[];
                if(j==1)p[temp2[ti][0]]=true;
                if(k==1)p[temp2[ti][1]]=true;
                results += matchExact (map,pattern,world,pos,shifts, temp[ti][i], p);
            }
        }
    }
    var min = results[0].length;
    ti = 0;
    for i,t in results{
        if(t.length<min){
            min=t.length;
            ti=i;
        }
    }
    return results[ti];
}