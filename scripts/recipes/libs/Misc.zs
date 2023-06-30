#loader crafttweaker reloadableevents
#priority 100000000
import crafttweaker.entity.IEntityDefinition;
import scripts.recipes.libs.Transcript as T;
import crafttweaker.item.IItemDefinition;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
function dup(item as IItemStack, recipe as bool = true){
    item.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dup0"))));
    if(recipe){
        if(item.maxStackSize>7)
            recipes.addShapeless(item*8, [item]);
        else
            recipes.addShapeless(item, [item.reuse()]);
    }
}
function dupMana(item as IItemStack, mana as int = 100, recipe as bool = true){
    item.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupMana"))));
    if(recipe && mana>0 )
        T.bot.infusion(item*4, item, mana);
}
function dupSpark(item as IItemStack, recipe as bool = true){
    item.addTooltip(format.aqua(format.italic(game.localize("description.crt.tooltip.dupSpark"))));
    if(recipe)
        recipes.addShapeless(item*8, [item, <botania:spark>]);
}
function flower(name as string)as IItemStack{
    return <botania:specialflower>.withTag({"type":name});
}
function bucket(liquidId as string)as IItemStack{
    return <forge:bucketfilled>.withTag({"FluidName": liquidId, "Amount": 1000});
}
function inscribeEgg(entity as IEntityDefinition, materials as IItemStack[], consume as bool = true){
    var inputs as IItemStack[]= [<minecraft:egg>] as IItemStack[];
    if(materials.length==1){
        inputs += materials[0];
        inputs += materials[0];
    } 
    else{
        for item in materials{
            inputs+=item;
        }
    }
    T.ae2.inscribe(itemUtils.createSpawnEgg(entity),inputs,consume);
}
function temporaryLore(ins as IIngredient, lore as string)as IIngredient{
    var result as IIngredient=null;
    for i in ins.items{
        var tag as IData={display:{Lore:[lore]}}as IData;
        if(i.hasTag){
            tag=i.tag.deepUpdate(tag);
        }
        if(isNull(result))result=i.withTag(tag,false);
        else result=result|i.withTag(tag,false);
    }
    result=result.only(function(item){
        return ins.matches(item);
    });
    return result;
}
function reuse(ins as IIngredient)as IIngredient{
    return TemporaryLore(ins,"§a§o"~game.localize("description.crt.reuse")~"§r").reuse();
}
function consume(ins as IIngredient)as IIngredient{
    return TemporaryLore(ins,"§a§o"~game.localize("description.crt.consume")~"§r");
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