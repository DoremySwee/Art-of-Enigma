import mods.botaniatweaks.Agglomeration as Agg;
import mods.bloodmagic.TartaricForge as TF;
import mods.bloodmagic.BloodAltar as BA;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.extrautils2.Resonator;
import mods.calculator.flawless;
import mods.tconstruct.Casting;
import mods.tconstruct.Melting;
import mods.botania.RuneAltar;
import mods.embers.Stamper;
import mods.embers.Melter;
import mods.embers.Mixer;
import scripts.Lib;
//////////////////////////
//////////////////////////
//////////////////////////
//Lv2 BA
Lib.Shaped9x9(<extrautils2:decorativesolid:3>*2,Lib.Mapper({
		"4":<chisel:emerald:10>,
		"_":null,
		"&":<chisel:lapis:3>,
		"3":<chisel:redstone1:7>,
		"1":<chisel:obsidian:13>,
		"#":<chisel:waterstone1:8>,
		"$":<bloodmagic:slate:0>,
		"~":<botania:livingrock:1>,
		"2":<tconstruct:seared:6>,
		"%":<chisel:lavastone1:8>,
		"*":<chisel:glowstone1:14>,
		"@":<chisel:diamond:11>
	},"
		_________;
		_________;
		__@#$%&__;
		__*~$~1__;
		__$$2$$__;
		__1~$~*__;
		__3%$#4__;
		_________;
		_________;"
));
Casting.addTableRecipe(<mysticalagriculture:crafting:1>*4,<mysticalagriculture:inferium_apple>,<liquid:molten_essence>,3072,true,300);
RuneAltar.addRecipe(<mysticalagriculture:tier2_inferium_seeds>*6,Lib.Mapper({
		"@":<mysticalagriculture:stone_seeds:0>,
		"#":<mysticalagriculture:dirt_seeds:0>,
		"_":null,
		"%":<mysticalagriculture:wood_seeds:0>,
		"&":<mysticalagriculture:water_seeds:0>,
		"$":<mysticalagriculture:nature_seeds:0>,
		"*":<mysticalagriculture:ice_seeds:0>,
		"~":<mysticalagriculture:crafting:1>
	},"@~#~$~%~&~*~;")[0],300000);
BA.addRecipe(<mysticalagriculture:crafting:18>*4,<mysticalagriculture:tier2_inferium_seeds>*4,1,10240,1,0);
<extrautils2:decorativesolid:3>.displayName = game.localize("name.crt.stone.rune");
recipes.addShaped(<contenttweaker:wand_cap_iron>,Lib.Mapper({"x":<minecraft:iron_nugget>},"xxx;x_x;___;"));
Lib.Arcane(<bloodmagic:blood_rune>,Lib.Mapper({
		"#":<botania:manaresource:23>,
		"@":<enderio:item_material:20>,
		"&":<extrautils2:decorativesolid:3>,
		"%":<thermalfoundation:material:819>,
		"$":<minecraft:redstone:0>
	},"&#&;@&%;&$&;"),3);
//Seeds
//Though seeds cannot be crafted before other tech trees, they ar designed first, so they are before other contents of C3_3 in this file.
var seedsA=[
	<mysticalagriculture:slime_seeds>,
	<mysticalagriculture:copper_seeds>,
	<mysticalagriculture:grains_of_infinity_seeds>,
	<mysticalagriculture:mystical_flower_seeds>,
	<mysticalagriculture:marble_seeds>,
	<mysticalagriculture:aluminum_seeds>,
	<mysticalagriculture:limestone_seeds>,
	<mysticalagriculture:basalt_seeds>,
	<mysticalagriculture:coal_seeds>,
	<mysticalagriculture:sulfur_seeds>,
	<mysticalagriculture:pig_seeds>,
	<mysticalagriculture:chicken_seeds>,
	<mysticalagriculture:cow_seeds>,
	<mysticalagriculture:sheep_seeds>,
	<mysticalagriculture:aluminum_brass_seeds>,
	<mysticalagriculture:silicon_seeds>
	]as IItemStack[];

