#priority 1919810
import thaumcraft.aspect.CTAspectStack;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
static AvaRecipeCount as int[]=[0];
function Shaped9x9(output as IItemStack,inputs as IIngredient[][]){
    mods.avaritia.ExtremeCrafting.addShaped("Art_of_Enigma_AvaRecipe_"~AvaRecipeCount[0],output,inputs);
    AvaRecipeCount[0]=AvaRecipeCount[0]+1;
}
function Mapper(map as IIngredient[string],inputs as string)as IIngredient[][]{
    var t=[] as IIngredient[];
    var r=[] as IIngredient[][];
    for i in 0 to inputs.length{
        if(inputs[i]==" "||inputs[i]=="\n"||inputs[i]=="\t"||inputs[i]=="
")continue;
        if(inputs[i]==";"){
            r=r+t;
            t=[] as IIngredient[];
        }
        else{
            if(isNull(map[inputs[i]])){
                if(inputs[i]=="_")t=t+(null as IIngredient);
                else{
                    //t=t+(null as IIngredient);
                    /*
                    print("INVALID INPUTS!!!");
                    print("\""~inputs[i]~"\"");*/
                }
            }
            else t=t+map[inputs[i]];
        }
    }
    return r;
}
function Merge(m1 as IIngredient[string], m2 as IIngredient[string])as IIngredient[string]{
    var m as IIngredient[string]={};
    for k in m1.keys{
        m[k]=m1[k];
    }
    for k in m2.keys{
        m[k]=m2[k];
    }
    return m;
}
function MergeData(dat1 as IData,dat2 as IData)as IData{
    if(isNull(dat1))return dat2;
    if(isNull(dat2))return dat1;
    if(!isNull(dat1.asList())){
        return dat1+dat2;
    }
    else if(!isNull(dat1.asMap())){
        var dat as IData=IData.createEmptyMutableDataMap();
        for key,value in dat1.asMap(){
            dat.memberSet(key,dat1.memberGet(key));
        }
        for key,value in dat2.asMap(){
            if(dat has key)dat.memberSet(key,MergeData(dat.memberGet(key),dat2.memberGet(key)));
            else dat.memberSet(key,dat2.memberGet(key));
        }
        return dat;
    }
    else{
        return dat2;
    }
}
function TemporaryLore(ins as IIngredient, lore as string)as IIngredient{
    var result as IIngredient=null;
    for iii in 0 to 10{
        for i in ins.items{
            var tag as IData={display:{Lore:[lore]}}as IData;
            if(i.hasTag){
                tag=MergeData(i.tag,tag);
            }
            if(isNull(result))result=i.withTag(tag);
            else result=result|(i.withTag(tag));
        }
    }
    for i in ins.items{
        result=result|i;
    }/*/
    var result as IIngredient=null;
    for i in ins.items{
        var tag as IData={display:{Lore:[lore]}}as IData;
        if(i.hasTag){
            tag=MergeData(i.tag,tag);
        }
        if(isNull(result))result=i.withTag(tag,false);
        else result=result|(i.withTag(tag,false));
    }/**/
    return result;
}/**/
function Reuse(ins as IIngredient)as IIngredient{
    return TemporaryLore(ins,"§a§o"~game.localize("description.crt.reuse")~"§r").reuse();
}
function Consume(ins as IIngredient)as IIngredient{
    return TemporaryLore(ins,"§a§o"~game.localize("description.crt.consume")~"§r");
}
function aspect6(aer as int, terra as int, ignis as int, aqua as int, ordo as int, perditio as int)as CTAspectStack[]{
    var stacks as CTAspectStack[]=[];
    if(aer>0)stacks+=<aspect:aer>*aer;
    if(terra>0)stacks+=<aspect:terra>*terra;
    if(ignis>0)stacks+=<aspect:ignis>*ignis;
    if(aqua>0)stacks+=<aspect:aqua>*aqua;
    if(ordo>0)stacks+=<aspect:ordo>*ordo;
    if(perditio>0)stacks+=<aspect:perditio>*perditio;
    return stacks;
}
function aspect6array(b as int[])as CTAspectStack[]{
    var a as int[]=[];
    for i in b{a+=i;}
    while(a.length<6){a+=0;}
    return aspect6(a[0],a[1],a[2],a[3],a[4],a[5]);
}
static numberOfWABRecipes as int[]=[0];
static FS as string="FIRSTSTEPS";
function Arcane(output as IItemStack,inputs as IIngredient[][],vis as int, aspects as CTAspectStack[]=[], research as string="FIRSTSTEPS"){
    numberOfWABRecipes[0]=numberOfWABRecipes[0]+1;
    mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe("Art_of_Enigma_Arcane_Workbench_recipe_no_"~numberOfWABRecipes[0],
        research,vis,aspects,output,inputs);
}
function orb(level as int)as IIngredient{
    var orbs as IIngredient[]=[
        <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"}),
        <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}),
        <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}),
        <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"}),
        <bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"})
    ];
    var result as IIngredient=orbs[level- 1];
    for i in (level- 1) to 5{
        result=result|orbs[i];
    }
    return result;
}
static numberOfCrucibleRecipes as int[]=[0];
function Crucible(output as IItemStack, input as IIngredient, aspects as CTAspectStack[], research as string="FIRSTSTEPS", nameIn as string=null){
    var name as string=nameIn;
    if(isNull(name)){
        var n as int=numberOfCrucibleRecipes[0];
        numberOfCrucibleRecipes[0]=n+1;
        name="Art_of_Enigma_Crucible_recipe_no_"~n;
    }
    mods.thaumcraft.Crucible.registerRecipe(name, research, output, input, aspects);
}