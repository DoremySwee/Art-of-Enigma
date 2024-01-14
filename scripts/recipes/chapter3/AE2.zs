#reloadable
#priority 1000
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.mods.ILoadedMods;
import crafttweaker.mods.IMod;

val AE2=loadedMods["appliedenergistics2"] as IMod;
val m0 = [/*<botania:livingrock>|*/<enderio:item_alloy_ingot:9>,<appliedenergistics2:material>,<appliedenergistics2:material:7>] as IIngredient[];
var c=0 as int;
val blackList = ["facade","material","seed","_quartz_","paint_ball","pattern","crank","grindstone","inscriber","spatial"] as string[];
/*
var str as string = "\n";
for i in AE2.items{
    var flag = false;
    for j in blackList{
        if(i.definition.id.contains(j)){
            flag = true;
            break;
        }
    }
    if(flag)continue;
    if(i.ores.length<1){
        str=str~i.commandString~",\n";
    }
}
print(str);
*/
for i in scripts.recipes.chapter3.AE2ItemList.AE2Items{
    c+=1;
    recipes.remove(i);
    furnace.remove(i);
    var t=c as int;
    var m = [[null,null,null],[null,null,null],[null,null,null]] as crafttweaker.item.IIngredient[][];
    for j in 0 to 9{
        m[j/3 as int][j%3]=m0[t%3];
        t=t/3 as int;
    }
    m[2][2]=m0[2];
    var n = i.maxStackSize;
    n=(n>16)?16:n;
    recipes.addShaped(i*n,m);
}
recipes.remove(<appliedenergistics2:creative_energy_cell>);
recipes.remove(<appliedenergistics2:matrix_frame>);
recipes.addShaped(<appliedenergistics2:material:28>*16,[
    [m0[2],<minecraft:redstone>,null],
    [m0[1],m0[0],null],
    [null,null,null]]);
recipes.addShaped(<appliedenergistics2:material:25>*16,[
    [m0[0],<minecraft:redstone>,null],
    [m0[1],m0[2],null],
    [null,null,null]]);
recipes.addShaped(<appliedenergistics2:material:52>*16,[
    [m0[1],<minecraft:redstone>,null],
    [m0[0],m0[2],null],
    [null,null,null]]);
recipes.addShaped(<appliedenergistics2:material:42>*16,[
    [m0[1],<minecraft:redstone>,null],
    [m0[2],m0[0],null],
    [null,null,null]]);
recipes.remove(<appliedenergistics2:part:321>);