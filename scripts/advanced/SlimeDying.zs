#loader crafttweaker reloadableevents
import crafttweaker.entity.IEntityDefinition;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityMob;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import mods.zenutils.PlayerStat;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
events.onEntityLivingUpdate(function(event as crafttweaker.event.EntityLivingUpdateEvent){
    var entity as crafttweaker.entity.IEntity=event.entity;
    var world as IWorld=entity.world;
    if(world.remote)return;
    if(isNull(entity))return;
    if(isNull(entity.definition))return;
    if(isNull(entity.definition.id))return;
    var pos as IBlockPos = entity.position;
    if(isNull(world.getBlock(pos))){
        return;
    }
    //Turn slimes blue in liquid bot mana
    if(entity.definition.id=="minecraft:slime"){
        if(isNull(world.getBlock(pos).fluid)){
            return;
        }
        if(world.getBlock(pos).fluid.name!="bot_mana")return;
        var newSlime = <entity:tconstruct:blueslime>.createEntity(world);
        var map as IData = IData.createEmptyMutableDataMap();
        for key,value in entity.nbt.asMap(){
            if(["UUIDMost", "UUIDLeast"]as string[] has key)
                continue;
            else map.memberSet(key,value);
        }
        newSlime.updateNBT(map);
        world.removeEntity(entity);
        world.spawnEntity(newSlime);
    }
    //Blue Slime dye vines!
    if(entity.definition.id=="tconstruct:blueslime"){
        if(world.getBlock(pos).definition.id=="minecraft:vine"&&
            entity.motionY>0.06&&entity.motionY<0.15&&
            !entity.nbt.OnGround.asBool() && !entity.nbt.wasOnGround.asBool()){
                var dat = entity.nbt.deepGet("ForgeData.SlimeVineTicking");
                var counter = isNull(dat)?0:dat.asInt();
                entity.setNBT({"SlimeVineTicking":(counter+1)%8});
                if(counter==7)world.setBlockState((<tconstruct:slime_vine_blue>as IBlock).definition.getStateFromMeta(world.getBlock(pos).meta),pos);
        }
        else{
            entity.setNBT({"SlimeVineTicking":0});
        }
    }
});
<forge:bucketfilled>.withTag({FluidName: "bot_mana", Amount: 1000}).addTooltip(format.aqua(game.localize("description.crt.tooltip.liquid_mana_and_blues_lime")));
var vines as IItemStack[] = [<tconstruct:slime_vine_blue_end>,<tconstruct:slime_vine_blue_mid>, <tconstruct:slime_vine_blue>];
for vine in vines{
    vine.addTooltip(game.localize("jei.description.slime_vine"));
}
mods.jei.JEI.addDescription(vines,game.localize("jei.description.slime_vine"));

val exampleData as IData = {
    HurtByTimestamp: 0, ForgeData: {}, 
    Size: 3, Attributes: [{Base: 0.0, Name: "generic.scales"}, {Base: 16.0, Name: "generic.maxHealth"}, {Base: 0.0, Name: "generic.knockbackResistance"}, 
        {Base: 0.6000000238418579, Name: "generic.movementSpeed"}, {Base: 0.0, Name: "generic.armor"}, {Base: 0.0, Name: "generic.armorToughness"}, 
        {Base: 1.0, Name: "forge.swimSpeed"}, 
        {
            Base: 16.0, Modifiers: [
                {UUIDMost: -6924578462633410119 as long, UUIDLeast: -7953508581528076340 as long, Amount: -0.027568771103469832, Operation: 1, Name: "Random spawn bonus"}], 
            Name: "generic.followRange"
        }
    ], 
    Invulnerable: 0 as byte, FallFlying: 0 as byte, PortalCooldown: 0, 
    AbsorptionAmount: 0.0 as float, FallDistance: 0.0 as float, DeathTime: 0 as short, 
    HandDropChances: [0.085 as float, 0.085 as float], PersistenceRequired: 0 as byte, Motion: [0.0, 0.0, 0.0], 
    wasOnGround: 0 as byte, Leashed: 0 as byte, UUIDLeast: -5652745672515542765 as long, Health: 16.0 as float, 
    LeftHanded: 0 as byte, Air: 300 as short, OnGround: 0 as byte, Dimension: 0, Rotation: [-27.899536 as float, 0.0 as float], 
    UpdateBlocked: 0 as byte, HandItems: [{}, {}], ArmorDropChances: [0.085 as float, 0.085 as float, 0.085 as float, 0.085 as float], 
    UUIDMost: 4551034842705972199 as long, Pos: [-1790.5, 63.0, 1308.5], Fire: -1 as short, ArmorItems: [{}, {}, {}, {}], CanPickUpLoot: 0 as byte, HurtTime: 0 as short
} as IData;