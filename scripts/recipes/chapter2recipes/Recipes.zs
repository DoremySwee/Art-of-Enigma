import scripts.recipes.libs.Transcript as T;
import scripts.recipes.libs.Mapping as Mp;
import scripts.recipes.libs.Misc as M;
import mods.botaniatweaks.Agglomeration as Agg;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;

//Chapter2 EIO & DE recipes are written in config.
//Deleting EIO recipes can only be done in its config.

//Preparation
recipes.remove(<appliedenergistics2:inscriber>);
recipes.remove(<tconstruct:smeltery_controller>);

//Start Chapter
if(true){
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
    Agg.addRecipe(<botania:terraplate>,[cc,<botania:terraplate>],3000,0x444444,0x111100,ccb,<minecraft:log>,st,co,cs,gr);
    Agg.addRecipe(<minecraft:gunpowder>,[cc],17000,0x444444,0x111100,cb,st,ccb,cb,cs,cb);
    Agg.addRecipe(<minecraft:gunpowder>*5,[cc*5],17000,0x444444,0x111100,ccb,cs,cb,cb,cs,cb);
    Agg.addRecipe(rs*5,[<botania:dye:14>*7,cb],10000,0x000000,0xAA2222,<minecraft:furnace>,co,<botania:flower:14>,gr,ro,<botania:flower:14>);

    var nr=<minecraft:netherrack>;
    var mm=<minecraft:magma>;
    var lvav=<liquid:lava>;
    Agg.addRecipe(<minecraft:string>*4,[<minecraft:gunpowder>,coal*2,rs*4],5000,0x804040,0xCC0000,
        <extrautils2:compressedgravel>,ro,<minecraft:redstone_torch>,nr,co,<minecraft:torch>);
    Agg.addRecipe(<minecraft:blaze_powder>,[rs,cc,<minecraft:flint>,<botania:spark>,<botania:specialflower>.withTag({type: "endoflame"})],
        13000,0xAA0000,0xFF9922,mm,nr,cb,lvav,mm,gr);
    Agg.addRecipe(<minecraft:blaze_powder>,[rs,cc,<minecraft:flint>,<botania:spark>,<botania:specialflower>.withTag({type: "endoflame"})],
        17000,0xCC2222,0xFFAA44,lvav,mm,nr,nr,lvav,mm);

    T.ae2.inscribe(nr,[cs,nr,nr],false);

    var FeOre=<minecraft:iron_ore>;
    Agg.addRecipe(gr,[<botania:livingrock>],10000,0xFF8800,0xCC6666,
        <extrautils2:compressedcobblestone:1>,lvav,<botania:petalblock>,FeOre,lvav,<botania:managlass>);
}
//Stage2: Smeltry
if(true){
    
    //seeds
    for i in vanilla.seeds.seeds {
        vanilla.seeds.removeSeed(i.stack as crafttweaker.item.IIngredient);
        vanilla.seeds.removeSeed(i.stack);
        //print("Item: " ~ i.stack.displayName ~ " || Chance: " ~ i.percent ~ "%");
    }
    vanilla.seeds.removeSeed(<minecraft:wheat_seeds>);
    for item in [<minecraft:carrot>,<minecraft:potato>,<minecraft:pumpkin_seeds>,<minecraft:melon_seeds>,<minecraft:wheat_seeds>,<minecraft:wheat_seeds>,<minecraft:melon_seeds>,<minecraft:beetroot_seeds>,<immersiveengineering:seed>]as IItemStack[]{
        vanilla.seeds.addSeed(item % 2);
    }
    vanilla.seeds.addSeed(<minecraft:wheat_seeds> % 1);

    //pumpkin
    M.dup(<minecraft:pumpkin>,false);
    recipes.addShapeless(<minecraft:pumpkin>, [<minecraft:wheat>,<minecraft:pumpkin_seeds>,<minecraft:dye:15>]);
    
    //rotten flesh
    var nr=<minecraft:netherrack>;
    for item in [<minecraft:fish>,<minecraft:fish:1>,<minecraft:beef>,<minecraft:mutton>,<minecraft:porkchop>,<minecraft:chicken>]as IItemStack[]{
        Agg.addRecipe(<minecraft:rotten_flesh>,[item],1,0x000033,0x330000,nr,nr,nr,nr,nr,nr);
    }

    //cocoon
    for num,item in {1:null,4:<minecraft:iron_ingot>,16:<ore:ingotElectrum>}as IIngredient[int]{
        recipes.addShaped(<botania:cocoon>*num,Mp.read("AAA;BCB;ADA;",{
            "A":<minecraft:string>, "B":<botania:manaresource:22>, "C":<botania:felpumpkin>, "D":item
        }));
    }

    //inscriber: grind stone into sand and gravel!
    T.ae2.inscribe(<minecraft:gravel>,[<minecraft:cobblestone>,<minecraft:iron_ingot>,<minecraft:iron_ingot>],false);
    T.ae2.inscribe(<minecraft:sand>,[<minecraft:gravel>,<minecraft:iron_ingot>,<minecraft:iron_ingot>],false);
    
    //Casting, Smeltry, and craftingTable
    var brick = <tconstruct:materials>;
    var slime = <minecraft:slime_ball>;
    mods.tconstruct.Casting.removeBasinRecipe(<tconstruct:seared>);
    mods.tconstruct.Casting.removeBasinRecipe(<tconstruct:seared:1>);
    recipes.remove(<tconstruct:seared:3>);
    recipes.addShaped(<tconstruct:seared:3>,Mp.read("A_A;_A_;A_A;",{"A":brick}));
    T.tic.casting(slime, <minecraft:dye:10>, <liquid:milk>*975, 1200);
    T.tic.casting(slime, <botania:dye:5>, <liquid:milk>*1753, 1200);
    recipes.addShaped(<minecraft:crafting_table>,Mp.read("LIL;BCB;LBL;",{
        "L":<minecraft:log>,"I":brick,"B":slime,"C":<botania:opencrate:1>
    }));
    
    var skull = <tconstruct:materials:50>.withTag({forSmeltry: true});
    var c1 = <tconstruct:seared_furnace_controller>;
    var c2 = <tconstruct:smeltery_controller>;
    recipes.remove(c1);
    recipes.remove(c2);
    recipes.addShaped(c2,Mp.read("III;FSF;III;",{"I":brick, "F":c1,"S":skull}));
    skull.displayName = game.localize("crt.smeltry_head.name");
    skull.addTooltip(game.localize("crt.smeltry_head.tip"));

    //orechid
    T.tic.casting(M.flower("thermalily"),M.flower("endoflame"),<liquid:obsidian>*514,1200);
    T.tic.casting(M.flower("orechid"),M.flower("thermalily"),<liquid:iron>*114,1200);
    T.ae2.inscribe(M.flower("hopperhock"),[M.flower("orechid"),<minecraft:hopper>,<minecraft:iron_ingot>]);
    T.ae2.inscribe(<botania:lens:18>,[<botania:lens:1>,<botania:pistonrelay>,<botania:pistonrelay>]);

    //some rediculous alloy
    T.tic.alloy(<liquid:xu_enchanted_metal>*39,[
            <liquid:bronze>*10,<liquid:constantan>*10,<liquid:alubrass>*10,
            <liquid:gold>*3,<liquid:silver>*3,<liquid:construction_alloy>*4,<liquid:obsidian>*3
    ]);
    T.tic.alloy(<liquid:xu_enchanted_metal>*195,[
            <liquid:bronze>*50,<liquid:constantan>*50,<liquid:alubrass>*50,
            <liquid:gold>*15,<liquid:silver>*15,<liquid:construction_alloy>*20,<liquid:obsidian>*15
    ]);

    //AE2
    for i in 11 to 14{
        var d = <appliedenergistics2:part>.definition;
        T.tic.casting(d.makeStack(i*20+1),d.makeStack(i*20),<liquid:water>,10);
    }
}

