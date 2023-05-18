import crafttweaker.item.ITooltipFunction;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
function getManaInTablet(item as IItemStack)as string{
    var amount as string="0";
    if(item.hasTag){
        if((item.tag has "creative")&&(item.tag.creative==(1 as byte)))
            amount=game.localize("description.crt.manatab.inf");
        else if (item.tag has "mana")
            amount=""~item.tag.mana.asInt();
    }
    return "§b"~game.localize("description.crt.manatab.has")~"§b§o"~amount~"mana§r";
}
function getItemsInCell(data as IData)as string[]{
    var ans as string[]=[]as string[];
    for i in 0 to 63{
        var index as string="#"~i;
        if(!(data has index))break;
        var itemData as IData=data.memberGet(index);
        var item as IItemStack=itemUtils.getItem(itemData.id,itemData.Damage);
        if(itemData has "tag")item=item.withTag(itemData.tag);
        var temp as string="§b"~itemData.Count~"§r * "~item.displayName;
        ans=ans+temp;
    }
    return ans;
}
function spaces(n as int)as string{
    var ans="";
    for i in 0 to n{
        ans=ans~" ";
    }
    return ans;
}
static maxShortCount as int=15;
function shortCellDisplay(item as IItemStack)as string{
    if(!item.hasTag)return game.localize("description.crt.itemcell.empty");
    var ans as string=game.localize("description.crt.itemcell.has");
    var list as string[]=getItemsInCell(item.tag);
    if(list.length<1)return game.localize("description.crt.itemcell.empty");
    var counter as int=0;
    for i in list{
        ans=ans~"\n    ";
        ans=ans~i;
        counter=counter+1;
        if(counter>=maxShortCount)break;
    }
    if(list.length>maxShortCount)ans=ans~"\n    ...\n"~game.localize("description.crt.shift.formoreinfo");
    return ans;
}
function longCellDisplay(item as IItemStack)as string{//shift
    if(!item.hasTag)return game.localize("description.crt.itemcell.empty");
    var ans as string=game.localize("description.crt.itemcell.has");
    var list as string[]=getItemsInCell(item.tag);
    if(list.length<=maxShortCount)return shortCellDisplay(item);
    var counter as int=0;
    for i in list{
        if(counter%3==0)ans=ans~" \n    ";
        else ans=ans~spaces((i.length>13)?6:3*(15-i.length));
        ans=ans~i~"§r";
        counter=counter+1;
    }
    return ans;
}/*
events.onPlayerItemPickup(function(event as crafttweaker.event.PlayerItemPickupEvent){
    L.say(getManaInTablet(event.stackCopy));
    L.say(longCellDisplay(event.stackCopy));
});*/


<appliedenergistics2:storage_cell_1k>.addShiftTooltip(
    function(item){return longCellDisplay(item);},
    function(item){return shortCellDisplay(item);}
);
<appliedenergistics2:storage_cell_4k>.addShiftTooltip(
    function(item){return longCellDisplay(item);},
    function(item){return shortCellDisplay(item);}
);
<appliedenergistics2:storage_cell_16k>.addShiftTooltip(
    function(item){return longCellDisplay(item);},
    function(item){return shortCellDisplay(item);}
);
<appliedenergistics2:storage_cell_64k>.addShiftTooltip(
    function(item){return longCellDisplay(item);},
    function(item){return shortCellDisplay(item);}
);
<botania:manatablet>.addAdvancedTooltip(function(item){return getManaInTablet(item);});
mods.botania.ManaInfusion.addInfusion(<thaumicwands:item_wand>,<thaumicwands:item_wand>,1);
mods.jei.JEI.hideCategory("thermalexpansion.factorizer_combine");
mods.jei.JEI.hideCategory("thermalexpansion.factorizer_split");
<forge:bucketfilled>.withTag({FluidName: "bot_mana", Amount: 1000}).addTooltip(format.aqua(game.localize("description.crt.tooltip.liquid_mana_and_blues_lime")));

//shards tooltips
var shard_block1 as IItemStack[IItemStack]={
    <contenttweaker:shard_terra>:<minecraft:grass>,
    <contenttweaker:shard_aqua>:<minecraft:ice>,
    <contenttweaker:shard_ignis>:<minecraft:nether_brick>,
    <contenttweaker:shard_perditio>:<minecraft:tnt>
};
for shard,block in shard_block1{
    shard.addTooltip(
        game.localize("description.crt.tooltip.shard_anvil1")~
        block.displayName~
        game.localize("description.crt.tooltip.shard_anvil2")~
        shard.displayName~
        game.localize("description.crt.tooltip.shard_anvil3")
    );
}
var shard_block2 as string[IItemStack]={
    <contenttweaker:shard_aer>:"description.crt.tooltip.shard_double_slab_sandstone",
    <contenttweaker:shard_ordo>:"description.crt.tooltip.shard_double_slab_stone"
};
for shard,block in shard_block2{
    shard.addTooltip(
        game.localize("description.crt.tooltip.shard_anvil1")~
        game.localize(block)~
        game.localize("description.crt.tooltip.shard_anvil2")~
        shard.displayName~
        game.localize("description.crt.tooltip.shard_anvil3")
    );
}