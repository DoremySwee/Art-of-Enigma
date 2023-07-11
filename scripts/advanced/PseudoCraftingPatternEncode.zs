#reloadable
#debug
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IMutableItemStack;
import crafttweaker.data.IData;
import scripts.advanced.libs.Misc as M;
import scripts.advanced.libs.Data as D;

static alphabet as string = "abcdefghijklmnopqrstuvwxyz";

events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    val player = event.player;
    val world = player.world;
    val pos = event.position;
    if (world.remote) return;
    if (
        <thaumicwands:item_wand>.matches(event.item) && 
        (<appliedenergistics2:material:52> * 10).matches(player.getItemInSlot(IEntityEquipmentSlot.offhand())) &&
        <blockstate:avaritia:extreme_crafting_table>.matches(event.blockState)
    ) {
        event.cancel();
        var data as IData = event.block.data;
        var patterns as [[IItemStack]] = [] as [[IItemStack]];
        var result as IData = data.memberGet("Result");
        if (isNull(result)) return;
        player.getItemInSlot(IEntityEquipmentSlot.offhand()).mutable().shrink(10);
        for x in 0 .. 9 {
            var line as [IItemStack] = [] as [IItemStack];
            for y in 0 .. 9 {
                var itemInSlotData as IData = data.memberGet("Craft" ~ (x * 9 + y));
                var itemInSlot as IItemStack = isNull(itemInSlotData) ? <botania:manaresource:11> : itemInSlotData.asStack().withAmount(1);
                line += itemInSlot;
            }
            patterns += line;
        }
        var qualifiedPatterns as [[IItemStack]] = [] as [[IItemStack]];
        for line in patterns {
            var lastElement as IMutableItemStack = null;
            var qualifiedLine as [IItemStack] = [] as [IItemStack];
            for element in line {
                if (element.matches(lastElement)) {
                    lastElement.grow(1);
                } else {
                    lastElement = element.mutable();
                    qualifiedLine += lastElement;
                }
            }
            qualifiedPatterns += qualifiedLine;
        }
        var mark as IItemStack = <minecraft:paper>;
        var generateMark as bool = false;
        val upPos = pos.up();
        val upTile = world.getBlock(upPos);
        if (upTile.definition.id == "draconicevolution:placed_item") {
            val upStacks = upTile.data.InventoryStacks;
            if (upStacks.length == 1) {
                mark = upStacks[0].asStack();
                if (mark.amount >= 9) {
                    generateMark = true;
                }
            }
        }
        var markCustomName as string = "";
        if (mark.hasDisplayName) {
            markCustomName = mark.displayName;
        } else {
            val random = world.random;
            for i in 0 .. 5 {
                markCustomName ~= alphabet[random.nextInt(26)];
            }
        }
        var totalPattern as IData = [] as IData;
        for i, pattern in qualifiedPatterns {
            var patternData = IData.createEmptyMutableDataMap();
            var patternInputData as IData = [] as IData;
            for item in pattern {
                patternInputData = patternInputData.update([D.fromStack(item)]);
            }
            patternData.memberSet("in", patternInputData);
            patternData.memberSet("crafting", 0 as byte);
            patternData.memberSet("substitute", 0 as byte);
            var markData as IData = [D.fromStack(mark.withAmount(1).withDisplayName(markCustomName ~ (i + 1)))] as IData;
            patternData.memberSet("out", markData as IData);
            totalPattern = totalPattern.deepUpdate(markData, 1);
            player.give(<appliedenergistics2:encoded_pattern>.withTag(patternData));
        }
        var totalPatternData = IData.createEmptyMutableDataMap();
        totalPatternData.memberSet("in", totalPattern);
        totalPatternData.memberSet("crafting", 0 as byte);
        totalPatternData.memberSet("substitute", 0 as byte);
        totalPatternData.memberSet("out", [result] as IData);
        player.give(<appliedenergistics2:encoded_pattern>.withTag(totalPatternData));
        if (generateMark) {
            if (mark.amount == 9) {
                world.setBlockState(<blockstate:minecraft:air>, upPos);
            } else {
                world.setBlockState(world.getBlockState(upPos), {InventoryStacks: [D.fromStack(mark.withAmount(mark.amount - 9))]}, upPos);
            }
            for i in 0 .. 9 {
                player.give(mark.withAmount(1).withDisplayName(markCustomName ~ (i + 1)));
            }
        }
    }
});

