#loader crafttweaker reloadableevents
import mods.botaniatweaks.Agglomeration as Agg;
import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
T.ava.shaped(<extrautils2:decorativesolid:3>*8,Mp.read(
    "	_________;
		_________;
		__@#$%&__;
		__*~$~1__;
		__$$2$$__;
		__1~$~*__;
		__3%$#4__;
		_________;
		_________;",
    {
		"4":<chisel:emerald:10>,
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
	}
));
T.tic.casting(<mysticalagriculture:crafting:1>*4,<mysticalagriculture:inferium_apple>,<liquid:molten_essence>*3072,300);
T.bot.altar(<mysticalagriculture:tier2_inferium_seeds>*6,Mp.read("@~#~$~%~&~*~;",{
		"@":<mysticalagriculture:stone_seeds:0>,
		"#":<mysticalagriculture:dirt_seeds:0>,
		"%":<mysticalagriculture:wood_seeds:0>,
		"&":<mysticalagriculture:water_seeds:0>,
		"$":<mysticalagriculture:nature_seeds:0>,
		"*":<mysticalagriculture:ice_seeds:0>,
		"~":<mysticalagriculture:crafting:1>
	})[0],300000);
T.bm.altar(<mysticalagriculture:crafting:18>*4,<mysticalagriculture:tier2_inferium_seeds>*4,10240);
<extrautils2:decorativesolid:3>.displayName = game.localize("name.crt.stone.rune");
recipes.addShaped(<contenttweaker:wand_cap_iron>,Mp.read("xxx;x_x;___;",{"x":<minecraft:iron_nugget>}));
T.tc.shaped(<bloodmagic:blood_rune>,Mp.read("&#&;@&%;&$&;",{
		"#":<botania:manaresource:23>,
		"@":<enderio:item_material:20>,
		"&":<extrautils2:decorativesolid:3>,
		"%":<thermalfoundation:material:819>,
		"$":<minecraft:redstone:0>
	}),3);
//Seeds
//Though seeds cannot be crafted before other tech trees, they ar designed first, so they are before other contents of C3_3 in this file.
var seedsA=[
	//<mysticalagriculture:slime_seeds>,
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

T.ava.shaped(<mysticalagriculture:fire_seeds>*2,Mp.read(
    "   ___@_____;
		__@#@____;
		__$@%@___;
		_&*~12@__;
		__$131$__;
		__@21~*&_;
		___@%@$__;
		____@#@__;
		_____@___;",
    {
		"*":<mysticalagriculture:crafting:18>,
		"2":<thaumcraft:alumentum:0>,
		"~":<tconstruct:firewood>,
		"#":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 2 as short, id: 20 as short}]}),
		"$":<calculator:firediamond:0>,
		"@":<tconstruct:edible:34>,
		"&":<calculator:material:6>,
		"3":<thermalexpansion:tank:0> .withTag({RSControl: 0 as byte, Creative: 0 as byte, Fluid: {FluidName: "pyrotheum", Amount: 32768}, Level: 1 as byte, Lock: 0 as byte}),
		"%":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 1 as short, id: 50 as short}]}),
		"1":<botania:specialflower:0> .withTag({type: "thermalily"})
	}
));
T.ava.shaped(<mysticalagriculture:crafting:8>*4,Mp.read(
    "	_________;
		_@__#__$_;
		__@%&@$__;
		__%@*~@__;
		_#&*%*&#_;
		__@~*@%__;
		__$@&%@__;
		_$__#__@_;
		_________;",
    {
		"$":<minecraft:blaze_rod:0>,
		"@":<minecraft:nether_wart:0>,
		"#":<tconstruct:firewood>,
		"~":<extrautils2:compressednetherrack:0>,
		"%":<minecraft:ghast_tear:0>,
		"_":null,
		"*":<botania:blazeblock:0>,
		"&":<mysticalagriculture:crafting:6>
	}
));
T.ava.shaped(<mysticalagriculture:nether_seeds>*4,Mp.read(
    "   _________;
		_________;
		__@#$%@__;
		__%&@&#__;
		__$@*@$__;
		__#&@&%__;
		__@%$#@__;
		_________;
		_________;",
    {
		"#":<minecraft:potion:0> .withTag({Potion: "minecraft:long_fire_resistance"}),
		"&":<mysticalagriculture:crafting:18>,
		"$":<tconstruct:firewood>,
		"_":null,
		"@":<mysticalagriculture:crafting:8>,
		"*":<chisel:netherrack:3>,
		"%":<minecraft:enchanted_book:0> .withTag({StoredEnchantments: [{lvl: 4 as short, id: 1 as short}]})
	}
));


