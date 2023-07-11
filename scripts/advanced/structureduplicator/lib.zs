#loader crafttweaker reloadableevents
#priority 50000
#norun
import scripts.advanced.libs.Misc as M;
import scripts.advanced.libs.Data as D;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;

import scripts.advanced.libs.Vector3D as V;/*
events.onPlayerTick(function(event as crafttweaker.event.PlayerTickEvent){
    var player = event.player;
    var block = player.world.getBlock(V.asBlockPos(V.getPos(player)));
    M.shout(block.definition.id);
    M.shout(block.meta);
});*/

zenClass itemBlockConverter{
    var converter as function(IWorld,IBlockPos)IData[] = null;
    static list as [itemBlockConverter] = [] as [itemBlockConverter];
    zenConstructor(converterIn as function(IWorld,IBlockPos)IData[]){
        converter = converterIn;
    }
    zenConstructor(items as IItemStack[], block as IBlock, meta as int, data as IData){
        converter = function( world as IWorld, pos as IBlockPos ) as IData[] {
            var block2 as IBlock = world.getBlock(pos);
            if(block2.definition.id != block.definition.id)return null;
            if(block2.meta != meta)return null;
            if(!block2.data.matches(data))return null;
            var ans = [] as IData[];
            for i in items{
                ans = ans + ({"type":"stack"}+D.fromStack(i))as IData;
            }
            return ans;
        };
    }
    zenConstructor(items as IItemStack[], block as IBlock, matchMeta as bool, matchData as bool){
        converter = function( world as IWorld, pos as IBlockPos ) as IData[] {
            var block2 as IBlock = world.getBlock(pos);
            if(block2.definition.id != block.definition.id)return null;
            if(matchMeta && block2.meta != block.meta)return null;
            if(matchData && !block2.data.matches(block.data))return null;
            var ans = [] as IData[];
            for i in items{
                ans = ans + ({"type":"stack"}+D.fromStack(i))as IData;
            }
            return ans;
        };
    }
    zenConstructor(items as IItemStack[], block as IBlock){
        this = itemBlockConverter(items, block, false, false);
    }
    zenConstructor(item as IItemStack){
        this = itemBlockConverter([item], item as IBlock);
    }
    function regi()as itemBlockConverter{
        list = list + this;
        return this;
    }
}
var liquids = itemBlockConverter(function(world as IWorld, pos as IBlockPos)as IData[]{
    var block = world.getBlock(pos);
    if(!isNull(block.fluid)){
        if(block.meta!=0) return [] as IData[];
        else return [{"type":"fluid"} + D.fromFluid(block.fluid * 1000) ] as IData[];
    }
    return null;
}).regi();
var simpleBlocks = itemBlockConverter(function(world as IWorld, pos as IBlockPos)as IData[]{
    var block = world.getBlock(pos);
    if(!isNull(block.data))return null;
    var id = block.definition.id;
    var meta = block.meta;
    if(!isNull(itemUtils.getItem(id,meta))){
        //Blocks without directions  e.g. wools
        var item = itemUtils.getItem(id,meta);
        if(isNull(item as IBlock))return null;
        var block2 = item as IBlock;
        if(block2.definition.id != block.definition.id)return null;
        if(block2.meta != block.meta)return null;
        return [{"type":"stack"}+D.fromStack(item)];
    }
    else if(isNull(itemUtils.getItem(id,1))&&!isNull(itemUtils.getItem(id))){
        //Blocks only with direction, no meta hack  e.g. stone_stairs
        var item = itemUtils.getItem(id);
        if(isNull(item as IBlock))return null;
        var block2 = item as IBlock;
        if(block2.definition.id != block.definition.id)return null;
        return [{"type":"stack"}+D.fromStack(item)];
    }
    return null;
}).regi();