for seed in seedsA{
	mods.jei.JEI.removeAndHide(seed);
}

Lib.Shaped9x9(<mysticalagriculture:fire_seeds>*2,Lib.Mapper({
		"*":<mysticalagriculture:crafting:18>,
		"2":<thaumcraft:alumentum:0>,
		"~":<tconstruct:firewood>,
		"#":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 2 as short, id: 20 as short}]}),
		"$":<calculator:firediamond:0>,
		"_":null,
		"@":<tconstruct:edible:34>,
		"&":<calculator:material:6>,
		"3":<thermalexpansion:tank:0> .withTag({RSControl: 0 as byte, Creative: 0 as byte, Fluid: {FluidName: "pyrotheum", Amount: 32768}, Level: 1 as byte, Lock: 0 as byte}),
		"%":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 1 as short, id: 50 as short}]}),
		"1":<botania:specialflower:0> .withTag({type: "thermalily"})
	},"
		___@_____;
		__@#@____;
		__$@%@___;
		_&*~12@__;
		__$131$__;
		__@21~*&_;
		___@%@$__;
		____@#@__;
		_____@___;"
));
Lib.Shaped9x9(<mysticalagriculture:crafting:8>*4,Lib.Mapper({
		"$":<minecraft:blaze_rod:0>,
		"@":<minecraft:nether_wart:0>,
		"#":<tconstruct:firewood>,
		"~":<extrautils2:compressednetherrack:0>,
		"%":<minecraft:ghast_tear:0>,
		"_":null,
		"*":<botania:blazeblock:0>,
		"&":<mysticalagriculture:crafting:6>
	},"
		_________;
		_@__#__$_;
		__@%&@$__;
		__%@*~@__;
		_#&*%*&#_;
		__@~*@%__;
		__$@&%@__;
		_$__#__@_;
		_________;"
));
Lib.Shaped9x9(<mysticalagriculture:nether_seeds>*4,Lib.Mapper({
		"#":<minecraft:potion:0> .withTag({Potion: "minecraft:long_fire_resistance"}),
		"&":<mysticalagriculture:crafting:18>,
		"$":<tconstruct:firewood>,
		"_":null,
		"@":<mysticalagriculture:crafting:8>,
		"*":<chisel:netherrack:3>,
		"%":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 4 as short, id: 1 as short}]})
	},"
		_________;
		_________;
		__@#$%@__;
		__%&@&#__;
		__$@*@$__;
		__#&@&%__;
		__@%$#@__;
		_________;
		_________;"
));


Lib.Shaped9x9(<botania:alchemycatalyst>,Lib.Mapper({
		"2":<tconstruct:tough_binding:0> .withTag({Material: "xu_enchanted_metal"}),
		"6":<mysticalagriculture:crafting:10>,"5":<mysticalagriculture:crafting:6>,
		"#":<thermalfoundation:glass_alloy:1>,"$":<mysticalagriculture:crafting:7>,
		"7":<mysticalagriculture:nature_essence:0>,"@":<botania:livingrock:2>,
		"%":<mysticalagriculture:wood_essence:0>,"~":<contenttweaker:shard_perditio>,
		"1":<mysticalagriculture:crafting:8>,"*":<chisel:blockelectrum:5>,
		"3":Lib.Consume(Lib.orb(2)),"&":<extrautils2:suncrystal:0>,
		"4":<mysticalagriculture:stone_essence:0>
	},"
		@@@#@#@@@;
		@$%&*&~1@;
		@%$%2~1~@;
		#&%$&1~&#;
		@*2&3&2*@;
		#&45&67&#;
		@4542767@;
		@54&*&76@;
		@@@#@#@@@;"
));

