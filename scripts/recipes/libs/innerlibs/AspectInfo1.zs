#reloadable
#priority 100000021
import thaumcraft.aspect.CTAspectStack;
import scripts.advanced.libs.Data as D;
import thaumcraft.aspect.CTAspect;
import crafttweaker.data.IData;

import scripts.recipes.libs.innerlibs.AspectInfo0 as Info;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

static nameAspectMap as CTAspect[string] = {} as CTAspect[string];
for a in Info.listAspects{
    nameAspectMap[a.name]=a;
}
