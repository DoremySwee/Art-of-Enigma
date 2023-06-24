#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.ISubTileEntityGenerating;
import crafttweaker.data.IData;
import scripts.cot.CotLib;

val flower as ISubTileEntityGenerating = VanillaFactory.createSubTileGenerating("irisotos");
    flower.range = 1;
    flower.maxMana = 10000000;
    flower.register();

CotLib.createItem("division_sigil",{"maxStackSize":1});
CotLib.createItem("division_sigil_activated",{"maxDamage":256,"maxStackSize":1,"glowing":true});
CotLib.createItem("psu_inver_sigil",{"maxDamage":256,"maxStackSize":1,"glowing":true});

val ResurrectionStonetileEntity = VanillaFactory.createActualTileEntity(1);
    ResurrectionStonetileEntity.onTick= function(te, world, pos) {};
    ResurrectionStonetileEntity.register();
val ResurrectionStone = VanillaFactory.createExpandBlock("resurrection_stone", <blockmaterial:iron>);
    ResurrectionStone.blockHardness = 10.0f;
    ResurrectionStone.tileEntity = ResurrectionStonetileEntity;
    ResurrectionStone.register();

    
CotLib.createItem("shard_aqua");
CotLib.createItem("shard_ignis");
CotLib.createItem("shard_aer");
CotLib.createItem("shard_terra");
CotLib.createItem("shard_ordo");
CotLib.createItem("shard_perditio");
CotLib.createItem("shard_balanced");