//Stage3: Immersive & Eggs
if(true){
    M.inscribeEgg(<entity:minecraft:chicken>,[<minecraft:egg>]);
    M.inscribeEgg(<entity:minecraft:sheep>,[<minecraft:wool>]);
    M.inscribeEgg(<entity:minecraft:skeleton>,[<minecraft:bone>]);
    M.inscribeEgg(<entity:minecraft:creeper>,[<minecraft:gunpowder>,<enderio:item_material:20>]);
    M.inscribeEgg(<entity:minecraft:zombie>,[<minecraft:rotten_flesh>]);

    for item in [<minecraft:coal>,<minecraft:coal:1>,<thermalfoundation:storage_resource>]as IItemStack[]{
        mods.immersiveengineering.BlastFurnace.removeFuel(item);
    }
    var t1 = <immersiveengineering:metal_decoration0:5>; //heavy engineering block
    recipes.remove(t1);
    recipes.addShaped(t1,Mp.read("ABA;CDC;ABA;",{
        "A":<ore:ingotSteel>,"B":<immersiveengineering:material:9>,
        "C":<minecraft:piston>,"D":<thermalfoundation:material:162>
    }));
    for i in [0,1,7]as int[]{
        mods.immersiveengineering.MetalPress.removeRecipeByMold(<immersiveengineering:mold>.definition.makeStack(i));
        recipes.remove(<immersiveengineering:wooden_device0:2>);
    }


    val gearGold = <thermalfoundation:material:25>;
    val gearSteel = <thermalfoundation:material:288>;
    val gearIron = <thermalfoundation:material:24>;
    val mold = <immersiveengineering:mold:1>;
    T.ie.press(gearIron, <minecraft:iron_ingot>*4, mold, 2000);
    T.ie.press(gearGold, <minecraft:gold_ingot>*4, mold, 700);
    T.ie.press(mold, gearSteel*4, <thermalfoundation:material:352>, 2000);
    Agg.addRecipe(gearGold*3,[<thermalfoundation:material:23>],40000,0xA04040,0xFFFF00,
        <extrautils2:simpledecorative>,<minecraft:gold_block>,<thermalfoundation:storage_alloy:2>,
        <minecraft:emerald_ore>,<minecraft:gold_ore>,<minecraft:iron_ore>
    );

    recipes.remove(<enderio:item_material:10>);
    recipes.remove(<enderio:item_material:9>);
    recipes.remove(<appliedenergistics2:material:40>);
    recipes.remove(<tconstruct:wooden_hopper>);
    recipes.addShaped(<tconstruct:wooden_hopper>,Mp.read("PIP;PCP;_P_;",{
        "P":<minecraft:planks>,"I":<minecraft:iron_ingot>,"C":<minecraft:chest>
    }));
    recipes.addShaped(<appliedenergistics2:material:40>,Mp.read("_S_;SDS;_S_;",{
        "S":<minecraft:stick>,"D":<enderio:item_material:20>
    }));
    Agg.addRecipe(gearSteel, [gearGold], 70000, 0xDDDD00, 0x888888,
        <tconstruct:wooden_hopper>,<immersiveengineering:sheetmetal:8>,<thermalfoundation:storage_alloy:2>,
        <minecraft:planks>,<minecraft:coal_ore>,<thermalfoundation:storage_alloy:2>
    );

    mods.tconstruct.Casting.removeTableRecipe(<tconstruct:cast_custom:4>);
    T.tic.casting(<tconstruct:cast_custom:4>,<thermalfoundation:material:264>,<liquid:gold>*1919,8000);
    recipes.remove(<minecraft:hopper>);
    recipes.addShaped(<minecraft:hopper>,Mp.read("IGI;ICI;_I_;",{
        "I":<minecraft:iron_ingot>,"G":gearIron,"C":<minecraft:chest>
    }));
    recipes.remove(<minecraft:flint_and_steel>);
    recipes.remove(<minecraft:fire_charge>);
    recipes.addShapeless(<minecraft:flint_and_steel>, [<minecraft:flint>,gearSteel]);
    recipes.remove(<immersiveengineering:blueprint>.withTag({blueprint: "molds"}));
    recipes.addShapeless(<botania:lens:15>,[<botania:lens>,<minecraft:flint_and_steel>]);

    recipes.addShaped(<minecraft:comparator>,Mp.read("_T_;TQT;SSS;",{
        "T":<minecraft:redstone_torch>,"Q":<appliedenergistics2:material:0>,"S":<ore:stone>
    }));
    recipes.remove(<botanicbonsai:bonsai_pot_manager>);
    recipes.addShaped(<botanicbonsai:bonsai_pot_manager>,Mp.read("SCS;EHE;PDP;",{
        "S":<botania:spreader>,"C":<storagedrawers:controller>,"E":<ore:ingotEnchantedMetal>,
        "H":<minecraft:hopper>,"P":<botania:pool>,"D":<botania:distributor>
    }));
}