T.ava.shaped(<botania:alchemycatalyst>,Mp.read(
    "	@@@#@#@@@;
		@$%&*&~1@;
		@%$%2~1~@;
		#&%$&1~&#;
		@*2&3&2*@;
		#&45&67&#;
		@4542767@;
		@54&*&76@;
		@@@#@#@@@;",
    {
		"2":<tconstruct:tough_binding:0> .withTag({Material: "xu_enchanted_metal"}),
		"6":<mysticalagriculture:crafting:10>,"5":<mysticalagriculture:crafting:6>,
		"#":<thermalfoundation:glass_alloy:1>,"$":<mysticalagriculture:crafting:7>,
		"7":<mysticalagriculture:nature_essence:0>,"@":<botania:livingrock:2>,
		"%":<mysticalagriculture:wood_essence:0>,"~":<contenttweaker:shard_perditio>,
		"1":<mysticalagriculture:crafting:8>,"*":<chisel:blockelectrum:5>,
		"3":M.consume(<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"})),"&":<extrautils2:suncrystal:0>,
		"4":<mysticalagriculture:stone_essence:0>
	}
));

T.bot.altar(<mysticalagriculture:dye_seeds>*2,[
	<mysticalagriculture:crafting:18>,<minecraft:red_flower:1>,<minecraft:red_flower:2>,<minecraft:red_flower:3>,
	<mysticalagriculture:crafting:7>,<minecraft:red_flower:5>,<minecraft:red_flower:7>,<minecraft:double_plant:1>,
	<mysticalagriculture:crafting:18>,<minecraft:double_plant:5>,<minecraft:double_plant:4>,<minecraft:red_flower:4>,
	<mysticalagriculture:crafting:7>,<minecraft:red_flower:8>,<minecraft:red_flower:6>,<minecraft:double_plant>],3000000);
var vanillaDyes as IItemStack[]=[];
for i in 0 to 16{vanillaDyes+=<minecraft:dye>.definition.makeStack(i);}
T.bot.altar(<mysticalagriculture:crafting:7>,vanillaDyes,500000);
var botMysticFlowers as IItemStack[]=[];
for i in 0 to 16{botMysticFlowers+=<botania:shinyflower>.definition.makeStack(i);}
T.bot.altar(<mysticalagriculture:crafting:10>,botMysticFlowers,500000);


//post salisMundus & blue Slime
recipes.remove(<thaumcraft:salis_mundus>);/*
T.ie.mixer(<liquid:bot_mana>*144, [
	<botania:manatablet>.withTag({mana: 400000}),<thaumcraft:salis_mundus>
], <liquid:mana>*16, 2048);*/
T.eio.vat(<liquid:bot_mana>, <liquid:mana>, 0.25f, [
	<mysticalagriculture:manasteel_essence>%20,
	<botania:manatablet>.withTag({mana: 100000})%40,
	<botania:manatablet>.withTag({mana: 375000})%60,
	<botania:manatablet>.withTag({mana: 225000})%60,
	<botania:manatablet>.withTag({mana: 204800})%100
],[
	<thaumcraft:salis_mundus>%100
]);
//note that slime turns blue when getting into liquid mana, done in 2C3MiscReloadable.zs
recipes.remove(<tconstruct:soil:2>);
T.ava.shaped(<tconstruct:materials:10>*4,Mp.read(
    "	____@____;
		_@__#__@_;
		__@$#$@__;
		__$#%#$__;
		@##%&%##@;
		__$#%#$__;
		__@$#$@__;
		_@__#__@_;
		____@____;",
    {
		"$":<botania:manaresource:2>,
		"@":<botania:pylon:0>,
		"%":<mysticalagriculture:water_seeds:0>,
		"#":<tconstruct:edible:1>,
		"&":<appliedenergistics2:material:47>
	}
));
T.cc.flawless(<calculator:largetanzanite>, [
    <minecraft:emerald>, <tconstruct:materials:10>, <botania:pylon>,
	<appliedenergistics2:facade>.withTag({damage: 0, item: "minecraft:lapis_block"})
]);
T.cc.flawless(<calculator:tanzaniteplanks>, [
    <calculator:largetanzanite>, <botania:dreamwood:2>,
	<extrautils2:decorativesolidwood>, <calculator:largetanzanite>
]);
mods.tconstruct.Casting.removeBasinRecipe(<tconstruct:firewood>);
T.tic.casting(<tconstruct:firewood>,<calculator:tanzaniteplanks>,<liquid:pyrotheum>*1296,1000,true,true);

//Calculators
val add0 = <contenttweaker:calc_sigil_addition>;
val div0 = <contenttweaker:calc_sigil_division>;
val calc0 = <calculator:calculator>;
val calc1 = <calculator:scientificcalculator>;
val calc2 = <calculator:atomiccalculator>;
val calc3 = <calculator:flawlesscalculator>;
mods.calculator.atomic.removeRecipe(calc1);
recipes.addShapeless(add0,[calc0]);
recipes.addShapeless(div0,[calc1]);
recipes.addShapeless(calc0,[add0]);
recipes.addShapeless(calc1,[div0]);
T.cc.basic(calc2,[add0,add0]);
T.cc.atomic(<calculator:flawlesscalculator>.withTag({"0": {}}),[add0,div0,add0]);
T.ava.shaped(add0,Mp.read(
    "	___@#@___;
		___$#$___;
		___$%$___;
		@$$$%$$$@;
		##%%&%%##;
		@$$$%$$$@;
		___$%$___;
		___$#$___;
		___@#@___;",
    {
		"%":<extrautils2:ingredients:6>,
		"#":<appliedenergistics2:material:22>,
		"$":<appliedenergistics2:material:23>,
		"@":<appliedenergistics2:material:24>,
		"&":<appliedenergistics2:material:47>
	}
));
T.ava.shaped(div0,Mp.read(
    "	_________;
		__@#$%&__;
		_*@#~%&*_;
		_~@#$%&~_;
		_1234561_;
		_~78$90~_;
		_`78~90`_;
		__78$90__;
		_________;",
    {
		"~":add0,
		"7":<minecraft:diamond:0>,
		"0":<minecraft:gold_ingot:0>,
		"$":<extrautils2:ingredients:6>,
		"8":<appliedenergistics2:material:5>,
		"9":<appliedenergistics2:material:10>,
		"#":<appliedenergistics2:material:20>,
		"&":<appliedenergistics2:material:18>,
		"1":<appliedenergistics2:material:36>,
		"4":<appliedenergistics2:material:47>,
		"`":<appliedenergistics2:material:37>,
		"%":<appliedenergistics2:material:16>,
		"*":<appliedenergistics2:material:38>,
		"@":<appliedenergistics2:material:17>,
		"5":M.reuse(<appliedenergistics2:material:13>),
		"2":M.reuse(<appliedenergistics2:material:14>),
		"6":M.reuse(<appliedenergistics2:material:15>),
		"3":M.reuse(<appliedenergistics2:material:19>)
	}
));
T.ava.shaped(<calculator:dockingstation>*4,Mp.read(
    "	_________;
		_@#@$@#@_;
		_#@%&%@#_;
		_@*~1~*@_;
		_$&234&$_;
		_#*~5~*#_;
		_@#%&%#@_;
		_#@#$#@#_;
		_________;",
    {
		"@":<thermalfoundation:glass:8>,
		"&":<appliedenergistics2:part:220>,
		"#":<extrautils2:decorativesolid:3>,
		"~":<appliedenergistics2:material:22>,
		"%":<appliedenergistics2:material:23>,
		"*":<appliedenergistics2:material:24>,
		"$":<appliedenergistics2:interface:0>,
		"3":<appliedenergistics2:creative_energy_cell:0>,
		"2":M.reuse(calc0),
		"4":M.reuse(calc1),
		"5":M.reuse(calc2),
		"1":M.reuse(calc3)
	}
));
T.cc.scientific(<minecraft:nether_wart>,[
    <tconstruct:seared_tank:1>.withTag({FluidName: "potion", Amount: 4000, Tag: {Potion: "minecraft:awkward"}}),
	<tconstruct:seared_tank:1>.withTag({FluidName: "water", Amount: 666})
]);
T.tic.casting(<tconstruct:edible:4>,<tconstruct:edible:1>,<liquid:pyrotheum>*144,300);

//enderpearl fix
mods.calculator.flawless.removeRecipe(<minecraft:ender_pearl>);
for i in [<minecraft:ender_pearl>, <minecraft:slime_ball>, <minecraft:cactus>, <minecraft:redstone>, <minecraft:glowstone_dust>, <minecraft:chorus_flower>]as IItemStack[]{
	mods.botania.ManaInfusion.removeRecipe(i);
}
//living wand rod
T.ie.press(
    <contenttweaker:wand_rod_livingwood>, <botania:manaresource:3>*3, 
	<tconstruct:cast>.withTag({PartType: "tconstruct:tough_tool_rod"}), 2000
);
//salisMundus
T.tc.shaped(<thaumcraft:crucible>,Mp.read("A_A;D_D;AMA;",{
	"A":<bloodmagic:blood_rune>,
	"D":<enderio:block_alloy:6>,
	"M":<botania:storage>
}),4);

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
	T.tc.crucible(<contenttweaker:shard_balanced>,shards[i],scripts.recipes.libs.Aspects.aspect6(aspects));
}
T.ie.press(<thaumcraft:salis_mundus>, <contenttweaker:shard_balanced>, <tconstruct:materials:14>, 2000);
mods.jei.JEI.addDescription(<thaumcraft:salis_mundus>,game.localize("jei.description.salis_mundus"));

// Durability Plate
recipes.remove(<tconstruct:materials:14>);
T.ava.shaped(<tconstruct:materials:14>,Mp.read(
    "	@@@@@@@@@;
		@#$%&*~1@;
		@2334335@;
		@6337338@;
		@90333`!@;
		@^33333a@;
		@b3cde3f@;
		@ghijklm@;
		@@@@@@@@@;",
    {
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
	}
));
recipes.remove(<minecraft:redstone_lamp>);