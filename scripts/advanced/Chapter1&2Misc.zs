#loader crafttweaker reloadableevents
import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;
//Nether Portal Ban
events.onPortalSpawn(function (event as crafttweaker.event.PortalSpawnEvent){
    event.cancel();
    M.say(game.localize("quests.ch2.portalCancel.des"),event.world,V.fromBlockPos(event.position));
});
//Leaf drops
events.onBlockHarvestDrops(function(event as crafttweaker.event.BlockHarvestDropsEvent){
    if(event.block.definition.id=="minecraft:leaves" && event.block.meta%4==0){
        event.drops += <minecraft:sapling>.weight(0.3);
        event.drops += <minecraft:golden_apple>.weight(0.005);
    }
});
//golden apple: haste
events.onEntityLivingUseItemFinish(function(event as crafttweaker.event.EntityLivingUseItemEvent.Finish){
    if(event.isPlayer&&(event.item.definition.id==<minecraft:golden_apple>.definition.id)){
        event.player.addPotionEffect(<potion:minecraft:haste>.makePotionEffect(1800,2));
    }
});
//terraplate: do not disappear
events.onItemExpire(function(event as crafttweaker.event.ItemExpireEvent){
    if(event.item.item.definition.id==<botania:terraplate>.definition.id){
        event.extraLife=1919810;
        event.cancel();
    }
});
//cocoon: can't right click. Instead, drop items around it
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    if(event.block.definition.id==<botania:cocoon>.definition.id){
        event.cancel();
    }
});

//disable warning from randomTweaker
addRegexLogFilter("^.*cocoon.*");
addRegexLogFilter("^WARNING.*");
addRegexLogFilter("^[RandomTweaker].*");
addRegexLogFilter("^ [RandomTweaker].*");

//some tooltips
<minecraft:golden_apple>.addTooltip(format.gold(format.italic(game.localize("description.crt.tooltip.haste"))));
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
    .addTooltip(format.red(format.italic(game.localize("description.crt.slime.spawnerworkingcondition1"))));
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
    .addTooltip(format.yellow(format.italic(game.localize("description.crt.slime.spawnerworkingcondition2"))));
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
    .addTooltip(format.green(format.italic(game.localize("description.crt.slime.spawnerworkingcondition3"))));