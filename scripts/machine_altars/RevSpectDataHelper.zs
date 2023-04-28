#loader crafttweaker reloadableevents
#norun
import crafttweaker.event.BlockNeighborNotifyEvent;
import crafttweaker.command.ICommandManager;
import mods.zenutils.ICatenationBuilder;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import scripts.LibReloadable as L;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;
function isSpecilaFlower(w as IWorld, p as IBlockPos)as bool{
    var d as IData=w.getBlock(p).data;
    L.say("B");
    if(isNull(d))return false;
    L.say("C");
    return d has "subTileName";
}
//Record All Bot Special Flower
events.onBlockNeighborNotify(function(event as BlockNeighborNotifyEvent){
    var w0 as IWorld=event.world;
    val p as IBlockPos=event.position;
    L.say(p.y);
    var d0 as IData=w0.getBlock(p).data;
    //if(isNull(w0))L.say("TTT");
    //if(w0.remote)L.say("THITU");
    if(w0.remote)return;
    //L.say("PPPP");
    //L.say(w0.getBlock(p).definition.id);
    if(!isNull(d0) && d0 has "subTileName"){
        L.say("AAAA");
    }
        /*
    if(isSpecilaFlower(w0,p))w0.catenation().run(function(w,c){
        L.say("A");
        if(isSpecilaFlower(w,p)){
            var datChunk as IData=w.getCustomChunkData(p);
            var list as IData[]=[];
            if(!isNull(datChunk)&&(datChunk has"SFPosesV1")){
                list=(datChunk.SFPosesV1).asList();
            }
            var f=true;
            var posDat as IData={"x":p.x,"y":p.y,"z":p.z};
            var list1 as IData[]=[];
            for i in list{
                f=f&&(posDat!=i);  
                if(isSpecilaFlower(w,crafttweaker.util.Position3f.create(i.x, i.y, i.z)as IBlockPos))
                    list1+=i;
            }
            if(f)list1+=posDat;
            var result as IData=list1;
            if(isNull(dataChunk))w.setCustomChunkData({"SFPosesV1":result},p);
            w.updateCustomChunkData({"SFPosesV1":result},p);
        }
    }).start();/*print("A");/**/
});
