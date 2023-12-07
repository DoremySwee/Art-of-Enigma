#priority -1
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

T.tc.shaped(<mysticalagriculture:soulstone>,Mp.read("ABA;BCB;ABA;",{
    "A":<mysticalagriculture:crafting:8>,"B":<minecraft:soul_sand>,"C":<minecraft:sandstone>
}),10);
furnace.remove(<mysticalagriculture:crafting:28>);

var t1 = <mysticalagriculture:crafting:45>; //nugget
var t2 = <mysticalagriculture:crafting:38>; //ingot
recipes.addShapeless(t1*9,[t2]);
recipes.addShapeless(t2,[t1,t1,t1,t1,t1,t1,t1,t1,t1]);
furnace.remove(t2);
furnace.addRecipe(t1*2,<mysticalagriculture:crafting:29>);
T.te.grind(<minecraft:soul_sand>,<mysticalagriculture:crafting:28>%10,<mysticalagriculture:soulstone>,2000);

static t3 as IItemStack[string] = {
    "A":<botania:manaresource:7>,"B":<botania:manaresource:13>,"C":<botania:manaresource:8>
} as IItemStack[string];
function t4 (o as IItemStack, pattern as string){
    recipes.remove(o);
    T.tc.shaped(o,Mp.read(pattern,t3),10);
}
var t5 as string[IItemStack]= {
    <botania:elementiumhelm>:"AAA;A_A;",
    <botania:elementiumchest>:"A_A;AAA;AAA;",
    <botania:elementiumlegs>:"AAA;A_A;A_A;",
    <botania:elementiumboots>:"A_A;A_A;",
    <botania:openbucket>:"A_A;_A_;",
    <botania:pixiering>:"CA_;A_A;_A_;",
    <botania:elementiumshears>:"A_;_A;",
    <botania:elementiumsword>:"A;A;B;",
    <botania:elementiumaxe>:"AA;AB;_B;",
    <botania:elementiumshovel>:"A;B;B;",
    <botania:elementiumpick>:"AAA;_B_;_B_;"
}as string[IItemStack];
for i,p in t5{
    t4(i,p);
}