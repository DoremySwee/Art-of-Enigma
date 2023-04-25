#priority 1919810
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
static AvaRecipeCount as int[]=[0];
function Shaped9x9(output as IItemStack,inputs as IIngredient[][]){
    mods.avaritia.ExtremeCrafting.addShaped("Art_of_Enigma_AvaRecipe_"~AvaRecipeCount[0],output,inputs);
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