//Stage4: TE + EIO
if(true){
    //TE & IE Machiens
    var t0 = <immersiveengineering:metal_device1:6>;
    var t1 = <ore:ingotEnchantedMetal>;
    var t2 = <thermalexpansion:machine:3>; //induction smelter
    var t3 = <botania:pool>;
    var t4 = <ore:ingotInvar>;
    var t5 = <ore:ingotElectrum>;
    var t6 = <botania:rfgenerator>;
    var t7 = <ore:record>;
    var t8 = <immersiveengineering:metal:38>; //Steel Plate
    recipes.remove(t0);
    recipes.addShaped(t2,Mp.read("DiD;FCF;IPI",{
        "D":t7, "i":t4, "F":<minecraft:furnace>,"C":t6,"I":t1,"P":t3
    }));
    recipes.addShaped(t0,Mp.read("PEP;_G_;PEP",{
        "P":t8,"E":t5,"G":<thermalfoundation:material:288>
    }));
    recipes.addShaped(<thermalexpansion:machine:8>,Mp.read("EBE;iMi;IPI",{
        "E":t5,"B":M.bucket("biodiesel"),
        "i":t4,"M":t2,"I":t1,"P":t3
    }));

    //Smelter-Steel Ban
    var l0 = [<thermalfoundation:material>,<minecraft:iron_ingot>] as IItemStack[];
    var l1 = [<thermalfoundation:material:768>,<thermalfoundation:material:769>,<thermalfoundation:material:802>] as IItemStack[];
    for i in l0{
        for j in l1{
            mods.thermalexpansion.InductionSmelter.removeRecipe(i,j);
        }
    }
    recipes.remove(<thermalfoundation:storage_resource>);
    recipes.remove(<minecraft:gunpowder>);

    //Tech tree
    // SAG -> Coal Dust -> Liquid Coal in_ Tic
    // torch = 1mb molten charged glowstone
    // Coal Dust -> EnderSmelter -> Energitic
    // molten_glass=xx+xx+xx+xx  or  post liquidXP: Blazing Pyrotheum (temp) glass->molten
    // molten_glass*37 + liquidCoal*73 + moltenClay*29 + moltenDirt*43 + moltenEnergitic*7 -> moltenSoularium*189
    // Soularium+Energitic+etc.=>LiquidXP

    recipes.addShaped(<enderio:block_simple_sag_mill>,Mp.read("IGI;FPF;EpE;",{
        "I":t1,"G":<thermalfoundation:material:288>,"F":<minecraft:flint>,
        "P":t3,"E":t5,"p":<minecraft:piston>
    }));
    recipes.addShapeless(<minecraft:glowstone_dust>,[<enderio:block_holier_fog>]);
    var coalDust = <thermalfoundation:material:768>;
    mods.immersiveengineering.Crusher.removeRecipe(coalDust);
    mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:coal>);
    mods.thermalexpansion.Pulverizer.removeRecipe(<minecraft:coal_ore>);
    T.tic.melting(<liquid:coal>*144, coalDust, 0);
    T.tic.melting(<liquid:glowstone> * 1, <minecraft:torch>, 0);

    recipes.addShaped(<enderio:block_simple_alloy_smelter>,Mp.read("DMD;MPM;ICi;",{
        "D":<enderio:item_material:38>,"M":t2,"P":t3,"I":t4,"i":t5,"C":t6
    }));
    mods.tconstruct.Melting.removeRecipe(<liquid:glass>);
    T.tic.alloy(<liquid:glass>*21,[<liquid:copper>*1,<liquid:gold>*2,
        <liquid:silver>*3,<liquid:platinum>*4,<liquid:xu_enchanted_metal>*5,<liquid:clay>*6]);
    T.tic.alloy(<liquid:soularium>*189,[<liquid:glass>*37,<liquid:coal>*73,
        <liquid:clay>*29,<liquid:dirt>*43,<liquid:energetic_alloy>*7]);

    var xpRod = <enderio:item_xp_transfer>;
    recipes.remove(<enderio:block_xp_vacuum>);
    recipes.remove(<enderio:block_experience_obelisk>);
    recipes.remove(xpRod);
    T.tic.casting(xpRod,
        <tconstruct:tough_tool_rod>.withTag({Material: "soularium"}),
        <liquid:xu_enchanted_metal>*1024,1200);
    recipes.addShaped(<enderio:block_experience_obelisk>,Mp.read("_R_;ITI;BPB;",{
        "R":xpRod,"I":t1,"T":<enderio:block_tank>,"B":<enderio:block_alloy:7>,"P":t3
    }));

    //Tech tree
    //The Vat & Fractionating Still
    //Craft of Mushroom soop should be ban.
    //It should come from the Mooshroom (0.95% from Cocoon of Caprice).
    //Without the Mooshroom AE2 can be fully unlocked, as well as the mana production.
    //But Chapter3 cannot be reached.
    //After Fractionating Still
    //Naphtha + Refined Fuel can be obtained

    //Pulped Biomass = Cast(Sawdust, SeedOil*68)
    //Rich Biomass = Cast(Pulped Biomass, Tree Oil)
    //Pulped Bioblend = Cast(Rich Biomass, syrup)
    //Rich Bioblend*8 = Pulped Bioblend*8 + Rosin
    //Rich Bioblend -> Tic Biocrude
    //Dark Steel = Tar + Soularium + Obsidian

    //Post the Vat
    //Biocrude in_ the place of water, obtain Hootch
    //Hootch + Refined Feul + Seed Oil + Energitic -> Rocket Feul
    recipes.remove(<minecraft:mushroom_stew>);
    recipes.addShaped(<thermalexpansion:machine:7>,Mp.read("GDG;IBI;iPi;",{
        "I":t1,"i":t4,"P":t3,"D":t7,"B":<minecraft:bucket>,"G":<thermalfoundation:glass_alloy:3>
    }));
    var l2 = [] as IItemStack[];
    for i in 816 to 820{
        var t = <thermalfoundation:material>.definition.makeStack(i);
        recipes.remove(t);
        l2+=t;
    }
    recipes.remove(<thermalfoundation:fertilizer>);
    recipes.remove(<thermalfoundation:fertilizer:1>);
    mods.thermalexpansion.Transposer.removeFillRecipe(<thermalfoundation:material:816>, <liquid:plantoil>);
    mods.thermalexpansion.Transposer.removeFillRecipe(<thermalfoundation:material:816>, <liquid:seed_oil>);
    var woodDust = <thermalfoundation:material:800>;
    T.ie.crush(woodDust*8,<ore:logWood>,4000);
    T.tic.casting(l2[0],woodDust,<liquid:seed_oil>*68);
    T.tic.casting(l2[1],l2[0],<liquid:tree_oil>*68);
    T.tic.casting(l2[2],l2[1],<liquid:syrup>*68);
    T.tic.melting(<liquid:resin>*144,<ore:logWood>, 0);
    recipes.addShaped(l2[3]*8,Mp.read("AAA;ABA;AAA;",{
        "A":l2[2],"B":<thermalfoundation:material:832>
    }));
    mods.thermalexpansion.Transposer.removeFillRecipe(l2[2],<liquid:seed_oil>);
    mods.thermalexpansion.Transposer.removeFillRecipe(l2[2],<liquid:plantoil>);
    T.tic.melting(<liquid:biocrude>*111,l2[3], 0);
    mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:96>, <thermalfoundation:material:770>);
    mods.thermalexpansion.InductionSmelter.removeRecipe(<thermalfoundation:material:160>, <thermalfoundation:material:770>);
    var vat = <enderio:block_vat>;
    recipes.remove(vat);
    recipes.remove(<enderio:item_basic_capacitor:1>);
    recipes.addShaped(vat,Mp.read("SCS;TMT;IPI;",{
        "S":<ore:ingotDarkSteel>,"C":<minecraft:cauldron>,"T":<enderio:block_tank>,
        "M":<thermalexpansion:machine:8>,"I":t1,"P":t3
    }));
    T.ie.mix(<liquid:potion>.withTag({Potion:"minecraft:awkward"})*300, 
        [<minecraft:cooked_mutton>, <minecraft:fish>], <liquid:water>*300, 2048);
    T.tic.alloy(<liquid:rocket_fuel>*240,[<liquid:hootch>*71,<liquid:refined_fuel>*131,
        <liquid:potion>.withTag({Potion:"extrautils2:xu2.greek.fire"})*74,<liquid:seed_oil>*31,<liquid:energetic_alloy>*7]);
}

