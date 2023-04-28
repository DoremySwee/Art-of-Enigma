#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.cote.ISubTileEntityGenerating;

val flower as ISubTileEntityGenerating = VanillaFactory.createSubTileGenerating("irisotos");
flower.range = 15;
flower.maxMana = 100000;
flower.register();