RuneAltar.addRecipe(<mysticalagriculture:dye_seeds>*2,[
	<mysticalagriculture:crafting:18>,<minecraft:red_flower:1>,<minecraft:red_flower:2>,<minecraft:red_flower:3>,
	<mysticalagriculture:crafting:7>,<minecraft:red_flower:5>,<minecraft:red_flower:7>,<minecraft:double_plant:1>,
	<mysticalagriculture:crafting:18>,<minecraft:double_plant:5>,<minecraft:double_plant:4>,<minecraft:red_flower:4>,
	<mysticalagriculture:crafting:7>,<minecraft:red_flower:8>,<minecraft:red_flower:6>,<minecraft:double_plant>],3000000);
var vanillaDyes as IItemStack[]=[];
for i in 0 to 16{vanillaDyes+=<minecraft:dye>.definition.makeStack(i);}
RuneAltar.addRecipe(<mysticalagriculture:crafting:7>,vanillaDyes,500000);
var botMysticFlowers as IItemStack[]=[];
for i in 0 to 16{botMysticFlowers+=<botania:shinyflower>.definition.makeStack(i);}
RuneAltar.addRecipe(<mysticalagriculture:crafting:10>,botMysticFlowers,500000);


//post salisMundus & blue Slime

recipes.remove(<thaumcraft:salis_mundus>);
mods.immersiveengineering.Mixer.addRecipe(<liquid:bot_mana>*144, <liquid:mana>*144, [
	<botania:manatablet>.withTag({mana: 400000}),<thaumcraft:salis_mundus>], 2048);
//note that slime turns blue when getting into liquid mana, done in 2C3MiscReloadable.zs
recipes.remove(<tconstruct:soil:2>);
Lib.Shaped9x9(<tconstruct:materials:10>*4,Lib.Mapper({
		"$":<botania:manaresource:2>,
		"@":<botania:pylon:0>,
		"%":<mysticalagriculture:water_seeds:0>,
		"#":<tconstruct:edible:1>,
		"&":<appliedenergistics2:material:47>
	},"
		____@____;
		_@__#__@_;
		__@$#$@__;
		__$#%#$__;
		@##%&%##@;
		__$#%#$__;
		__@$#$@__;
		_@__#__@_;
		____@____;"
));
flawless.addRecipe(
	<minecraft:emerald>,
	<tconstruct:materials:10>,
	<botania:pylon>,
	<appliedenergistics2:facade>.withTag({damage: 0, item: "minecraft:lapis_block"}),
	<calculator:largetanzanite>);
flawless.addRecipe(
	<calculator:largetanzanite>,
	<botania:dreamwood:2>,
	<extrautils2:decorativesolidwood>,
	<calculator:largetanzanite>,
	<calculator:tanzaniteplanks>);
Casting.removeBasinRecipe(<tconstruct:firewood>);
Casting.addBasinRecipe(<tconstruct:firewood>,<calculator:tanzaniteplanks>,<liquid:pyrotheum>,1296,true,1000);

