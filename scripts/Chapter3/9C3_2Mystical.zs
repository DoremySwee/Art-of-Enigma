import mods.botaniatweaks.Agglomeration as Agg;
import mods.bloodmagic.TartaricForge as TF;
import mods.bloodmagic.BloodAltar as BA;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.embers.Stamper;
import mods.embers.Melter;
import mods.embers.Mixer;
import scripts.Lib;
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
Casting.addTableRecipe(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:villager"}}),
    <minecraft:egg>,<liquid:emerald>,144,true,3000);

Lib.Shaped9x9(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"}),Lib.Mapper({
		"@":<tconstruct:slime:3>,"&":<tconstruct:edible:33>,"$":<extrautils2:suncrystal:0>,
		"*":<botania:manatablet:0> .withTag({mana: 250000}),"_":null,
		"%":<minecraft:potion>.withTag({Potion: "minecraft:strong_healing"}),
		"#":<tconstruct:seared_tank:1> .withTag({FluidName: "lifeessence", Amount: 666}),
		"~":<botania:specialflower:0> .withTag({type: "thermalily"})
	} as IIngredient[string],"
		__@@#@@__;
		_@$%&%$@_;
		@$&***&$@;
		@%*&#&*%@;
		#&*#~#*&#;
		@%*&#&*%@;
		@$&***&$@;
		_@$%&%$@_;
		__@@#@@__;"
));
recipes.addShaped(<immersiveengineering:metal_device1:13>,Lib.Mapper({
    "g":<minecraft:grass>,"G":<botania:managlass>,
    "f":<mysticalagriculture:mystical_fertilizer>,
    "c":<enderio:item_basic_capacitor>,
    "t":<immersiveengineering:treated_wood>,
},"GcG;GfG;tgt;"));
Casting.addTableRecipe(<mysticalagriculture:tier1_inferium_seeds>,
    <minecraft:wheat_seeds>,<liquid:molten_essence>,144,true,200);
var cs1=<mysticalagriculture:crafting:17>;
recipes.addShaped(cs1*8,Lib.Mapper({
    "s":<mysticalagriculture:tier1_inferium_seeds>,"o":Lib.Reuse(orb(1))
},"sss;sos;sss;"));
Lib.Shaped9x9(<minecraft:wool>*64,Lib.Mapper({"@":<immersiveengineering:material:4>} as IIngredient[string],
    "@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;@@@@@@@@@;")); 

//nxOre
var oreIngots as IItemStack[IIngredient]={
    <ore:oreGold>:<minecraft:gold_ingot>,
    <ore:oreIron>:<minecraft:iron_ingot>,
    <ore:oreCopper>:<thermalfoundation:material:128>,
    <ore:oreLead>:<thermalfoundation:material:131>,
    <ore:oreSilver>:<thermalfoundation:material:130>,
    <ore:oreAluminum>|<ore:oreAluminium>:<thermalfoundation:material:132>,
    <ore:oreNickel>:<thermalfoundation:material:133>,
    <ore:oreTin>:<thermalfoundation:material:129>,
    <thermalfoundation:ore:6>:<thermalfoundation:material:134>
};
for ore,ingot in oreIngots{
    recipes.addShapeless(ingot*3,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"}))]);
    recipes.addShapeless(ingot*4,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}))]);
    recipes.addShapeless(ingot*7,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}))]);
    recipes.addShapeless(ingot*16,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"}))]);
    recipes.addShapeless(ingot*64,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"}))]);
}