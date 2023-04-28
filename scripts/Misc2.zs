addRegexLogFilter("^.*cocoon.*");
addRegexLogFilter("^WARNING.*");
addRegexLogFilter("^[RandomTweaker].*");
addRegexLogFilter("^ [RandomTweaker].*");
<minecraft:golden_apple>.addTooltip(format.gold(format.italic(game.localize("description.crt.tooltip.haste"))));
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
    .addTooltip(format.red(format.italic(game.localize("description.crt.slime.spawnerworkingcondition1"))));
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
    .addTooltip(format.yellow(format.italic(game.localize("description.crt.slime.spawnerworkingcondition2"))));
<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:slime"}})
    .addTooltip(format.green(format.italic(game.localize("description.crt.slime.spawnerworkingcondition3"))));