#loader crafttweaker reloadableevents
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLiving;
import scripts.advanced.libs.Misc as M;
import crafttweaker.entity.IEntityMob;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
events.onWorldTick(function(event as crafttweaker.event.WorldTickEvent){
    var MANA_AMOUNT as int=20000;
    var world as IWorld=event.world;
    if(world.remote)return;
    for i in world.getEntities(){
        if(isNull(i.definition))continue;
        if(i.definition.id!="botania:mana_burst")continue;
        if(isNull(i.nbt))continue;
        if(isNull(i.nbt.lensStack))continue;
        if(isNull(i.nbt.lensStack.id))continue;
        if(i.nbt.lensStack.id=="botania:laputashard"){
            i.updateNBT({mana:MANA_AMOUNT,startingMana:MANA_AMOUNT/3});
        }
        else if (!isNull(i.nbt.lensStack.Damage)){
            if(i.nbt.lensStack.Damage==5000){
                var MANA_AMOUNT2=120*15*180;
                i.updateNBT({mana:MANA_AMOUNT2,startingMana:MANA_AMOUNT2/5});
                //M.shout("success!");
            }
        }
    }
});


/*
{
    lensStack: {
        id: "botania:laputashard", 
        Count: 1 as byte, 
        tag: {
            _heightscale: 0.5528675482345251, 
            _blockname: "appliedenergistics2:quartz_block",
            _pointy: 0 as byte, 
            iterationI: 27, 
            iterationJ: 12, 
            iterationK: 17, 
            _meta: 0, 
            _x: -1767, 
            _y: 63,
            _yStart: 61, 
            _z: 1268, 
            _tile: {}
        },
        Damage: 0 as short
    }, 
    shake: 0 as byte, 
    xTile: -1, 
    color: 60159, 
    ticksExisted: 19, 
    Invulnerable: 0 as byte, 
    hasShooter: 0 as byte, 
    PortalCooldown: 0, 
    startingMana: 1, 
    FallDistance: 0.0 as float, 
    inTile: "minecraft:air", 
    ownerName: "", 
    zTile: -1, 
    yTile: -1, 
    spreaderZ: 0, 
    spreaderY: 0, 
    spreaderX: 0, 
    Motion: [0.0, 0.35, 0.0], 
    UUIDLeast: -6487563481672708902 as long, 
    inGround: 0 as byte, 
    manaLossTick: 0.0 as float, 
    Air: 300 as short, 
    OnGround: 0 as byte, 
    Dimension: 0, 
    Rotation: [0.0 as float, 88.702965 as float], 
    UpdateBlocked: 0 as byte, 
    minManaLoss: 0, 
    UUIDMost: 147806588549481705 as long, 
    mana: 1, 
    Pos: [-1753.5, 68.29999999999994, 1271.5], 
    gravity: 0.0 as float, 
    Fire: -1 as short, 
    lastMotionZ: 0.0, 
    lastMotionY: 0.35, 
    lastMotionX: 0.0
}
*/