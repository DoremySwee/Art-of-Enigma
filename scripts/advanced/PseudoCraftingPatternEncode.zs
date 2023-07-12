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
    val offHandItem = player.getItemInSlot(IEntityEquipmentSlot.offhand());
    if (world.remote) return;
    if (
        <thaumicwands:item_wand>.matches(event.item) && 
        <appliedenergistics2:material:52>.matches(offHandItem) &&
        <blockstate:avaritia:extreme_crafting_table>.matches(event.blockState)
    ) {
        event.cancel();
        var data as IData = event.block.data;
        var inputs as [IItemStack] = [] as [IItemStack];
        var result as IData = data.memberGet("Result");
        if (isNull(result)) return;
        for i in 0 .. 81 {
            var itemInSlotData as IData = data.memberGet("Craft" ~ i);
            var itemInSlot as IItemStack = isNull(itemInSlotData) ? <botania:manaresource:11> : itemInSlotData.asStack().withAmount(1);
            inputs += itemInSlot;
        }
        var mark as IItemStack = <minecraft:paper>;
        var generateMark as bool = false;
        val upPos = pos.up();
        val upTile = world.getBlock(upPos);
        if (upTile.definition.id == "draconicevolution:placed_item") {
            val upStacks = upTile.data.InventoryStacks;
            if (upStacks.length == 1) {
                mark = upStacks[0].asStack();
                generateMark = true;
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
        var qualifiedInputs as [IItemStack] = [] as [IItemStack];
        var lastElement as IMutableItemStack = null;
        for element in inputs {
            if (element.matches(lastElement)) {
                lastElement.grow(1);
            } else {
                lastElement = element.mutable();
                qualifiedInputs += lastElement;
            }
        }
        var patterns as [[IItemStack]] = [] as [[IItemStack]];
        var patternOutputs as [IItemStack] = [] as [IItemStack];
        var currentPattern as [IItemStack] = [] as [IItemStack];
        for i, element in qualifiedInputs {
            val isLast as bool = (i == (qualifiedInputs.length - 1));
            currentPattern += element;
            if (currentPattern.length == 9 || isLast){
                patterns += currentPattern;
                val output as IItemStack = isLast ? result.asStack() : mark.withAmount(1).withDisplayName(markCustomName ~ (patterns.length));
                patternOutputs += output;
                currentPattern = [output] as [IItemStack];
            }
        }
        val patternCount as int = patterns.length;
        val markCount as int = patternCount - 1;
        if (offHandItem.amount < patternCount) return;
        offHandItem.mutable().shrink(patternCount);
        for i, pattern in patterns {
            player.give(encodePattern(pattern, patternOutputs[i]));
        }
        if (generateMark && mark.amount >= markCount && markCount != 0) {
            if (mark.amount == markCount) {
                world.setBlockState(<blockstate:minecraft:air>, upPos);
            } else {
                world.setBlockState(world.getBlockState(upPos), {InventoryStacks: [D.fromStack(mark.withAmount(mark.amount - markCount))]}, upPos);
            }
            for i in 0 .. markCount {
                player.give(mark.withAmount(1).withDisplayName(markCustomName ~ (i + 1)));
            }
        }
    }
});

function encodePattern(ins as [IItemStack], out as IItemStack) as IItemStack {
    var patternData = IData.createEmptyMutableDataMap();
    var patternInputData as IData = [] as IData;
    for item in ins {
        patternInputData = patternInputData.update([D.fromStack(item)]);
    }
    patternData.memberSet("in", patternInputData);
    patternData.memberSet("crafting", 0 as byte);
    patternData.memberSet("substitute", 0 as byte);
    var markData as IData = [D.fromStack(out)] as IData;
    patternData.memberSet("out", markData as IData);
    return <appliedenergistics2:encoded_pattern>.withTag(patternData);
}

