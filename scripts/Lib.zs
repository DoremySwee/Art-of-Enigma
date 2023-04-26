#priority 1919810
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
static AvaRecipeCount as int[]=[0];
function Shaped9x9(output as IItemStack,inputs as IIngredient[][]){
    mods.avaritia.ExtremeCrafting.addShaped("Art_of_Enigma_AvaRecipe_"~AvaRecipeCount[0],output,inputs);
    AvaRecipeCount[0]=AvaRecipeCount[0]+1;
}
function Mapper(map as IIngredient[string],inputs as string)as IIngredient[][]{
    var t=[] as IIngredient[];
    var r=[] as IIngredient[][];
    for i in 0 to inputs.length{
        if(inputs[i]==" "||inputs[i]=="\n"||inputs[i]=="\t")continue;
        if(inputs[i]==";"){
            r=r+t;
            t=[] as IIngredient[];
        }
        else{
            if(isNull(map[inputs[i]]))t=t+(null as IIngredient);
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