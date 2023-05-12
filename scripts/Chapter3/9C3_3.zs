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
Lib.Arcane(<bloodmagic:blood_rune>*4,Lib.Mapper({
		"#":<botania:manaresource:23>,
		"@":<enderio:item_material:20>,
		"&":<extrautils2:decorativesolid:3>,
		"%":<thermalfoundation:material:819>,
		"$":<minecraft:redstone:0>
	},"&#&;@&%;&$&;"),10);