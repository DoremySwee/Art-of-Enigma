#reloadable
import scripts.recipes.libs.Mapping as Mp;
import scripts.advanced.libs.Data as D;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
function coin(x)as IItemStack{
    return itemUtils.getItem("contenttweaker:coin"~x); 
}
for i in 1 to 9{
    coin(i).addTooltip(game.localize("description.crt.tooltip.coin"));
}
// Tooltips should also illustrate the cooldown