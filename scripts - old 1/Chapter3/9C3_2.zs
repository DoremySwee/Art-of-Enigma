import mods.botaniatweaks.Agglomeration as Agg;
import mods.bloodmagic.TartaricForge as TF;
import mods.bloodmagic.BloodAltar as BA;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.extrautils2.Resonator;
import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.botania.RuneAltar;
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
		"#":<tconstruct:seared_tank:1> .withTag({FluidName: "lifeessence", Amount: 3000}),
		"~":<botania:specialflower:0> .withTag({type: "thermalily"})
	},"
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
    recipes.addShapeless(ingot*6,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"})),<mysticalagriculture:stone_essence>,<mysticalagriculture:stone_essence>,<mysticalagriculture:stone_essence>,<mysticalagriculture:stone_essence>]);
    //recipes.addShapeless(ingot*4,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}))]);
    //recipes.addShapeless(ingot*7,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}))]);
    //recipes.addShapeless(ingot*16,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"}))]);
    //recipes.addShapeless(ingot*64,[ore,Lib.Reuse(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"}))]);
}
recipes.remove(<extrautils2:suncrystal:250>);
Lib.Shaped9x9(<extrautils2:suncrystal:250>,Lib.Mapper({
		"_":null,"$":<botania:manaresource:2>,"#":<botania:pylon:0>,"@":<thermalfoundation:storage_alloy:1>,
		"*":<thermalfoundation:glass:8>,"&":<thermalfoundation:glass_alloy:2>,"%":<thermalfoundation:glass_alloy:1>
	},"
		____@____;
		__#_$_#__;
		_#@%&%@#_;
		__%#*#%__;
		@$&*$*&$@;
		__%#*#%__;
		_#@%&%@#_;
		__#_$_#__;
		____@____;"
));
BA.addRecipe(<bloodmagic:slate>,<botania:manatablet>.withTag({mana: 375000}),0,576,1,0);
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
		"4":<mysticalagriculture:crafting:17>,"6":<botania:grassseeds:0>,"_":null,"A":<bloodmagic:slate>,
		"l":<chisel:cobblestone:11>,"#":<mysticalagriculture:crafting:0>,"q":<chisel:cobblestone:13>
	},"
		@##___##$;
		##%&*~1##;
		#2345678#;
		_960A`4!_;
		_^*aAb*c_;
		_d4eAf6g_;
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
	},"
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
		"*":<minecraft:dirt:2>,"%":<chisel:dirt:15>,"_":null
	} as IIngredient[string],"*#$;#%#;$#*;"
));
Lib.Shaped9x9(<mysticalagriculture:wood_seeds>*4,Lib.Mapper({
		"&":<mysticalagriculture:crafting:17>,"1":<extrautils2:decorativesolidwood:1>,
		"_":null,"#":<chisel:bookshelf_oak:0>,"*":<botania:dreamwood:4>,"%":<botania:dreamwood:5>,
		"~":<forge:bucketfilled:0> .withTag({FluidName: "resin", Amount: 1000}),
		"$":<forge:bucketfilled:0> .withTag({FluidName: "sap", Amount: 1000}),
		"@":<forge:bucketfilled:0> .withTag({FluidName: "tree_oil", Amount: 1000})
	},"
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
		"1":<botania:specialflower:0> .withTag({type: "hydroangeas"}),
		"3":<minecraft:potion:0> .withTag({Potion: "minecraft:water"}),
		"a":<botania:waterbowl:0> .withTag({Fluid: {FluidName: "water", Amount: 1000}}),
		"%":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 3 as short, id: 5 as short}]}),
		"6":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 1 as short, id: 6 as short}]}),
		"!":<chisel:waterstone1:1>,"s":<chisel:waterstone2:0>,"4":<chisel:waterstone1:3>,"l":<chisel:waterstone:15>,
		"7":<chisel:waterstone:2>,"h":<chisel:waterstone1:5>,"c":<chisel:waterstone:0>,"f":<chisel:waterstone:11>,
		"n":<chisel:waterstone1:7>,"A":<chisel:waterstone1:14>,"@":<chisel:waterstone:13>,"d":<chisel:waterstone1:9>,
		"i":<chisel:waterstone1:12>,"#":<minecraft:water_bucket:0>,"j":<chisel:waterstone:6>,"$":<chisel:waterstone:4>,
		"q":<chisel:waterstone:8>,"p":<chisel:waterstone1:0>,"`":<chisel:waterstone:1>,"~":<chisel:waterstone:14>,
		"8":<chisel:waterstone1:2>,"&":<chisel:waterstone1:4>,"5":<chisel:waterstone1:13>,"b":<chisel:waterstone:10>,
		"k":<chisel:waterstone1:6>,"e":<chisel:waterstone1:11>,"*":<chisel:waterstone:12>,"r":<chisel:waterstone1:8>,
		"o":<chisel:waterstone1:15>,"0":<mysticalagriculture:crafting:17>,"_":null,"^":<chisel:waterstone1:10>,
		"g":<chisel:waterstone:5>,"2":<chisel:waterstone:3>,"9":<chisel:waterstone:9>,"m":<chisel:waterstone:7>
	},"
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
Lib.Shaped9x9(<mysticalagriculture:ice_seeds>,Lib.Mapper({
		"x":<chisel:ice1:13>,"&":<chisel:ice1:11>,"n":<chisel:ice:15>,"A":<chisel:ice1:6>,
		"@":<forge:bucketfilled:0> .withTag({FluidName: "cryotheum", Amount: 1000}),
		"#":<tconstruct:bolt_core:0> .withTag({TinkerData: {Materials: ["ice", "iron"]}}),
		"h":<chisel:ice:6>,"k":<minecraft:ice:0>,"r":<chisel:ice:11>,"l":<chisel:icepillar:6>,
		"q":<chisel:ice:8>,"y":<chisel:ice:13>,"8":<chisel:ice1:4>,"`":<chisel:ice:3>,
		"~":<minecraft:snow:0>,"^":<chisel:icepillar:4>,"i":<chisel:ice:5>,"1":<chisel:ice1:8>,
		"f":<chisel:ice:1>,"p":<chisel:icepillar:2>,"t":<chisel:ice1:0>,"9":<chisel:icepillar:0>,
		"c":<chisel:ice1:2>,"5":<minecraft:packed_ice:0>,"g":<chisel:ice1:12>,"d":<chisel:ice1:10>,
		"7":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 2 as short, id: 9 as short}]}),
		"u":<chisel:ice:9>,"2":<mysticalagriculture:crafting:17>,"!":<chisel:ice:2>,"s":<chisel:icepillar:1>,
		"v":<chisel:ice:12>,"w":<chisel:ice:10>,"o":<chisel:ice:7>,"m":<chisel:ice:14>,
		"0":<chisel:ice1:3>,"4":<chisel:ice:4>,"3":<chisel:ice1:5>,"a":<chisel:icepillar:5>,"_":null,
		"6":<chisel:ice1:7>,"%":<thermalfoundation:material:2048>,"e":<chisel:ice:0>,
		"$":<chisel:ice1:9>,"j":<chisel:icepillar:3>,"*":<chisel:ice2:0>,"b":<chisel:ice1:1>
	},"
		@#$%&%A#@;
		#@~123~@#;
		4~56789~0;
		%`!^*abc%;
		d27e_f72g;
		%hijklmn%;
		o~pq7rs~t;
		#@~u2v~@#;
		@#w%x%y#@;"
));
RuneAltar.addRecipe(<mysticalagriculture:inferium_apple>,Lib.Mapper({
		"*":<mysticalagriculture:ice_essence:0>,
		"_":null,
		"@":<mysticalagriculture:stone_essence:0>,
		"$":<mysticalagriculture:nature_essence:0>,
		"~":<extrautils2:magicapple:0>,
		"#":<mysticalagriculture:dirt_essence:0>,
		"&":<mysticalagriculture:water_essence:0>,
		"%":<mysticalagriculture:wood_essence:0>,
        "A":<forge:bucketfilled>.withTag({FluidName: "molten_essence", Amount: 1000}),
        "B":<mysticalagriculture:crafting>
	},"A@B#A$B%A&B*A~B;")[0],1000000);
RuneAltar.addRecipe(<mysticalagriculture:crafting:6>,[
    <minecraft:melon:0>,<minecraft:sapling:0>,<minecraft:tallgrass:1>,
    <minecraft:dye:15>,<minecraft:red_flower:0>,<minecraft:carrot:0>,
    <minecraft:wheat:0>,<minecraft:potato:0>,<minecraft:deadbush:0>,
    <minecraft:leaves:0>,<minecraft:yellow_flower:0>,<minecraft:pumpkin:0>
],10000);

////////////////////////////
////////////////////////////
//ExU
Lib.Shaped9x9(<extrautils2:passivegenerator>*5,Lib.Mapper({
		"#":<minecraft:lapis_block:0>,"%":<enderio:item_basic_capacitor:0>,
		"_":null,"@":<botania:livingrock:4>,"$":<extrautils2:suncrystal:0>,
		"&":<immersiveengineering:storage:8>} as IIngredient[string],"
		_________;_________;_________;
		_@#####@_;_@$%$%$@_;_@&&&&&@_;
		_________;_________;_________;"
));
recipes.remove(<extrautils2:resonator>);
Lib.Shaped9x9(<extrautils2:resonator>,Lib.Mapper({
		"%":<enderio:block_alloy:0>,"_":null,"2":Lib.Consume(<bloodmagic:blood_orb:0> .withTag({orb: "bloodmagic:weak"})),
		"&":<thermalfoundation:storage_alloy:2>,"$":<thermalfoundation:storage_alloy:3>,"*":<thermalfoundation:storage_alloy:4>,
		"1":<thermalfoundation:storage_alloy:1>,"@":<minecraft:redstone_block:0>,"#":<minecraft:obsidian:0>,"~":<extrautils2:suncrystal:0>
	},"
		@#@@#@@#@;
		#$%@&@%*#;
		@$~1&1~*@;
		@@1@~@1@@;
		#%$~2~*%#;
		@@1@~@1@@;
		@$~1&1~*@;
		#$%@&@%*#;
		@#@@#@@#@;"
));

Resonator.remove(<extrautils2:decorativesolid:3>);
Resonator.remove(<extrautils2:decorativesolid:7>);
Resonator.remove(<extrautils2:ingredients:3>);
Resonator.remove(<extrautils2:ingredients:4>);
Resonator.remove(<extrautils2:ingredients:9>);
Resonator.remove(<extrautils2:ingredients:13>);
Resonator.remove(<extrautils2:decorativeglass:5>);

//prep for Music Altar
	recipes.remove(<extrautils2:soundmuffler>);
	recipes.addShaped(<extrautils2:soundmuffler>,Lib.Mapper({"A":<ore:wool>},"AAA;A_A;AAA;"));
	recipes.remove(<minecraft:noteblock>);

Resonator.add(<extrautils2:ingredients:9>,<tconstruct:large_plate>.withTag({Material: "xu_enchanted_metal"}),500);
Resonator.add(<extrautils2:passivegenerator:1>,<extrautils2:passivegenerator>,500);
recipes.remove(<extrautils2:ingredients:6>);
recipes.remove(<extrautils2:ingredients:7>);
recipes.remove(<extrautils2:ingredients:8>);
RuneAltar.addRecipe(<extrautils2:ingredients:8>,[
	<thermalfoundation:tool.pickaxe_platinum:0>,<minecraft:diamond_pickaxe:0>,<thermalfoundation:tool.pickaxe_constantan:0>,
	<thermalfoundation:tool.pickaxe_invar:0>,<botania:manasteelpick:0>,<extrautils2:ingredients:9>,<minecraft:iron_pickaxe:0>,
	<thermalfoundation:tool.pickaxe_electrum:0>,<botania:glasspick:0>,<minecraft:golden_pickaxe:0>,
	<appliedenergistics2:certus_quartz_pickaxe:0>,<minecraft:bucket:0>,<thermalfoundation:tool.pickaxe_bronze:0>
],300000);
Resonator.add(<extrautils2:decorativeglass:5>,<thermalfoundation:glass_alloy:1>,1500);
Lib.Shaped9x9(<extrautils2:ingredients:6>*4,Lib.Mapper({
		"~":<minecraft:gold_ingot:0>,"%":<thermalexpansion:augment:128>,"_":null,
		"*":<thermalfoundation:storage_alloy:1>,"@":<minecraft:redstone_block:0>,
		"1":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 2 as short, id: 32 as short}]}),
		"#":<extrautils2:decorativeglass:5>,"&":<thermalfoundation:glass_alloy:1>,"$":<extrautils2:ingredients:9>
	},"
		_________;
		_@##$##@_;
		_#%&*&%#_;
		_#&*~*&#_;
		_$*~1~*$_;
		_#&*~*&#_;
		_#%*~*%#_;
		_@##$##@_;
		_________;"
));
Lib.Shaped9x9(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}),Lib.Mapper({
		"3":<tconstruct:seared_tank:1> .withTag({FluidName: "emerald", Amount: 4000}),
		"%":<tconstruct:seared_tank:1> .withTag({FluidName: "emerald", Amount: 3333}),
		"@":<minecraft:potion:0> .withTag({Potion: "minecraft:strong_leaping"}),
		"&":<minecraft:potion:0> .withTag({Potion: "minecraft:strong_poison"}),
		"6":Lib.Consume(<bloodmagic:blood_orb:0> .withTag({orb: "bloodmagic:weak"})),
		"#":<minecraft:potion:0> .withTag({Potion: "cofhcore:luck2"}),
		"~":<botania:manatablet:0> .withTag({mana: 375000}),
		"*":<botania:manatablet:0> .withTag({mana: 125000}),
		"2":<botania:pylon:0>,"$":<chisel:emerald:10>,
		"8":<mysticalagriculture:nature_essence:0>,
		"7":<mysticalagriculture:ingot_storage:1>,
		"4":<mysticalagriculture:stone_essence:0>,
		"5":<mysticalagriculture:wood_essence:0>,
		"9":<mysticalagriculture:dirt_essence:0>,
		"1":<mysticalagriculture:nature_seeds:0>,
	},"
		@#$$%$$&@;
		&$$**~$$#;
		$$12341$$;
		$~56162*$;
		%*31713*%;
		$*26168~$;
		$$19321$$;
		#$$~**$$&;
		@&$$%$$#@;"
));
recipes.addShaped(<thaumcraft:arcane_workbench>,Lib.Mapper({
	"A":<minecraft:crafting_table>,
	"B":<avaritia:extreme_crafting_table>,
	"O":Lib.Reuse(orb(2))
},"BAB;AOA;BAB;"));
<ore:blockEmerald>.remove(<chisel:emerald:10>);
Resonator.add(<chisel:emerald:10>,<minecraft:emerald_block>,2100);

Lib.Shaped9x9(<thermalfoundation:fertilizer>*8,Lib.Mapper({
		"_":null,
		"#":<thermalfoundation:material:819>,
		"$":<mysticalagriculture:crafting:6>,
		"@":<mysticalagriculture:water_essence:0>,
		"%":<appliedenergistics2:paint_ball:20>
	},"
		_________;
		_@___@___;
		__#@_$___;
		__@#%@$@_;
		___%#%___;
		_@$@%#@__;
		___$_@#__;
		___@___@_;
		_________;"
));