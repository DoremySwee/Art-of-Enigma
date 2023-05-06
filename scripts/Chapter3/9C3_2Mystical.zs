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
    recipes.addShapeless(ingot*3,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"})),<mysticalagriculture:stone_essence>*4]);
    //recipes.addShapeless(ingot*4,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}))]);
    //recipes.addShapeless(ingot*7,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}))]);
    //recipes.addShapeless(ingot*16,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"}))]);
    //recipes.addShapeless(ingot*64,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"}))]);
}
Lib.Shaped9x9(<mysticalagriculture:stone_seeds>*4,Lib.Mapper({
		"$":<chisel:cobblestone:6>,"@":<chisel:stonebrick:0>,"!":<chisel:cobblestone:8>,
		"&":<chisel:stonebrick:2>,"3":<chisel:cobblestone1:8>,"`":<chisel:cobblestone2:7>,
		"~":<chisel:cobblestone:4>,"f":<chisel:cobblestone2:9>,"d":<chisel:cobblestone1:4>,
		"i":<chisel:cobblestone2:3>,"9":<chisel:cobblestone1:6>,"a":<chisel:cobblestone2:5>,
		"n":<chisel:cobblestone1:0>,"k":<chisel:cobblestone2:1>,"r":<chisel:cobblestone1:2>,
		"*":<botania:specialflower:0> .withTag({type: "orechid"}),"o":<chisel:cobblestone:15>,
		"g":<chisel:cobblestone:10>,"s":<chisel:cobblestone:12>,"p":<chisel:cobblestone:14>,
		"1":<chisel:cobblestone:5>,"8":<chisel:cobblestone:7>,"5":<chisel:cobblestone1:9>,
	    "b":<chisel:cobblestone2:8>,"%":<chisel:stonebrick:1>,"*":<chisel:cobblestone:3>,
		"0":<chisel:cobblestone2:4>,"^":<chisel:cobblestone1:5>,"2":<chisel:cobblestone1:7>,
		"e":<chisel:cobblestone2:6>,"7":<chisel:cobblestone2:0>,"c":<chisel:cobblestone:9>,
		"m":<chisel:cobblestone1:1>,"h":<chisel:cobblestone1:3>,"j":<chisel:cobblestone2:2>,
		"4":<mysticalagriculture:crafting:17>,"6":<botania:grassseeds:0>,"_":null,
		"l":<chisel:cobblestone:11>,"#":<mysticalagriculture:crafting:0>,"q":<chisel:cobblestone:13>
	} as crafttweaker.item.IIngredient[string],"
		@##___##$;
		##%&*~1##;
		#2345678#;
		_960_`4!_;
		_^*a_b*c_;
		_d4e_f6g_;
		#hi6j4kl#;
		##mnopq##;
		r##___##s;"
));
Lib.Shaped9x9(<mysticalagriculture:nature_seeds>*4,Lib.Mapper({
		"%":<forge:bucketfilled:0> .withTag({FluidName: "plantoil", Amount: 1000}),
		"@":<forge:bucketfilled:0> .withTag({FluidName: "mushroom_stew", Amount: 1000}),
		"7":<forge:bucketfilled:0> .withTag({FluidName: "seed_oil", Amount: 1000}),
		"4":<forge:bucketfilled:0> .withTag({FluidName: "ethanol", Amount: 1000}),
		"3":<botania:specialflower:0> .withTag({type: "spectrolus"}),"$":<minecraft:leaves:0>,"_":null,
		"8":<forge:bucketfilled:0> .withTag({FluidName: "creosote", Amount: 1000}),
		"9":<forge:bucketfilled:0> .withTag({FluidName: "resin", Amount: 1000}),
		"6":<forge:bucketfilled:0> .withTag({FluidName: "sap", Amount: 1000}),
		"5":<forge:bucketfilled:0> .withTag({FluidName: "tree_oil", Amount: 1000}),
		"0":<forge:bucketfilled:0> .withTag({FluidName: "syrup", Amount: 1000}),
		"1":<forge:bucketfilled:0> .withTag({FluidName: "biodiesel", Amount: 1000}),
		"2":<forge:bucketfilled:0> .withTag({FluidName: "refined_biofuel", Amount: 1000}),
		"&":<forge:bucketfilled:0> .withTag({FluidName: "biocrude", Amount: 1000}),
		"*":<mysticalagriculture:crafting:6>,"~":<mysticalagriculture:crafting:17>,
		"#":<botania:specialflower:0> .withTag({type: "puredaisy"})
	} as crafttweaker.item.IIngredient[string],"
		_________;
		__@#$#%__;
		_&$*~*$1_;
		_#*234*#_;
		_$~3_3~$_;
		_#*536*#_;
		_7$*~*$8_;
		__9#$#0__;
		_________;"
));
recipes.addShaped(<mysticalagriculture:dirt_seeds>*4,Lib.Mapper({
		"#":<mysticalagriculture:crafting:17>,"$":<minecraft:grass:0>,
		"@":<minecraft:mycelium:0>,"*":<minecraft:dirt:2>,
		"&":<tconstruct:soil:3>,"%":<chisel:dirt:15>,"_":null
	} as IIngredient[string],"@#$;#%#;&#*;"
));
Lib.Shaped9x9(<mysticalagriculture:wood_seeds>*4,Lib.Mapper({
		"&":<mysticalagriculture:crafting:17>,"1":<extrautils2:decorativesolidwood:1>,
		"_":null,"#":<chisel:bookshelf_oak:0>,"*":<botania:dreamwood:4>,"%":<botania:dreamwood:0>,
		"~":<forge:bucketfilled:0> .withTag({FluidName: "resin", Amount: 1000}),
		"$":<forge:bucketfilled:0> .withTag({FluidName: "sap", Amount: 1000}),
		"@":<forge:bucketfilled:0> .withTag({FluidName: "tree_oil", Amount: 1000})
	} as crafttweaker.item.IIngredient[string],"
		_________;
		_________;
		__@#$%#__;
		__%&*&~__;
		__#*1*#__;
		__~&*&%__;
		__#%$#@__;
		_________;
		_________;"
));
Lib.Shaped9x9(<mysticalagriculture:water_seeds>*4,Lib.Mapper({
		"1":<botania:specialflower:0> .withTag({type: "hydroangeas"}),"A":<chisel:waterstone1:14>,
		"3":<minecraft:potion:0> .withTag({Potion: "minecraft:water"}),
		"a":<botania:waterbowl:0> .withTag({Fluid: {FluidName: "water", Amount: 1000}}),
		"%":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 3 as short, id: 5 as short}]}),
		"6":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 1 as short, id: 6 as short}]}),
		"!":<chisel:waterstone1:1>,"s":<chisel:waterstone2:0>,"4":<chisel:waterstone1:3>,"l":<chisel:waterstone:15>,
		"7":<chisel:waterstone:2>,"h":<chisel:waterstone1:5>,"c":<chisel:waterstone:0>,"f":<chisel:waterstone:11>,
		"n":<chisel:waterstone1:7>,"*":<chisel:waterstone1:14>,"@":<chisel:waterstone:13>,"d":<chisel:waterstone1:9>,
		"i":<chisel:waterstone1:12>,"#":<minecraft:water_bucket:0>,"j":<chisel:waterstone:6>,"$":<chisel:waterstone:4>,
		"q":<chisel:waterstone:8>,"p":<chisel:waterstone1:0>,"`":<chisel:waterstone:1>,"~":<chisel:waterstone:14>,
		"8":<chisel:waterstone1:2>,"&":<chisel:waterstone1:4>,"5":<chisel:waterstone1:13>,"b":<chisel:waterstone:10>,
		"k":<chisel:waterstone1:6>,"e":<chisel:waterstone1:11>,"*":<chisel:waterstone:12>,"r":<chisel:waterstone1:8>,
		"o":<chisel:waterstone1:15>,"0":<mysticalagriculture:crafting:17>,"_":null,"^":<chisel:waterstone1:10>,
		"g":<chisel:waterstone:5>,"2":<chisel:waterstone:3>,"9":<chisel:waterstone:9>,"m":<chisel:waterstone:7>
	} as crafttweaker.item.IIngredient[string],"
		@#_$%&_#A;
		~1_234_15;
		36#718#63;
		#90`#!0^#;
		*ab1c1dae;
		#f0g#h0i#;
		36#j1k#63;
		l1_m3n_1o;
		p#_q%r_#s;"
));