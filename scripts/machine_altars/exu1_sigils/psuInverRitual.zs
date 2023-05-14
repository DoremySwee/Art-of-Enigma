#loader crafttweaker reloadableevents
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityMob;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import scripts.LibReloadable as L;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
//east,south,west,north
//x+,z+,x-,z-
function shift(pos as IBlockPos, x as int, z as int)as IBlockPos{
    return IBlockPos.create(pos.x+x,pos.y,pos.z+z);
}
function getItemsInChest(block as IBlock)as IItemStack[]{
    if(block.definition.id!="minecraft:chest")return [];
    if(isNull(block.data))return [];
    var data as IData=block.data;
    if(!(data has "Items"))return [];
    var data1 as [IData]=data.Items.asList();
    var result as IItemStack[]=[];
    for data2 in data1{
        var stack=L.formStackFromNBT(data2);
        result+=stack;
    }
    return result;
}
static CHESTS as [IItemStack][string]={
    "east":[
        <minecraft:potion>.withTag({Potion: "minecraft:long_night_vision"}),
        <minecraft:potion>.withTag({Potion: "minecraft:long_invisibility"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_leaping"}),
        <minecraft:potion>.withTag({Potion: "minecraft:long_fire_resistance"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_swiftness"}),
        <minecraft:potion>.withTag({Potion: "minecraft:long_slowness"}),
        <minecraft:potion>.withTag({Potion: "minecraft:long_water_breathing"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_healing"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_harming"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_poison"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_regeneration"}),
        <minecraft:potion>.withTag({Potion: "minecraft:strong_strength"}),
        <minecraft:potion>.withTag({Potion: "minecraft:long_weakness"}),
        <minecraft:potion>.withTag({Potion: "minecraft:luck"})
    ],
    "south":[
        <minecraft:dirt>,
        <minecraft:grass>,
        <minecraft:sand>,
        <minecraft:gravel>,
        <minecraft:clay>,
        <minecraft:gold_ore>,
        <minecraft:iron_ore>,
        <minecraft:coal_ore>,
        <minecraft:lapis_ore>,
        <minecraft:redstone_ore>,
        <minecraft:emerald_ore>,
        <minecraft:diamond_ore>
    ],
    "west":[
        <minecraft:record_13>,
        <minecraft:record_cat>,
        <minecraft:record_blocks>,
        <minecraft:record_chirp>,
        <minecraft:record_far>,
        <minecraft:record_mall>,
        <minecraft:record_mellohi>,
        <minecraft:record_stal>,
        <minecraft:record_strad>,
        <minecraft:record_ward>,
        <minecraft:record_11>,
        <minecraft:record_wait>
    ],
    "north":[
        <minecraft:stone>,
        <minecraft:hardened_clay>,
        <minecraft:glass>,
        <minecraft:coal:1>,
        <minecraft:gold_ingot>,
        <minecraft:iron_ingot>,
        <minecraft:dye:2>,
        <minecraft:cooked_porkchop>,
        <minecraft:cooked_fish>,
        <minecraft:cooked_beef>,
        <minecraft:cooked_chicken>,
        <minecraft:baked_potato>,
        <minecraft:cooked_mutton>,
        <minecraft:cooked_rabbit>
    ]
};
function stacksMatch(a as IItemStack[],b as IItemStack[])as bool{
    var f as bool[]=[];
    if(a.length!=b.length)return false;
    var n as int=a.length;
    for i in 0 to n{
        f+=true;
    }
    for i in 0 to n{
        var g=true;
        for j in 0 to n{
            if(f[j]&&b[j].commandString==a[i].commandString){
                f[j]=false;
                g=false;
                break;
            }
        }
        if(g)return false;
    }
    return true;
}
function countWire(world as IWorld, pos as IBlockPos)as bool{
    var pat as string[]=[
        "AAAAAAAAB",
        "BBBBBBBAB",
        "BAAAAABAB",
        "BABBBABAB",
        "BABAXABAB",
        "BABABBBAB",
        "BABAAAAAB",
        "BABBBBBBB",
        "BAAAAAAAA"
    ];
    for iii in 0 to 2{
        var mapper as string[string]={
            "A":"minecraft:tripwire",
            "B":"minecraft:redstone_wire"
        };
        for jjj in 0 to 2{
            var flag=false;
            for i in 0 to 9{
                for j in 0 to 9{
                    var p as string=pat[i][j];
                    if(p=="X")continue;
                    if(!L.isBlock(world,shift(pos,i- 4,j- 4),mapper[p]))flag=true;
                    if(flag)break;
                }
                if(flag)break;
            }
            if(!flag)return true;
            mapper={
                "B":"minecraft:tripwire",
                "A":"minecraft:redstone_wire"
            };
        }
        pat=[
            "BAAAAAAAA",
            "BABBBBBBB",
            "BABAAAAAB",
            "BABABBBAB",
            "BABAXABAB",
            "BABBBABAB",
            "BAAAAABAB",
            "BBBBBBBAB",
            "AAAAAAAAB"
        ];
    }
    return false;
}
function checkRitual(world as IWorld, pos as IBlockPos)as string[]{
    var result as string[]=[];
    var flag=true;
    if(world.getDimension()!=1 as int){
        //L.say(world.getDimension());
        return [game.localize("chat.crt.exu1sigil2.wrongdimension")];
    }
    if(!L.isBlock(world,pos,"minecraft:beacon")){
        result+="ERROR: The Block is not beacon. This should be a bug in the code. Report this to the author of the modpack";
        flag=false;
    }
    //check the chest
    var xs as int[]=[5,0,-5 as int,0];
    var zs as int[]=[0,5,0,-5 as int];
    var facingMeta as int[]=[4,2,5,3];
    var direction as string[]=["east","south","west","north"];
    var color1 as string[]=["§b","§a","§e","§c"];
    var color2 as string[]=["§1","§2","§6","§4"];
    var reset as string="§r";
    for i in 0 to 4{
        var pos2 as IBlockPos=shift(pos,xs[i],zs[i]);
        var missing as string=game.localize(("chat.crt.exu1sigil2.missing."~direction[i])as string);
        var facing as string=game.localize(("chat.crt.exu1sigil2.facing."~direction[i])as string);
        var req0 as string=game.localize(("chat.crt.exu1sigil2.req."~direction[i])as string);
        var prepared as string=game.localize(("chat.crt.exu1sigil2.prepared."~direction[i])as string);
        if(!L.isBlock(world,pos2,"minecraft:chest")){
            result+=(color2[i]~missing~" ("~pos2.x~", "~pos2.y~", "~pos2.z~")§r")as string;
            flag=false;
        }
        else if(facingMeta[i]!=world.getBlock(pos2).meta){
            result+=(color2[i]~facing~reset)as string;
            flag=false;
        }
        else{
            if(!stacksMatch(getItemsInChest(world.getBlock(pos2)),CHESTS[direction[i]])){
                var req as string=(color1[i]~req0)as string;
                for item in CHESTS[direction[i]]{
                    //var display as string=(item.hasTag&&(item.tag!={}))?item.commandString:item.displayName;
                    req=req~"\n      "~color1[i]~item.displayName~" §o( "~item.commandString~" )§r";
                }
                flag=false;
                result+=req;
            }
            else{
                result+=(color1[i]~prepared~reset)as string;
            }
        }
    }
    //Check Wires
    if(countWire(world,pos)){
        result+=game.localize("chat.crt.exu1sigil2.completewire");
    }
    else{
        result+=game.localize("chat.crt.exu1sigil2.imcompletewire");
        flag=false;
    }
    //EndUp
    if(flag){
        result+=game.localize("chat.crt.exu1sigil2.complete");
        result+=game.localize("chat.crt.exu1sigil2.sacrifice");
    }
    else{
        result+=game.localize("chat.crt.exu1sigil2.imcomplete");
    }
    return result;
}
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    if(event.player.world.remote)return;
    /*if(!isNull(event.block)&&event.block.definition.id=="minecraft:chest"){
        var logstring as string="";
        for i in getItemsInChest(event.block){
            //L.say(i.commandString);
            logstring=logstring~i.commandString~",\n";
        }
        print(logstring);
    }*/
    if(!isNull(event.block)&&event.block.definition.id=="minecraft:beacon"&&!isNull(event.item)&&event.item.definition.id=="contenttweaker:divisionsigilactivated"){
        for i in checkRitual(event.player.world,event.position){
            event.player.sendChat(i);
        }
    }
});
static tagName as string="PseudoInversionRirualKill";
// work as a counter on player, and a tag on mob
function setKill(player as IPlayer, n as int){
    var data as IData=IData.createEmptyMutableDataMap();
    data.memberSet(tagName,n);
    player.update(data);
}
function getKill(player as IPlayer) as int{
    if(isNull(player))return -1 as int;
    if(player.data has tagName)return player.data.memberGet(tagName).asInt();
    else return -1 as int;
}
events.onEntityLivingDeath(function(event as crafttweaker.event.EntityLivingDeathEvent){
    var entity as crafttweaker.entity.IEntity=event.entity;
    var world as IWorld=entity.world;
    if(world.remote)return;
    if(event.damageSource.immediateSource instanceof IPlayer){
        var player as IPlayer=event.damageSource.immediateSource;
        if(entity.definition.id=="minecraft:villager_golem") {
            for i in -5 as int to 6{
                for j in -3 as int to 4{
                    for k in -5 as int to 6{
                        //L.say("B");
                        var pos as IBlockPos=IBlockPos.create(entity.x as int+i,entity.y as int+j,entity.z as int+k);
                        if(L.isBlock(world,pos,"minecraft:beacon")){
                            //L.say("A");
                            var check as string[]=checkRitual(world,pos);
                            if(check[check.length- 1]==game.localize("chat.crt.exu1sigil2.sacrifice")){
                                player.sendChat(game.localize("chat.crt.exu1sigil2.start"));
                                setKill(player,0);
                                world.performExplosion(null, pos.x, pos.y, pos.z, 5, true, true);
                                world.performExplosion(null, pos.x+5, pos.y, pos.z, 2, true, true);
                                world.performExplosion(null, pos.x- 5, pos.y, pos.z, 2, true, true);
                                world.performExplosion(null, pos.x, pos.y, pos.z+5, 2, true, true);
                                world.performExplosion(null, pos.x, pos.y, pos.z- 5, 2, true, true);
                                world.catenation().run(function(w,c){
                                    w.performExplosion(null, pos.x+5, pos.y, pos.z, 2, true, true);
                                    w.performExplosion(null, pos.x- 5, pos.y, pos.z, 2, true, true);
                                    w.performExplosion(null, pos.x, pos.y, pos.z+5, 2, true, true);
                                    w.performExplosion(null, pos.x, pos.y, pos.z- 5, 2, true, true);
                                }).start();
                            }
                            else{
                                for i in check{
                                    player.sendChat(i);
                                }
                            }
                            return;
                        }
                    }
                }
            }
        }
        else if(entity instanceof IEntityMob){
            if(entity.nbt.ForgeData has tagName && getKill(player)>-1 && world.getDimension()==1){
                setKill(player,getKill(player)+1);
                player.sendChat("kill:"~getKill(player));
                if(getKill(player)>99){
                    player.sendChat(game.localize("chat.crt.exu1sigil2.end"));
                    for i in 0 to player.inventorySize{
                        if(!isNull(player.getInventoryStack(i))&&(player.getInventoryStack(i).definition.id=="contenttweaker:divisionsigilactivated")){
                            player.replaceItemInInventory(i,<contenttweaker:psuinversigil>);
                            break;
                        }
                    }
                    setKill(player,-1);
                    for i in world.getEntitiesInArea(IBlockPos.create((player.x- 130)as int,0,(player.z- 130) as int),IBlockPos.create((player.x+130)as int,255,(player.z+130) as int)){
                        if(isNull(i))continue;
                        if(i instanceof IEntityMob && i.getNBT().ForgeData has tagName){
                            world.removeEntity(i);
                        }
                    }
                }
            }
        }
    }
});
function canEntitySpawn(world as IWorld, pos as IBlockPos, mob as IEntityDefinition)as bool{
    if(!world.getBlockState(pos).isSideSolid(world, pos, crafttweaker.world.IFacing.up()))return false;
    var entity0 as IEntity=mob.createEntity(world);
    if(!(entity0 instanceof IEntityLiving))return false;
    var entity as IEntityLiving=entity0;
    entity.posX=0.5+pos.x;
    entity.posY=1.0+pos.y;
    entity.posZ=0.5+pos.z;
    if(!world.getBlockState(pos).canEntitySpawn(entity))return false;
    if(!entity.canSpawnHere)return false;
    if(entity.isColliding)return false;
    return true;
}
function getTopBlock(world as IWorld, pos as IBlockPos, mob as IEntityDefinition)as IBlockPos{
    var y as int=pos.y;
    //print(y);
    if(y>255)y=255;
    while(y>-1){
        var pos2=IBlockPos.create(pos.x,y,pos.z);
        if(canEntitySpawn(world,pos2,mob))return pos2;
        y-=1;
    }
    if(pos.y<255)return getTopBlock(world,IBlockPos.create(pos.x,255,pos.z),mob);
    return null;
}
static MobsSpawning as IEntityDefinition[]=[
    <entity:minecraft:enderman>,
    <entity:minecraft:evocation_illager>,
    <entity:minecraft:skeleton>,
    <entity:minecraft:spider>,
    <entity:minecraft:stray>,
    <entity:minecraft:zombie>,
    <entity:minecraft:wither_skeleton>,
    <entity:minecraft:witch>,
    <entity:minecraft:vindication_illager>,
    <entity:minecraft:cave_spider>,
    <entity:minecraft:blaze>
];
static MAX_ENEMY_SPAWN as int=300;
events.onPlayerTick(function(event as crafttweaker.event.PlayerTickEvent){
    var player as IPlayer=event.player;
    var world as IWorld=player.world;
    if(world.remote)return;
    var pos as IBlockPos=IBlockPos.create(player.x as int,player.y as int,player.z as int);
    if(getKill(player)>-1 && world.getDimension()==1){
        var counter as int=0;
        for i in world.getEntitiesInArea(IBlockPos.create((player.x- 130)as int,0,(player.z- 130) as int),IBlockPos.create((player.x+130)as int,255,(player.z+130) as int)){
            if(isNull(i))continue;
            if(i instanceof IEntityMob)counter+=1;
            //L.say(counter);
            if(counter>MAX_ENEMY_SPAWN)return;
        }
        for iii in 0 to 3{
            var entityDef as IEntityDefinition=MobsSpawning[
                (0.9999*MobsSpawning.length*Math.random())as int
            ];
            for jjj in 0 to 5{
                var r as double=24.0+90.0*Math.random();
                var theta as double=3.1416*2*Math.random();
                var y as int=30+player.y;
                var pos as IBlockPos=getTopBlock(
                    world,IBlockPos.create(
                        (player.x+r*Math.cos(theta))as int, y, 
                        (player.z+r*Math.sin(theta))as int
                    ),entityDef);
                if(isNull(pos))continue;
                var entity0 as IEntity=entityDef.createEntity(world);
                    var entity as IEntityLiving=entity0;
                    entity.posX=0.5+pos.x;
                    entity.posY=1.0+pos.y;
                    entity.posZ=0.5+pos.z;
                    var data as IData=IData.createEmptyMutableDataMap();
                    data.memberSet(tagName,player.uuid);
                    entity.setNBT(data);
                    world.spawnEntity(entity);
                    entity.addPotionEffect(<potion:minecraft:speed>.makePotionEffect(2000000000,4));
                    break;
            }
        }
    }
});
events.onEntityLivingUpdate(function(event as crafttweaker.event.EntityLivingUpdateEvent){
    if(event.entity instanceof IEntityLiving){
        var entity as IEntityLiving=event.entity;
        var world as IWorld=entity.world;
        if(world.remote)return;
        if(entity.getNBT().ForgeData has tagName){
            var uuid as string=entity.getNBT().ForgeData.memberGet(tagName).asString();
            if(getKill(world.getPlayerByUUID(mods.zenutils.UUID.fromString(uuid)))<0)world.removeEntity(entity);
        }
    }
});