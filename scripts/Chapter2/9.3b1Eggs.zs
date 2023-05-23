import mods.appliedenergistics2.Inscriber;
import crafttweaker.item.IIngredient;
val egg=<minecraft:egg>;
function InEgg(a as string, b as IIngredient, c as IIngredient = null, d as bool = false) as void{
    Inscriber.addRecipe(<minecraft:spawn_egg>.withTag({EntityTag: {id: a}}),
        <minecraft:egg>,d,b,c);
}
InEgg("minecraft:chicken",egg,egg);
InEgg("minecraft:sheep",<minecraft:wool>,<minecraft:wool>);
InEgg("minecraft:skeleton",<minecraft:bone>,<minecraft:bone>);
InEgg("minecraft:creeper",<minecraft:gunpowder>,<enderio:item_material:20>);
//InEgg("minecraft:villager",<minecraft:emerald>,<minecraft:emerald>);
InEgg("minecraft:zombie",<minecraft:rotten_flesh>,<minecraft:rotten_flesh>);