#loader crafttweaker reloadableevents
#priority 10000
import scripts.advanced.libs.Data as D;
import scripts.recipes.libs.Aspects as A;
import scripts.advanced.wands.WandRegistering as WR;

import mods.thaumicwands.WandCaps;
import mods.thaumicwands.WandRods;

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import thaumcraft.aspect.CTAspectStack;

import mods.jei.JEI;
import mods.ctutils.utils.Math;
import mods.thaumcraft.ArcaneWorkbench as AWB;

import scripts.recipes.libs.Transcript as T;

//Clearing the original caps
if(true){
    recipes.remove(<thaumicwands:item_wand>);
    var cap = <thaumicwands:item_wand_cap>;
    var capd = cap.definition;
    var rod = <thaumicwands:item_wand_rod>;
    var rodd = rod.definition;
    JEI.removeAndHide(cap);
    WandRods.remove(rod);
    for i in [1,2,3,5,7]as int[]{
        AWB.removeRecipe(capd.makeStack(i));
        JEI.removeAndHide(capd.makeStack(i));
    }
    for i in [0,1,2,4,6,8]as int[]{
        WandCaps.remove(capd.makeStack(i));
        JEI.removeAndHide(capd.makeStack(i));
    }
    for i in 0 to 8{
        WandRods.remove(rodd.makeStack(i));
        AWB.removeRecipe(rodd.makeStack(i));
        JEI.removeAndHide(rodd.makeStack(i));
    }
}

//Registering rod/cap
if(true){
    val FS as string="FIRSTSTEPS";
    for rodName,rod in WR.rodsData.asMap(){
        WandRods.register(rodName,FS,
            rod.capacity.asInt(),
            <minecraft:stick>.withTag({"registeringTag":rodName}),  //We give up the auto-generated recipe. And they are hidden.
        0);
    }
    for capName,cap in WR.capsData.asMap(){
        WandCaps.register(capName,FS,
            cap.multiplier.asDouble(),
            A.fromData(cap.discounts),
            <thaumicwands:item_wand_cap>.withTag({"registeringTag":capName})   //This item cannot be accessed
        ,0);

    }
}

//Adding recipes
if(true){
    val FS as string="FIRSTSTEPS";
    var i=0;
    for rodName,rod in WR.rodsData.asMap(){
        for capName,cap in WR.capsData.asMap(){
            i+=1;
            var vis1 = rod.craftCost.asInt();
            var vis2 = cap.craftCost.asInt();
            var vis = vis1+vis2;

            var aspects1 as int[] = A.dataToArray(rod.memberGet("craftAspects"));
            var aspects2 as int[] = A.dataToArray(cap.memberGet("craftAspects"));
            var aspects as int[]=[0,0,0,0,0,0];
            for i in 0 to 6{
                aspects[i]=((Math.tanh(aspects1[i]*aspects2[i])*64.5)as int);
            }

            var r = itemUtils.getItem(rod.itemId.asString());
            var c = itemUtils.getItem(cap.itemId.asString());
            var w = <thaumicwands:item_wand>.withTag({"cap": capName, "rod": rodName});
            var ingredients as IIngredient[][]=[
                [null,null,c],
                [null,r,null],
                [c,null,null]
            ];
            if(vis<1){
                recipes.addShaped(w,ingredients);
            }
            else{/*
                AWB.registerShapedRecipe(
                    "Art_of_Enigma_WandCraft"~i,
                    FS,vis,A.aspects6(aspects),w,ingredients
                );*/
                T.tc.shaped(w,ingredients,vis,aspects);
            }
        }
    }
}