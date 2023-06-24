#loader crafttweaker reloadableevents
#priority 10000

import crafttweaker.item.IItemStack;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import mods.ctutils.utils.Math;

import scripts.advanced.libs.Data as D;
import scripts.advanced.wands.WandRegistering as WR;

events.onPoolTrade(function(event as mods.randomtweaker.botania.PoolTradeEvent){
    var wand=event.input.item;
    if(wand.definition.id!=<thaumicwands:item_wand>.definition.id)return;
    event.cancel();
    if(!wand.hasTag)return;
    var capName as string=wand.tag.cap.asString();
    var rodName as string=wand.tag.rod.asString();
    if(WR.capsData has capName && WR.rodsData has rodName){
        var cap = WR.capsData.memberGet(capName);
        var rod = WR.rodsData.memberGet(rodName);
        if(cap has "botCapData"){
            var manaRate as int= cap.deepGet("botCapData.manaRate").asInt();
            var visRate as double= cap.deepGet("botCapData.visRate").asDouble();
            var capacity as int= rod.memberGet("capacity").asInt();
            if(rod has "botRodData"){
                capacity = rod.deepGet("botRodData.capacity").asInt();
            }

            var vis as double= WR.getVis(wand.tag);
            var wantedVis as double= Math.min(-vis+capacity,visRate);
            var requiredMana as int= Math.floor(0.5+wantedVis * manaRate / visRate) as int;
            var manaMax as int= event.currentMana as int;
            if (manaMax<requiredMana){
                wantedVis = visRate * manaMax / manaRate;
                requiredMana = manaMax;
            }

            var manaLeft = manaMax - requiredMana;
            var w = event.world;
            var p = event.blockPos;
            w.setBlockState(w.getBlockState(p),w.getBlock(p).data+{"mana":manaLeft},p);
            event.input.item.mutable().withTag(WR.addVis(wantedVis,wand.tag));
        }
    }
});