//Stage5: EndChapter
if(true){
    mods.tconstruct.Melting.removeRecipe(<liquid:redstone>);
    mods.tconstruct.Melting.removeRecipe(<liquid:emerald>);

    T.tic.alloy(<liquid:pyrotheum>*2500,[<liquid:xpjuice>*200,<liquid:rocket_fuel>*1000]);
    T.tic.melting(<liquid:redstone>*144,<minecraft:redstone>,
        (<liquid:lava>.temperature+<liquid:pyrotheum>.temperature)/2);
    T.tic.alloy(<liquid:redstone_alloy>*144,[<liquid:iron>*81,<liquid:redstone>*514,<liquid:energetic_alloy>*114]);
    T.tic.alloy(<liquid:conductive_iron>*1000,[<liquid:iron>*1000,<liquid:redstone>*144]);
    T.tic.alloy(<liquid:petrotheum>*314,[<liquid:dark_steel>*114,<liquid:construction_alloy>*86,<liquid:xpjuice>*512,<liquid:lava>*114]);
    
    T.bot.rune(<appliedenergistics2:material:7>,Mp.read("QBBBBabcde;",{
        "Q":<appliedenergistics2:material>, "B":<minecraft:enchanted_book>,
        "a":M.bucket("xpjuice"), "b":M.bucket("petrotheum"), "c":M.bucket("redstone_alloy"),
        "d":M.bucket("platinum"), "e":M.bucket("glass")
    })[0],114514);
    M.dupMana(<appliedenergistics2:material:7>);

    T.bot.rune(M.bucket("aerotheum"),[
        <minecraft:sand>,M.bucket("syrup"),<minecraft:leaves>,M.bucket("resin"),
        <enderio:item_alloy_nugget:1>,M.bucket("glowstone"),
        <minecraft:record_far>,M.bucket("mushroom_stew")
    ],10086);
    for i in 1024 to 1028{
        recipes.remove(<thermalfoundation:material>.definition.makeStack(i));
    }
    for item in [<minecraft:snowball>, <thermalfoundation:material:772>, <thermalfoundation:material:770>]as IItemStack[]{
        for liquid in [<liquid:xpjuice>, <liquid:experience>]as ILiquidStack[]{
            mods.thermalexpansion.Transposer.removeFillRecipe(item,liquid);
        }
    }
    T.te.fill(<thermalfoundation:material:2049>, <minecraft:snowball>, <liquid:xpjuice> * 1, 20);
    T.tic.melting(<liquid:cryotheum>*1,<thermalfoundation:material:2049>, 0);

    
    var wools = [] as IIngredient[];
    for i in 0 to 16{
        wools+=<minecraft:wool>.definition.makeStack(i);
    }
    T.bot.rune(M.flower("spectrolus"),wools,2000);
    T.bot.rune(M.bucket("mana"),[
        <enderio:block_alloy:3>,<enderio:block_alloy:4>,<enderio:block_alloy:6>,
        <thermalfoundation:storage:6>, <thermalfoundation:storage:1>,
        M.bucket("xpjuice"),M.bucket("pyrotheum"),M.bucket("petrotheum"),
        M.bucket("aerotheum"),M.bucket("cryotheum"),M.flower("spectrolus")
    ],1919810);
}

