import crafttweaker.world.IWorld;
import mods.randomtweaker.botania.ICocoon;
addRegexLogFilter("^.*cocoon.*");
addRegexLogFilter("^WARNING.*");
addRegexLogFilter("^[RandomTweaker].*");
addRegexLogFilter("^ [RandomTweaker].*");
<minecraft:golden_apple>.addTooltip(format.gold(format.italic(game.localize("description.crt.tooltip.haste"))));