#priority 10
import crafttweaker.mods.IMod;
import crafttweaker.mods.ILoadedMods;
val ae2=loadedMods["appliedenergistics2"] as IMod;
var c=0 as int;
val m0 = [<minecraft:cobblestone>,<appliedenergistics2:material>,<appliedenergistics2:material:7>] as crafttweaker.item.IIngredient[];
print(ae2.id);
for i in ae2.items{
    if(i.definition.id.indexOf("facade")>-1){
        continue;}
    if(i.definition.id.indexOf("material")>-1){
        continue;}        
    if(i.definition.id.indexOf("seed")>-1){
        continue;}
    if(i.definition.id.indexOf("_quartz_")>-1){
        continue;}
    if(i.definition.id.indexOf("paint_ball")>-1){
        continue;}
    if(i.definition.id.indexOf("pattern")>-1){
        continue;}
    if(i.definition.id.indexOf("crank")>-1){
        continue;}
    if(i.definition.id.indexOf("grindstone")>-1){
        continue;}
    if(i.ores.length<1){
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
        recipes.addShaped(i,m);
    }
}
recipes.remove(<appliedenergistics2:creative_energy_cell>);
recipes.remove(<appliedenergistics2:matrix_frame>);
recipes.addShaped(<appliedenergistics2:material:28>,[
    [m0[2],<minecraft:redstone>,null],
    [m0[1],m0[0],null],
    [null,null,null]]);
recipes.addShaped(<appliedenergistics2:material:25>,[
    [m0[0],<minecraft:redstone>,null],
    [m0[1],m0[2],null],
    [null,null,null]]);
recipes.addShaped(<appliedenergistics2:material:52>,[
    [m0[1],<minecraft:redstone>,null],
    [m0[0],m0[2],null],
    [null,null,null]]);
recipes.addShaped(<appliedenergistics2:material:42>,[
    [m0[1],<minecraft:redstone>,null],
    [m0[2],m0[0],null],
    [null,null,null]]);

var fluixC=<appliedenergistics2:material:7>;
mods.botania.ManaInfusion.addInfusion(fluixC*8,fluixC,1);
recipes.remove(<appliedenergistics2:part:321>);