//Fixes
if(true){
    mods.botania.Orechid.removeOre(<ore:oreMithril>);
    M.dup(M.flower("clayconia"),false);
    recipes.addShapeless(M.flower("clayconia")*2,[M.flower("clayconia"),<appliedenergistics2:material:7>]);
    recipes.remove(<extrautils2:user>);
    recipes.remove(<extrautils2:miner>);
    recipes.remove(<extrautils2:scanner>);
    recipes.remove(<extrautils2:analogcrafter>);
    recipes.remove(<extrautils2:crafter>);
    recipes.remove(<extrautils2:playerchest>);
    recipes.addShapeless(M.flower("endoflame"),[M.flower("exoflame"),<minecraft:redstone_torch>]);
    recipes.addShapeless(M.flower("exoflame"),[M.flower("endoflame"),<minecraft:redstone_torch>]);
    mods.tconstruct.Fuel.registerFuel(<liquid:pyrotheum>, 1000);
    M.bucket("pyrotheum").addTooltip(game.localize("description.crt.tooltip.SmeltryF"));
    <minecraft:lava_bucket>.addTooltip(game.localize("description.crt.tooltip.SmeltryF"));
    T.bot.rune(M.flower("solegnolia"),[
        <botania:magnetring>,<minecraft:redstone_torch>,<botania:doubleflower1:4>,
        <minecraft:redstone>,<botania:manaresource>,<botania:manaresource:6>
    ],10086);
    recipes.addShaped(<extrautils2:redstonelantern>,Mp.read("RSR;ScS;RCR;",{
        "R":<minecraft:redstone>,"S":<minecraft:stone>,"c":<minecraft:coal>,"C":<minecraft:comparator>
    }));
    recipes.remove(<extrautils2:teleporter:1>);
    recipes.addShapeless(<botania:lens:1>,[<botania:lens>,<minecraft:sugar>]);
    recipes.addShapeless(<botania:lens:2>,[<botania:lens>,<botania:manaresource:2>]);
    recipes.addShapeless(<botania:lens:3>,[<botania:lens>,<extrautils2:decorativeglass:5>]);
    recipes.addShapeless(<botania:lens:4>,[<botania:lens>,<thermalfoundation:material:136>]);
}
//Some unused designs
if(true){
    //Explosion ban
    recipes.remove(<appliedenergistics2:tiny_tnt>);
    recipes.remove(<minecraft:tnt>);
    recipes.remove(<tconstruct:throwball:1>);
}

//Fix:
mods.appliedenergistics2.Inscriber.addRecipe(<minecraft:bone>,<minecraft:dye:15>,false,<minecraft:dye:15>,<minecraft:dye:15>);