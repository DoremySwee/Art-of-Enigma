#reloadable
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IMutableItemStack;
import crafttweaker.data.IData;
import scripts.advanced.libs.Misc as M;
import scripts.advanced.libs.Data as D;

static alphabet as string = "abcdefghijklmnopqrstuvwxyz";

static wand as IItemStack = <contenttweaker:pattern_wand>;
static pattern as IItemStack = <appliedenergistics2:material:52>;
static table as IItemStack = <avaritia:extreme_crafting_table>;

static noResult as string = game.localize("crt.chat.auto_pattern.no_result");
static noMark as string = game.localize("crt.chat.auto_pattern.no_mark");
static insufficientMark as string = game.localize("crt.chat.auto_pattern.insufficient_mark");
static insufficientPattern as string = game.localize("crt.chat.auto_pattern.insufficient_pattern");

scripts.recipes.libs.Transcript.ava.shaped(wand,scripts.recipes.libs.Mapping.read("
    ______@__;
    ___#_@$@_;
    ___#@$%$@;
    _##&#@$@_;
    *~~#1#@__;
    ~_~_#&##_;
    ~~*~~#___;
    ~_~_~#___;
    *~~~*____;
    ",{
    "@":<mysticalagriculture:certus_quartz_essence>,
    "1":<appliedenergistics2:nether_quartz_wrench>,
    "#":<appliedenergistics2:certus_quartz_wrench>,
    "$":<appliedenergistics2:encoded_pattern>,
    "%":<mysticalagriculture:redstone_essence>,
    "&":<mysticalagriculture:sky_stone_essence>,
    "*":<mysticalagriculture:glowstone_essence>,
    "~":<avaritia:extreme_crafting_table>
}));

mods.jei.JEI.addDescription([wand,pattern,table],[
    game.localize("jei.description.auto_pattern.intro"),
    game.localize("jei.description.auto_pattern.mark"),
    game.localize("jei.description.auto_pattern.structure1")~wand.displayName~game.localize("jei.description.auto_pattern.structure2"),
    game.localize("jei.description.auto_pattern.output")
]);

events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    val player = event.player;
    val world = player.world;
    val pos = event.position;
    val offHandItem = player.getItemInSlot(IEntityEquipmentSlot.offhand());
    if (world.remote) return;
    if (
        wand.matches(event.item) && 
        pattern.matches(offHandItem) &&
        <blockstate:avaritia:extreme_crafting_table>.matches(event.blockState)
    ) {
        event.cancel();
        var data as IData = event.block.data;
        var inputs as [IItemStack] = [] as [IItemStack];
        var result as IData = data.memberGet("Result");
        if (isNull(result)){
            M.tellAuto(player,noResult);
            result = D.fromStack(pattern);
        }
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
            if (upStacks.length > 0) {
                mark = upStacks[0].asStack();
                generateMark = true;
            }
        }
        var markCustomName as string = "";
        if (mark.hasDisplayName) {
            markCustomName = mark.displayName;
        } else {
            markCustomName = result.asStack().displayName;
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
        if (offHandItem.amount < patternCount){
            M.tellAuto(player,insufficientPattern);
            return;
        }
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
        else if(markCount==0){
        }
        else if(!generateMark){
            M.tellAuto(player,noMark);
            return;
        }
        else if(mark.amount < markCount){
            M.tellAuto(player,insufficientMark);
            return;
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

