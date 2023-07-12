#loader crafttweaker reloadableevents
import scripts.advanced.libs.ParticleGenerator as P;
import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.player.IPlayer;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;

static chlorophyteOreConvertion as P.FXGenerator = P.FXGenerator("chlorophyteOreConvertion")
    .addAging(3)
    .updateDefaultData({
        "x":0.0,"y":0.0,"z":0.0,
        "effectiveRadius":50.0
    })
    .setRender(function(player as IPlayer, data as IData)as void{
        for i in 0 to V.randInt(8,18)*V.randInt(8,18){
            var color = V.randInt(0,50)*65536 + V.randInt(200,255)*256 + V.randInt(0,100);
            var pos = V.add(V.readFromData(data),V.scale(V.randomUnitVector(),V.randDouble(0.0,0.5)));
            var v = V.scale(V.randomUnitVector(),V.randDouble(0.5,1.5)/30);
            var d as IData = V.asData(pos) + V.asData(v,"v") + {"c":color, "r":V.randDouble(0.2,0.35),"a":5, "type":"custom"}as IData;
            M.createBotFX(d);
        }
    })
    .regi();

<cotBlock:chlorophyte_ore>.onRandomTick = function(world as IWorld, pos, state){
    var rand1 = /**world.random.nextDouble();/*/V.randDouble(0.0,1.0,world);/**/
    if(rand1*rand1*rand1*256>pos.y)return;
    var range = [-1 as int, 0, 1] as int[];
    var flag = 0;
    var poses as int[][]=[]as int[][];
    //Check neighbors
    
    for i in range{
        for j in range{
            for k in range{
                poses += [i,j,k] as int[];
                var block1 = world.getBlock(M.shiftBlockPos(pos,i,j,k));
                var block2 = world.getBlock(M.shiftBlockPos(pos,-i,-j,-k));
                var w = "water";
                var l = "lava";
                var o = "contenttweaker:chlorophyte_ore";
                if(i*i+j*j+k*k==0)continue;
                if(M.checkBlock(block1,w)&&!M.checkBlock(block2,l))
                    flag = flag | 1;
                if(M.checkBlock(block1,l)&&!M.checkBlock(block2,w))
                    flag = flag | 2;
                if(M.checkBlock(block1,o)&&M.checkBlock(block2,o))
                    return;
            }
        }
    }
    if(flag!=3)return;
    //Check Sunlight
    var time as int=(world.getProvider().getWorldTime()%(24000 as long))as int;
    if(time>11500||time<500)return;
    var angle = 180.0* time / 12000;
    var x_y = V.tanf( 90 - angle );
    for dy in 10 to 2560{
        var dx = x_y * dy;
        if(pos.y + 0.1*dy > 255) break;
        var pos2 = M.shiftBlockPos(pos, 0.1*dx, 0.1*dy, 0);
        if(world.isAirBlock(pos2))continue;
        var state = world.getBlockState(pos2);
        if(isNull(state))continue;
        if(state.translucent)continue;
        return;
    }
    //Count connecting ores
    var list as IBlockPos[] = [pos] as IBlockPos[];
    var n as int = 0;
    while(n<90){
        if(n>= list.length)break;
        for i in poses{
            var pos2 = M.shiftBlockPos(list[n],i[0],i[1],i[2]);
            if(list has pos2)continue;
            if(M.checkBlock(world.getBlock(pos2),"contenttweaker:chlorophyte_ore")){
                list+=pos2;
            }
        }
        n+=1;
    }
    n-=1;
    if(V.randDouble(0.0,1.0,world)>V.sinf(0.0+n))return;
    //Convertion
    var rp = poses[world.random.nextInt(poses.length)]; //randomPos
    var pos2 = M.shiftBlockPos(pos,rp[0],rp[1],rp[2]);
    if(!M.checkBlock(world.getBlock(pos2),"minecraft:mossy_cobblestone"))return;
    var light = world.getBrightnessSubtracted(pos);
    if(V.randDouble(3.0,13.0)<light)return;
    chlorophyteOreConvertion.create(world,V.asData(V.fromBlockPos(pos2)));
    world.catenation().sleep(13).run(function(w,c){
        if(!M.checkBlock(world.getBlock(pos2),"minecraft:mossy_cobblestone"))return;
        w.setBlockState((<contenttweaker:chlorophyte_ore> as IBlock).definition.defaultState,pos2);
    }).start();
};
var itemOre=<contenttweaker:chlorophyte_ore>;
var preFix = "jei.description.chlorophyte_ore.";
var keys = [
    "introduction",
    "liquid",
    "connection",
    "light"
]as string[];
for key in keys{
    mods.jei.JEI.addDescription(itemOre,game.localize(preFix~key));
}