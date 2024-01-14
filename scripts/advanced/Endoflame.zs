#reloadable
import crafttweaker.event.BlockNeighborNotifyEvent;
import scripts.advanced.libs.Vector3D as V;
import mods.zenutils.ICatenationBuilder;
import scripts.advanced.libs.Misc as M;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;
function isEndoFlame(block as IBlock,flag as bool=false)as bool{
    var data = block.data;
    if(isNull(data))return false;
    return (data has "subTileName")&&(flag||data.memberGet("subTileName").asString()=="endoflame");
}
events.onBlockNeighborNotify(function(event as BlockNeighborNotifyEvent){
    var w0 = event.world;
    var p = event.position;
    if(w0.isRemote())return;
    if(isEndoFlame(w0.getBlock(p),false)){
        w0.catenation().run(function(w,c){
            if(isEndoFlame(w.getBlock(p))){
                var dd as IData=w.getCustomChunkData(p);
                if(!(dd has "EndoResV3")){
                    w.updateCustomChunkData({"EndoResV3":{"num":1,"x":[p.x]as int[],"y":[p.y]as int[],"z":[p.z]as int[]}},p);
                    return;
                }
                else{
                    var d as IData=dd.EndoResV3;
                    var x as int[]=[p.x];
                    var y as int[]=[p.y];
                    var z as int[]=[p.z];
                    var n as int=1;
                    for i in 0 to d.num{
                        var p1 = IBlockPos.create(d.x[i], d.y[i], d.z[i]);
                        if(isEndoFlame(w.getBlock(p1))) if((p1.x!=p.x)||(p1.y!=p.y)||(p1.z!=p.z)){
                            x+=p1.x;    y+=p1.y;    z+=p1.z;    n+=1;
                        }
                    }
                    if(n>8){
                        M.sayOld(game.localize("info.crt.endoFlameRes.exceed"),w,V.fromIBlockPos(p));
                        w.destroyBlock(p, true);
                    }
                    else w.updateCustomChunkData({"EndoResV3":{"num":n,"x":x,"y":y,"z":z}}as IData,p);
                }
            }
        }).start();
    }
});
<botania:specialflower>.withTag({type: "endoflame"}).addTooltip(format.bold(format.yellow(game.localize("description.crt.tooltip.flower.endoRestrict"))));