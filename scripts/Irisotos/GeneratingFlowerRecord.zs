#loader crafttweaker reloadable


import crafttweaker.event.BlockNeighborNotifyEvent;
import crafttweaker.event.BlockPlaceEvent;
import crafttweaker.event.WorldTickEvent;
import scripts.LibReloadable as L;
import crafttweaker.data.IData;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import mods.ctutils.utils.Math;

static generatingFlowers as string[] = [
    "hydroangeas",
    "endoflame",
    "thermalily",
    "arcanerose",
    "munchdew",
    "entropinnyum",
    "kekimurus",
    "gourmaryllis",
    "narslimmus",
    "spectrolus",
    "dandelifeon",
    "rafflowsia",
    "shulk_me_not",
    "irisotos"
];

function getSpecialFlower(w as IWorld, p as IBlockPos) as string{
    var d as IData=w.getBlock(p).data;
    if(!isNull(d) && d has "subTileName") {
        return d.subTileName.asString();
    } else {
        return "empty";
    }
}

events.onBlockNeighborNotify(function(event as BlockNeighborNotifyEvent) {
    val name as string = getSpecialFlower(event.world, event.position);
    val world as IWorld = event.world;
    if (false) {
        world.updateCustomWorldData({generatingFlowers : {}});
    }
    if (generatingFlowers has name) {
        val recordMap as IData[string] = world.getCustomWorldData().generatingFlowers.asMap();
        val posData as IData = {x: event.x, y: event.y, z: event.z, working: false} as IData;
        val toUpdate as IData = IData.createEmptyMutableDataMap();
        for key, data in recordMap {
            if (key != name) {
                toUpdate.memberSet(key, data);
            }
        }
        if (recordMap has name) {
            toUpdate.memberSet(name, recordMap[name].update([posData]));
        } else {
            toUpdate.memberSet(name, [posData]);
        }
        world.updateCustomWorldData({generatingFlowers: toUpdate as IData});
        print(world.getCustomWorldData().generatingFlowers.asString());
    }
});

events.onWorldTick(function(event as WorldTickEvent) {
    val world as IWorld = event.world;
    if (world.remote || event.phase == "END") return;
    val recordData as IData = world.getCustomWorldData().generatingFlowers;
    if (isNull(recordData)) {
        world.updateCustomWorldData({generatingFlowers : {}});
    }
    val toUpdate as IData = IData.createEmptyMutableDataMap();
    for key, data in world.getCustomWorldData().generatingFlowers.asMap() {
        var newData as IData = [];
        for flowerData in data.asList() {
            var pos as IBlockPos = IBlockPos.create(flowerData.x.asInt(), flowerData.y.asInt(), flowerData.z.asInt());
            if (getSpecialFlower(world, pos) == key) {
                var work as bool = true;
                var tileData as IData = world.getBlock(pos).data;
                if (key == "hydroangeas" || key == "thermalily") {
                    work = tileData.burnTime.asInt() != 0 || tileData.cooldown.asInt() != 0;
                } else if (key == "endoflame" || key == "gourmaryllis") {
                    work = tileData.burnTime.asInt() != 0;
                } else if (key == "munchdew") {
                    work = tileData.ateOnce.asBool();
                } else if (key == "arcanerose") {
                    // TODO
                } else if (key == "kekimurus") {
                    // TODO
                } else if (key == "entropinnyum") {
                    // TODO
                } else if (key == "spectrolus") {
                    // TODO
                } else if (key == "dandelifeon") {
                    // TODO
                } else if (key == "rafflowsia") {
                    // TODO
                } else if (key == "shulk_me_not") {
                    // TODO
                }
                newData = newData.update([flowerData.update({working: work})]);
            }
        }
        toUpdate.memberSet(key, newData);
    }
    world.updateCustomWorldData({generatingFlowers: toUpdate as IData});
});

<cotSubTile:irisotos>.onUpdate = function(tile, world, pos) {
    if (world.remote) return;
    val recordData as IData = world.getCustomWorldData().generatingFlowers;
    val checks as int[string] = {};
    var iristosCount as int = 0;
    for flower in generatingFlowers {
        if (flower != "irisotos") {
            checks[flower] = 0;
        }
    }
    for key, data in world.getCustomWorldData().generatingFlowers.asMap() {
        if (key != "irisotos") {
            for flowerData in data.asList() {
                if (Math.abs(pos.x - flowerData.x) <= 15 && Math.abs(pos.z - flowerData.z) <= 15) {
                    if (flowerData.working.asBool()) {
                        checks[key] = checks[key] + 1;
                    }
                }
            }
        } else {
            iristosCount += 1;
        }
    }
    for key, count in checks {
        if (iristosCount > count) {
            return;
        }
    }
    tile.addMana(500);
};
