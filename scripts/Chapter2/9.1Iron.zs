import mods.botaniatweaks.Agglomeration;
//explosion ban 
recipes.removeShaped(<appliedenergistics2:tiny_tnt>);
recipes.removeShaped(<minecraft:tnt>);
recipes.removeShapeless(<tconstruct:throwball:1>);

//device number limit
recipes.removeShaped(<appliedenergistics2:inscriber>);
recipes.removeShaped(<tconstruct:smeltery_controller>);

//Coal and Redstone
var gr=<minecraft:gravel>;
var sd=<minecraft:sand>;
var st=<minecraft:stone>;
var cs=<minecraft:cobblestone>;
var cc=<minecraft:coal:1>;
var ccb=<chisel:block_charcoal>;
var cb=<minecraft:coal_block>;
var coal=<minecraft:coal>;
var co=<minecraft:coal_ore>;
var ro=<minecraft:redstone_ore>;
var rs=<minecraft:redstone>;
Agglomeration.addRecipe(<botania:terraplate>,[cc,<botania:terraplate>],3000,0x444444,0x111100,ccb,<minecraft:log>,st,co,cs,gr);
Agglomeration.addRecipe(<minecraft:gunpowder>,[cc],17000,0x444444,0x111100,cb,st,ccb,cb,cs,cb);
Agglomeration.addRecipe(<minecraft:gunpowder>*5,[cc*5],17000,0x444444,0x111100,ccb,cs,cb,cb,cs,cb);
Agglomeration.addRecipe(rs*5,[<botania:dye:14>*7,cb],10000,0x000000,0xAA2222,<minecraft:furnace>,co,<botania:flower:14>,gr,ro,<botania:flower:14>);

//Nether lvav
var nr=<minecraft:netherrack>;
var mm=<minecraft:magma>;
var lvav=<liquid:lava>;
Agglomeration.addRecipe(<minecraft:string>*4,[<minecraft:gunpowder>,coal*2,rs*4],5000,0x804040,0xCC0000,
    <extrautils2:compressedgravel>,ro,<minecraft:redstone_torch>,nr,co,<minecraft:torch>);
Agglomeration.addRecipe(<minecraft:blaze_powder>,[rs,cc,<minecraft:flint>,<botania:spark>,<botania:specialflower>.withTag({type: "endoflame"})],
    13000,0xAA0000,0xFF9922,mm,nr,cb,lvav,mm,gr);
Agglomeration.addRecipe(<minecraft:blaze_powder>,[rs,cc,<minecraft:flint>,<botania:spark>,<botania:specialflower>.withTag({type: "endoflame"})],
    17000,0xCC2222,0xFFAA44,lvav,mm,nr,nr,lvav,mm);

//nr.addTooltip(format.red(format.italic(game.localize("description.crt.aggWithLava"))));
//mm.addTooltip(format.red(format.italic(game.localize("description.crt.aggWithLava"))));
//<minecraft:blaze_powder>.addTooltip(format.red(format.italic(game.localize("description.crt.aggWithLava"))));

//Nether-Dup
mods.appliedenergistics2.Inscriber.addRecipe(nr,cs,true,nr,nr);

//Iron
var FeOre=<minecraft:iron_ore>;
Agglomeration.addRecipe(gr,[<botania:livingrock>],10000,0xFF8800,0xCC6666,
    <extrautils2:compressedcobblestone:1>,lvav,<botania:petalblock>,FeOre,lvav,<botania:managlass>);
//FeOre.addTooltip(format.red(format.italic(game.localize("description.crt.aggWithLava"))));