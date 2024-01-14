#reloadable
#priority 10000
import scripts.advanced.wands.WandRegistering as WR;
import scripts.recipes.libs.Aspects as A;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;

<thaumicwands:item_wand>.clearTooltip(true);

//Show the vis inside
<thaumicwands:item_wand>.addAdvancedTooltip(function(item as IItemStack){
    if(!item.hasTag)return "";
    if(!(item.tag has "rod"))return "";
    var vis as double=(0.0+(0+WR.getVis(item.tag)*100))/100;
    var rodName as string=item.tag.rod.asString();
    if(!(WR.rodsData has rodName))return "";
    var rodData = WR.rodsData.deepGet(rodName);
    var cap as int=rodData.deepGet("capacity").asInt();
    var p as string="";
    if(0+vis>cap)p="§r§o§d";
    else if(vis>0.75*cap)p="§r§o§9";
    else if(vis>0.50*cap)p="§r§o§b";
    else if(vis>0.30*cap)p="§r§o§a";
    else if(vis>0.15*cap)p="§r§o§e";
    else if(vis>0.99)p="§r§o§c";
    else p="§r§o§4";
    if(rodData has "botRodData"){
        return p~vis~"/"~cap~".00§r  §o§d("~rodData.deepGet("botRodData.capacity").asInt()~".00)§r";
    }
    return p~vis~"/"~cap~".00";
});

//Show discounts
<thaumicwands:item_wand>.addAdvancedTooltip(function(item as IItemStack){
    if(!item.hasTag)return "";
    if(!(item.tag has "cap"))return "";
    var capName as string=item.tag.cap as string;
    if(!(WR.capsData has capName))return "";
    var capData = WR.capsData.memberGet(capName);
    var multiplier = capData.memberGet("multiplier").asDouble();
    var discounts as int[]= A.dataToArray(capData.memberGet("discounts"));
    return "§r§d§k**§r§d * "~(100*multiplier)~"%"~"       "~
        "§r§o§e-"~discounts[0]~"  "~
        "§r§o§2-"~discounts[1]~"  "~
        "§r§o§c-"~discounts[2]~"  "~
        "§r§o§b-"~discounts[3]~"  "~
        "§r§o§f-"~discounts[4]~"  "~
        "§r§o§7-"~discounts[5];
});

for t,data in WR.rodsData.asMap(){
    var item as IItemStack = itemUtils.getItem(data.itemId.asString());
    if(data has "botRodData"){
        item.addTooltip(game.localize("description.crt.tooltip.tcwands.botrod"));
    }
}
for t,data in WR.capsData.asMap(){
    var item as IItemStack = itemUtils.getItem(data.itemId.asString());
    if(data has "botCapData"){
        item.addTooltip(game.localize("description.crt.tooltip.tcwands.botcap"));
    }
}