//Calculators
Lib.Shaped9x9(<calculator:calculator>,Lib.Mapper({
		"#":<appliedenergistics2:material:22>,
		"$":<appliedenergistics2:material:23>,
		"@":<appliedenergistics2:material:24>,
		"%":<extrautils2:ingredients:6>,
		"&":<appliedenergistics2:material:47>
	},"
		___@#@___;
		___$#$___;
		___$%$___;
		@$$$%$$$@;
		##%%&%%##;
		@$$$%$$$@;
		___$%$___;
		___$#$___;
		___@#@___;"
));
mods.calculator.atomic.removeRecipe(<calculator:scientificcalculator>);
Lib.Shaped9x9(<calculator:scientificcalculator>,Lib.Mapper({
		"9":<appliedenergistics2:material:10>,
		"0":<minecraft:gold_ingot:0>,
		"5":Lib.Reuse(<appliedenergistics2:material:13>),
		"~":<calculator:calculator:0>,
		"#":<appliedenergistics2:material:20>,
		"$":<extrautils2:ingredients:6>,
		"&":<appliedenergistics2:material:18>,
		"3":Lib.Reuse(<appliedenergistics2:material:19>),
		"7":<minecraft:diamond:0>,
		"1":<appliedenergistics2:material:36>,
		"2":Lib.Reuse(<appliedenergistics2:material:14>),
		"4":<appliedenergistics2:material:47>,
		"8":<appliedenergistics2:material:5>,
		"6":Lib.Reuse(<appliedenergistics2:material:15>),
		"`":<appliedenergistics2:material:37>,
		"%":<appliedenergistics2:material:16>,
		"*":<appliedenergistics2:material:38>,
		"@":<appliedenergistics2:material:17>
	},"
		_________;
		__@#$%&__;
		_*@#~%&*_;
		_~@#$%&~_;
		_1234561_;
		_~78$90~_;
		_`78~90`_;
		__78$90__;
		_________;"
));
mods.calculator.basic.addRecipe(<calculator:calculator>,<calculator:calculator>,<calculator:atomiccalculator>);
mods.calculator.atomic.addRecipe(<calculator:calculator>,<calculator:scientificcalculator>,<calculator:calculator>,<calculator:flawlesscalculator>.withTag({"0": {}}));
Lib.Shaped9x9(<calculator:dockingstation>,Lib.Mapper({
		"~":<appliedenergistics2:material:22>,
		"%":<appliedenergistics2:material:23>,
		"5":<calculator:atomiccalculator:0>,
		"&":<appliedenergistics2:part:220>,
		"*":<appliedenergistics2:material:24>,
		"2":<calculator:calculator:0>,
		"3":<appliedenergistics2:creative_energy_cell:0>,
		"#":<extrautils2:decorativesolid:3>,
		"1":<calculator:flawlesscalculator:0>,
		"@":<thermalfoundation:glass:8>,
		"4":<calculator:scientificcalculator:0>,
		"$":<appliedenergistics2:interface:0>
	},"
		_________;
		_@#@$@#@_;
		_#@%&%@#_;
		_@*~1~*@_;
		_$&234&$_;
		_#*~5~*#_;
		_@#%&%#@_;
		_#@#$#@#_;
		_________;"
));
mods.calculator.scientific.addRecipe(
	<tconstruct:seared_tank:1>.withTag({FluidName: "potion", Amount: 4000, Tag: {Potion: "minecraft:awkward"}}),
	<tconstruct:seared_tank:1>.withTag({FluidName: "water", Amount: 666}),
	<minecraft:nether_wart>);
Casting.addTableRecipe(<tconstruct:edible:4>,<tconstruct:edible:1>,<liquid:pyrotheum>,144,true,300);

//enderpearl fix
flawless.removeRecipe(<minecraft:ender_pearl>);
for i in [<minecraft:ender_pearl>, <minecraft:slime_ball>, <minecraft:cactus>, <minecraft:redstone>, <minecraft:glowstone_dust>, <minecraft:chorus_flower>]as IItemStack[]{
	mods.botania.ManaInfusion.removeRecipe(i);
}
//living wand rod
mods.immersiveengineering.MetalPress.addRecipe(
	<contenttweaker:wand_rod_livingwood>, <botania:manaresource:3>, 
	<tconstruct:cast>.withTag({PartType: "tconstruct:tough_tool_rod"}), 2000, 3);
//salisMundus
Lib.Arcane(<thaumcraft:crucible>,Lib.Mapper({
	"A":<bloodmagic:blood_rune>,
	"D":<enderio:block_alloy:6>,
	"M":<botania:storage>
},"A_A;D_D;AMA;"),4);

var shards as IItemStack[]=[
	<contenttweaker:shard_aer>,
	<contenttweaker:shard_terra>,
	<contenttweaker:shard_ignis>,
	<contenttweaker:shard_aqua>,
	<contenttweaker:shard_ordo>,
	<contenttweaker:shard_perditio>
];
for i in 0 to 6{
	var aspects as int[]=[];
	for j in 0 to 6{
		aspects+=(i==j)?0:5;
	}
	Lib.Crucible(<contenttweaker:shard_balanced>,shards[i],Lib.aspect6array(aspects));
}
mods.immersiveengineering.MetalPress.addRecipe(
	<thaumcraft:salis_mundus>, <contenttweaker:shard_balanced>, 
	<tconstruct:materials:14>, 2000, 1);

mods.jei.JEI.addDescription(<thaumcraft:salis_mundus>,game.localize("jei.description.salis_mundus"));

// Durability Plate
recipes.remove(<tconstruct:materials:14>);
Lib.Shaped9x9(<tconstruct:materials:14>,Lib.Mapper({
		"&":<tconstruct:cast:0> .withTag({PartType: "tconstruct:bow_string"}),
		"a":<tconstruct:cast:0> .withTag({PartType: "tconstruct:hammer_head"}),
		"f":<tconstruct:cast:0> .withTag({PartType: "tconstruct:broad_axe_head"}),
		"5":<tconstruct:cast:0> .withTag({PartType: "tconstruct:large_plate"}),
		"~":<tconstruct:cast:0> .withTag({PartType: "tconstruct:wide_guard"}),
		"g":<tconstruct:cast:0> .withTag({PartType: "tconstruct:kama_head"}),
		"%":<tconstruct:cast:0> .withTag({PartType: "tconstruct:axe_head"}),
		"1":<tconstruct:cast:0> .withTag({PartType: "tconstruct:shard"}),
		"e":<tconstruct:cast:0> .withTag({PartType: "tconstruct:hand_guard"}),
		"h":<tconstruct:cast:0> .withTag({PartType: "tconstruct:cross_guard"}),
		"^":<tconstruct:cast:0> .withTag({PartType: "tconstruct:tool_rod"}),
		"*":<tconstruct:cast:0> .withTag({PartType: "tconstruct:sharpening_kit"}),
		"7":<tconstruct:cast:0> .withTag({PartType: "tconstruct:large_sword_blade"}),
		"9":<tconstruct:cast:0> .withTag({PartType: "tconstruct:shovel_head"}),
		"`":<tconstruct:cast:0> .withTag({PartType: "tconstruct:sign_head"}),
		"2":<tconstruct:cast:0> .withTag({PartType: "tconstruct:tough_binding"}),
		"b":<tconstruct:cast:0> .withTag({PartType: "tconstruct:knife_blade"}),
		"d":<tconstruct:cast:0> .withTag({PartType: "tconstruct:pan_head"}),
		"6":<tconstruct:cast:0> .withTag({PartType: "tconstruct:scythe_head"}),
		"4":<tconstruct:cast:0> .withTag({PartType: "tconstruct:sword_blade"}),
		"8":<tconstruct:cast:0> .withTag({PartType: "tconstruct:bow_limb"}),
		"i":<tconstruct:cast:0> .withTag({PartType: "tconstruct:arrow_head"}),
		"0":<tconstruct:cast:0> .withTag({PartType: "tconstruct:binding"}),
		"$":<tconstruct:cast:0> .withTag({PartType: "tconstruct:excavator_head"}),
		"!":<tconstruct:cast:0> .withTag({PartType: "tconstruct:pick_head"}),
		"c":<tconstruct:cast:0> .withTag({PartType: "tconstruct:tough_tool_rod"}),
		"@":<tconstruct:large_plate:0> .withTag({Material: "obsidian"}),
		"#":<tconstruct:cast_custom:4>,"3":<calculator:purifiedobsidian:0>,
		"j":<tconstruct:cast_custom:0>,"l":<tconstruct:cast_custom:2>,
		"m":<tconstruct:cast_custom:3>,"k":<tconstruct:cast_custom:1>,
	},"
		@@@@@@@@@;
		@#$%&*~1@;
		@2334335@;
		@6337338@;
		@90333`!@;
		@^33333a@;
		@b3cde3f@;
		@ghijklm@;
		@@@@@@@@@;"
));
recipes.remove(<minecraft:redstone_lamp>);