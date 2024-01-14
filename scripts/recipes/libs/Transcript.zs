#reloadable
#priority 100000010
import crafttweaker.item.IWeightedIngredient as WIn;
import crafttweaker.item.WeightedItemStack as WI;
import crafttweaker.liquid.ILiquidStack as IL;
import crafttweaker.item.IIngredient as In;
import crafttweaker.item.IItemStack as It;
import thaumcraft.aspect.CTAspectStack as ASt;
import scripts.advanced.libs.Vector3D as V;
import crafttweaker.data.IData;
function test(){
    print("test");
}
//Parameters:
//output, (liquid output), input, (liquid input), datas: [energy, time, consumeCast=true, xp, modes, else]
//output>input, main product>side product(optional/chanced), item>liquid

//these words work as method name, as long as the machine is for these usage:
//alloy, grind, infusion, shaped, shapeless
//If one word is clear for the machine/altar, then we prefer not to use full name for the recipe adding

//How to use?
//call the uncapitalized static variables, and then their methods.
    //e.g.
    //import scripts.recipes.libs.Transcript as T;
    //T.tic.casting(...);

zenClass Ava{
    zenConstructor(){}
    static avaritiaRecipeNum as int[]=[0]as int[];
    function shaped(output as It, inputs as In[][])as void{
        mods.avaritia.ExtremeCrafting.addShaped(
            "Art_of_Enigma_AvaRecipe_"~avaritiaRecipeNum[0],
            output, inputs
        );
        avaritiaRecipeNum[0]=avaritiaRecipeNum[0]+1;
    }
    function shapeless(output as It, inputs as In[])as void{
        mods.avaritia.ExtremeCrafting.addShapeless(
            "Art_of_Enigma_AvaRecipe_"~avaritiaRecipeNum[0],
            output, inputs
        );
        avaritiaRecipeNum[0]=avaritiaRecipeNum[0]+1;
    }
    function compress(output as It, inputs as In)as void{
        mods.avaritia.Compressor.add("Art_of_Enigma_AvaRecipe_"~avaritiaRecipeNum[0],
            output, inputs.amount, inputs*1);
    }
}
static ava as Ava = Ava();
zenClass Bot{
    zenConstructor(){}
    function runeAltar(output as It, inputs as In[], mana as int)as void{
        mods.botania.RuneAltar.addRecipe(output, inputs, mana);
    }
    function rune(output as It, inputs as In[], mana as int)as void{
        mods.botania.RuneAltar.addRecipe(output, inputs, mana);
    }
    function altar(output as It, inputs as In[], mana as int)as void{
        mods.botania.RuneAltar.addRecipe(output, inputs, mana);
    }
    function elvenTrade(outputs as It[], inputs as In[])as void{
        mods.botania.ElvenTrade.addRecipe(outputs, inputs);
    }
    function elven(outputs as It[], inputs as In[])as void{
        mods.botania.ElvenTrade.addRecipe(outputs, inputs);
    }
    function trade(outputs as It[], inputs as In[])as void{
        mods.botania.ElvenTrade.addRecipe(outputs, inputs);
    }
    function manaInfusion (output as It, input as In, mana as int, mode as string = "infusion")as void{
        var t = mode.length>0 ? mode[0] : "i";
        if( t=="a" || t=="A" ) mods.botania.ManaInfusion.addAlchemy(output, input, mana);
        else if( t=="c" || t=="C" ) mods.botania.ManaInfusion.addConjuration(output, input, mana);
        else mods.botania.ManaInfusion.addInfusion(output, input, mana);
    }
    function infusion (output as It, input as In, mana as int, mode as string = "infusion")as void{
        manaInfusion(output,input,mana,mode);
    }
    function mana (output as It, input as In, mana as int, mode as string = "infusion")as void{
        manaInfusion(output,input,mana,mode);
    }
    function pureDaisy (output as It, input as In, time as int = 60)as void{
        mods.botania.PureDaisy.addRecipe(input, output, time);
    }
    function daisy (output as It, input as In, time as int = 60)as void{
        mods.botania.PureDaisy.addRecipe(input, output, time);
    }
    //Agglomeration is quite complicated. It's suggested to be direcly imported.
}
static bot as Bot = Bot();
zenClass TiC{
    zenConstructor(){}
    function casting(output as It, input as In, fluid as IL, time as int = 40, consumeCast as bool = true, basin as bool = false){
        if(basin) mods.tconstruct.Casting.addBasinRecipe(output, input, fluid, fluid.amount, consumeCast, time);
        else mods.tconstruct.Casting.addTableRecipe(output, input, fluid, fluid.amount, consumeCast, time);
    }
    function melting(output as IL, input as In, temperature as int = <liquid:lava>.temperature){
        mods.tconstruct.Melting.addRecipe(output, input, temperature);
    }
    function alloying(output as IL, inputs as IL[]){
        mods.tconstruct.Alloy.addRecipe(output, inputs);
    }
    function melt(output as IL, input as In, temperature as int = <liquid:lava>.temperature){
        mods.tconstruct.Melting.addRecipe(output, input, temperature);
    }
    function alloy(output as IL, inputs as IL[]){
        mods.tconstruct.Alloy.addRecipe(output, inputs);
    }
}
static tic as TiC = TiC();
zenClass TE{
    zenConstructor(){}
    function alloy(output as It, input1 as It, input2 as It){
        mods.thermalexpansion.InductionSmelter.addRecipe(output,input1,input2,2000);
    }
    function alloy(output as It, input1 as It, input2 as It, energy as int){
        mods.thermalexpansion.InductionSmelter.addRecipe(output,input1,input2,energy);
    }
    function alloy(output as It, output2 as WI, input1 as It, input2 as It, energy as int){
        mods.thermalexpansion.InductionSmelter.addRecipe(output,input1,input2,energy,output2.stack,output2.chance*100 as int);
    }
    function compact(output as It, input as It, energy as int = 2000, mode as string = "Plate"){
        var f = 0;
        if(mode.length>1){
            var c = mode[0];
            if(["M","m","C","c"] as string[] has c) f = 1;
            if(c=="G" || c=="g") f = 2;
        }
        if(f==0)
            mods.thermalexpansion.Compactor.addPressRecipe(output,input,energy);
        if(f==1)
            mods.thermalexpansion.Compactor.addMintRecipe(output,input,energy);
        if(f==2)
            mods.thermalexpansion.Compactor.addGearRecipe(output,input,energy);
    }
    function compress(output as It, input as It, energy as int = 2000, mode as string = "Plate"){
        compact(output, input, energy, mode);
    }
    function grind(output as It, input as It){
        mods.thermalexpansion.Pulverizer.addRecipe(output, input, 2000);
    }
    function grind(output as It, input as It, energy as int){
        mods.thermalexpansion.Pulverizer.addRecipe(output, input, energy);
    }
    function grind(output as It, output2 as WI, input as It, energy as int = 2000){
        mods.thermalexpansion.Pulverizer.addRecipe(output, input, energy, output2.stack, output2.chance*100 as int);
    }
    function sawmill(output as It, input as It){
        mods.thermalexpansion.Sawmill.addRecipe(output, input, 2000);
    }
    function sawmill(output as It, input as It, energy as int){
        mods.thermalexpansion.Sawmill.addRecipe(output, input, energy);
    }
    function sawmill(output as It, output2 as WI, input as It, energy as int = 2000){
        mods.thermalexpansion.Sawmill.addRecipe(output, input, energy, output2.stack, output2.chance*100 as int);
    }

    function melting(output as IL, input as It, energy as int = 2000){
        mods.thermalexpansion.Crucible.addRecipe(output,input,energy);
    }
    function magama(output as IL, input as It, energy as int = 2000){
        mods.thermalexpansion.Crucible.addRecipe(output,input,energy);
    }
    function crucible(output as IL, input as It, energy as int = 2000){
        mods.thermalexpansion.Crucible.addRecipe(output,input,energy);
    }
    function transpose(output as IL, input as It, energy as int = 2000){
        mods.thermalexpansion.Transposer.addExtractRecipe(output, input, energy);
    }
    function transpose(output as IL, output2 as WI, input as It, energy as int = 2000){
        mods.thermalexpansion.Transposer.addExtractRecipe(output, input, energy, output2);
    }
    /* There is some problem with this code. calling this method will be recognized as the former one
    function transpose(output as It, input as It, input2 as IL, energy as int = 2000){
        mods.thermalexpansion.Transposer.addFillRecipe(output, input, input2, energy);
    }*/
    function extract(output as IL, input as It, energy as int = 2000){
        mods.thermalexpansion.Transposer.addExtractRecipe(output, input, energy);
    }
    function extract(output as IL, output2 as WI, input as It, energy as int = 2000){
        mods.thermalexpansion.Transposer.addExtractRecipe(output, input, energy, output2);
    }
    function fill(output as It, input as It, input2 as IL, energy as int = 2000){
        mods.thermalexpansion.Transposer.addFillRecipe(output, input, input2, energy);
    }

    function fractioning(output as IL, input as IL, energy as int = 2000){
        mods.thermalexpansion.Refinery.addRecipe(output,null,input,energy);
    }
    function fractioning(output as IL, output2 as WI, input as IL, energy as int = 2000){
        mods.thermalexpansion.Refinery.addRecipe(output,output2,input,energy);
    }
    function refinery(output as IL, input as IL, energy as int = 2000){
        mods.thermalexpansion.Refinery.addRecipe(output,null,input,energy);
    }
    function refinery(output as IL, output2 as WI, input as IL, energy as int = 2000){
        mods.thermalexpansion.Refinery.addRecipe(output,output2,input,energy);
    }
    function refine(output as IL, input as IL, energy as int = 2000){
        mods.thermalexpansion.Refinery.addRecipe(output,null,input,energy);
    }
    function refine(output as IL, output2 as WI, input as IL, energy as int = 2000){
        mods.thermalexpansion.Refinery.addRecipe(output,output2,input,energy);
    }
}
static te as TE = TE();
zenClass IE{
    zenConstructor(){}
    function alloy(output as It, input as In, input2 as In, time as int = 1000){
        mods.immersiveengineering.AlloySmelter.addRecipe(output, input, input2, time);
    }
    function blast(output as It, input as In, time as int = 1000){
        mods.immersiveengineering.BlastFurnace.addRecipe(output, input, time);
    }
    function blast(output as It, output2 as It, input as In, time as int = 1000){
        mods.immersiveengineering.BlastFurnace.addRecipe(output, input, time, output2);
    }
    function coke(output as It, input as In, time as int = 1000, liquidAmount as int = 125){
        mods.immersiveengineering.CokeOven.addRecipe(output, liquidAmount, input, time);
    }

    function crush(output as It, input as In, energy as int = 1000){
        mods.immersiveengineering.Crusher.addRecipe(output, input, energy);
    }
    function crush(output as It, output2 as WI, input as In, energy as int = 1000){
        mods.immersiveengineering.Crusher.addRecipe(output, input, energy, output2.stack, output2.chance as double);
    }
    function crusher(output as It, input as In, energy as int = 1000){
        mods.immersiveengineering.Crusher.addRecipe(output, input, energy);
    }
    function crusher(output as It, output2 as WI, input as In, energy as int = 1000){
        mods.immersiveengineering.Crusher.addRecipe(output, input, energy, output2.stack, output2.chance as double);
    }
    function ferment(output as IL, input as In, energy as int){
        mods.immersiveengineering.Fermenter.addRecipe(null,output,input,energy);
    }
    function ferment(output as IL, output2 as It, input as In, energy as int){
        mods.immersiveengineering.Fermenter.addRecipe(output2,output,input,energy);
    }
    function fermenter(output as IL, input as In, energy as int){
        mods.immersiveengineering.Fermenter.addRecipe(null,output,input,energy);
    }
    function fermenter(output as IL, output2 as It, input as In, energy as int){
        mods.immersiveengineering.Fermenter.addRecipe(output2,output,input,energy);
    }
    function press(output as It, input as In, mold as It, energy as int = 1000){
        mods.immersiveengineering.MetalPress.addRecipe(output, input, mold, energy, input.amount);
    }
    function presser(output as It, input as In, mold as It, energy as int = 1000){
        mods.immersiveengineering.MetalPress.addRecipe(output, input, mold, energy, input.amount);
    }
    function mix(output as IL, inputs as In[], input as IL, energy as int = 1000){
        mods.immersiveengineering.Mixer.addRecipe(output, input, inputs, energy);
    }
    function mixer(output as IL, inputs as In[], input as IL, energy as int = 1000){
        mods.immersiveengineering.Mixer.addRecipe(output, input, inputs, energy);
    }
    function refine(output as IL, input as IL, input2 as IL, energy as int = 1000){
        mods.immersiveengineering.Refinery.addRecipe(output, input, input2, energy);
    }
    function refinery(output as IL, input as IL, input2 as IL, energy as int = 1000){
        mods.immersiveengineering.Refinery.addRecipe(output, input, input2, energy);
    }
    function squeez(output as IL, input as In, energy as int = 1000){
        mods.immersiveengineering.Squeezer.addRecipe(null, output, input, energy);
    }
    function squeez(output as IL, output2 as It, input as In, energy as int = 1000){
        mods.immersiveengineering.Squeezer.addRecipe(output2, output, input, energy);
    }
    function squeezer(output as IL, input as In, energy as int = 1000){
        mods.immersiveengineering.Squeezer.addRecipe(null, output, input, energy);
    }
    function squeezer(output as IL, output2 as It, input as In, energy as int = 1000){
        mods.immersiveengineering.Squeezer.addRecipe(output2, output, input, energy);
    }
}
static ie as IE = IE();
zenClass AE2{
    zenConstructor(){}
    function grind(output as It, input as It, turns as int = 8){
        mods.appliedenergistics2.Grinder.addRecipe(output, input, turns);
    }
    function grind(output as It, output2 as WI, input as It, turns as int = 8){
        mods.appliedenergistics2.Grinder.addRecipe(output, input, turns, output2.stack, output2.chance as float);
    }
    function grind(output as It, output2 as WI, output3 as WI, input as It, turns as int = 8){
        mods.appliedenergistics2.Grinder.addRecipe(output, input, turns, output2.stack, output2.chance as float, output3.stack, output3.chance as float);
    }
    function inscribe(output as It, inputs as It[], consume as bool = true){
        if(inputs.length==1) mods.appliedenergistics2.Inscriber.addRecipe(output, inputs[0], !consume);
        if(inputs.length==2) mods.appliedenergistics2.Inscriber.addRecipe(output, inputs[0], !consume, inputs[1]);
        if(inputs.length>2)  mods.appliedenergistics2.Inscriber.addRecipe(output, inputs[0], !consume, inputs[1], inputs[2]);
    }
}
static ae2 as AE2 = AE2();
static ae as AE2 = AE2();
zenClass DE{
    zenConstructor(){}
    function fuse(output as It, input as It, inputs as In[], energy as long, tier as int = 0){
        var tierReal = moretweaker.draconicevolution.FusionCrafting.BASIC as int;
        var map = {
            ""~1:moretweaker.draconicevolution.FusionCrafting.WYVERN,
            ""~2:moretweaker.draconicevolution.FusionCrafting.DRACONIC,
            ""~3:moretweaker.draconicevolution.FusionCrafting.CHAOTIC
        } as IData;
        tierReal = (map has (""~tier)) ? map.memberGet(""~tier).asInt() : tierReal;
        moretweaker.draconicevolution.FusionCrafting.add(output,input,tierReal,energy,inputs);
    }
    function fusion(output as It, input as It, inputs as In[], energy as long, tier as int = 0){
        fuse(output, input, inputs, energy, tier);
    }
}
static de as DE = DE();
zenClass EIO{
    //WARNING: Cannot delete recipe through enderTweaker. It must be done through config.
    zenConstructor(){}
    function alloy(output as It, inputs as In[], energy as int = 10000, xp as float =0.0f){
        mods.enderio.AlloySmelter.addRecipe(output, inputs, energy, xp);
    }
    function enchant(output as crafttweaker.enchantments.IEnchantmentDefinition, inputPerLevel as In, xpMultiplier as double=1.0){
        mods.enderio.Enchanter.addRecipe(output, inputPerLevel, inputPerLevel.amount, xpMultiplier);
    }
    function grind(outputs as WI[], input as In, energy as int = 2000, xp as float =0.0f,  bonusType as string = "CHANCE_ONLY"){
        var b = "CHANCE_ONLY";
        var t = bonusType.length>0 ? bonusType[0] : "n";
        if(t=="M" || t=="m")b="MULTIPLY_OUTPUT";
        if(t=="N" || t=="n")b="NONE";
        var chances as float[] = [] as float[];
        var stacks as It[] = [] as It[];
        for item in outputs{
            chances+= item.chance;
            stacks += item.stack;
        }
        mods.enderio.SagMill.addRecipe(stacks,chances,input,b,energy,[xp]);
    }
    function sag(outputs as WI[], input as In, energy as int = 2000, xp as float =0.0f,  bonusType as string = "CHANCE_ONLY"){
        grind(outputs,input,energy,xp,bonusType);
    }
    function SAG(outputs as WI[], input as In, energy as int = 2000, xp as float =0.0f,  bonusType as string = "CHANCE_ONLY"){
        grind(outputs,input,energy,xp,bonusType);
    }
    function skull(output as It, inputs as In[], energy as int = 5000, xp as float = 0.0f){
        mods.enderio.SliceNSplice.addRecipe(output,inputs,energy,xp);
    }
    function slice(output as It, inputs as In[], energy as int = 10000, xp as float = 0.0f){
        skull(output,inputs,energy,xp);
    }
    function sliceNSplice(output as It, inputs as In[], energy as int = 10000, xp as float = 0.0f){
        skull(output,inputs,energy,xp);
    }
    function soul(output as It, input as In, allowedEntities as crafttweaker.entity.IEntityDefinition[], xpInputLevel as int = 10, energy as int = 10000){
        var l = [] as string[];
        for e in allowedEntities{
            l+=e.id;
        }
        mods.enderio.SoulBinder.addRecipe(output, input, l, xpInputLevel, energy);
    }
    //Decription from enderTweaker wiki
    /*The Vat uses a system of multipliers to calculate output.
    This means each pair of inputs will use a different amount of input.
    The ratio of input -> output fluid is constant.
    The multipliers on the inputs determine how much input fluid is used.
    slot1Mult * slot2Mult * 1000mB of input is used per craft.
    The final output amount is calculated from inMult * slot1Mult * slot2Mult * 1000mB.
    The ratio of input to output fluid is equal to inMult.*/
    //Note that here we combine inputs1 and their mults together as a Weighted IIngredient.
    //The chances are allowde to exceed 100%
    function vat(output as IL, input as IL, fluidYield as float, inputs1WithMultipliers as WIn[], inputs2WithMultipliers as WIn[], energy as int = 3000){
        var I1 = [] as In[];
        var M1 = [] as float[];
        for item in inputs1WithMultipliers{
            I1 += item.ingredient;
            M1 += item.chance;
        }
        var I2 = [] as In[];
        var M2 = [] as float[];
        for item in inputs2WithMultipliers{
            I2 += item.ingredient;
            M2 += item.chance;
        }
        mods.enderio.Vat.addRecipe(output,fluidYield,input,I1,M1,I2,M2,energy);
    }
}
static eio as EIO = EIO();
zenClass BM{
    zenConstructor(){}
    function altar(output as It, input as It, amount as int, tier as int = 1, consumeRate as int = -1 as int, drainRate as int = -1 as int){
        var cr = consumeRate;
        var dr = drainRate;
        if(cr<0) cr = 1 + V.sqrt(amount as double)/3.0;
        if(dr<0) dr = 1 + 1.3*cr;
        mods.bloodmagic.BloodAltar.addRecipe(output, input, tier - 1, amount, cr, dr);
    }
    function forge(output as It, inputs as It[], minSoul as double = 10.0, drainSoul as double = -1.0){
        var ds = drainSoul;
        if(ds<0) ds = minSoul;
        mods.bloodmagic.TartaricForge.addRecipe(output, inputs, minSoul, ds);
    }
    function table(output as It, inputs as It[], amount as int, time as int, tier as int = 1){
        mods.bloodmagic.AlchemyTable.addRecipe(output, inputs, amount, time, tier - 1);
    }
}
static bm as BM = BM();
zenClass ExU{
    zenConstructor(){}
    function resonate(output as It, input as It, energy as int){
        mods.extrautils2.Resonator.add(output, input, energy);
    }
    function resonator(output as It, input as It, energy as int){
        mods.extrautils2.Resonator.add(output, input, energy);
    }
    function enchant(output as It, inputs as In[], energy as int, time as int){
        val enchanter as extrautilities2.Tweaker.IMachine = extrautilities2.Tweaker.IMachineRegistry.getMachine("extrautils2:enchanter");
        enchanter.addRecipe(
            {"input":inputs[0],"input_lapis":inputs[1]}, {"output":output}, energy, time
        );
    }
    function enchanter(output as It, inputs as In[], energy as int, time as int){
        enchant(output, inputs, energy, time);
    }
}
static exu as ExU = ExU();
zenClass CC{
    zenConstructor(){}
    function flawless(output as It, inputs as In[]){
        mods.calculator.flawless.addRecipe(inputs[0], inputs[1], inputs[2], inputs[3], output);
    }
    function atomic(output as It, inputs as In[]){
        mods.calculator.atomic.addRecipe(inputs[0], inputs[1], inputs[2], output);
    }
    function basic(output as It, inputs as In[]){
        mods.calculator.basic.addRecipe(inputs[0], inputs[1], output);
    }
    function scientific(output as It, inputs as In[]){
        mods.calculator.scientific.addRecipe(inputs[0], inputs[1], output);
    }
}
static cc as CC = CC();
zenClass TC{
    zenConstructor(){}
    static recipeNum as int[] = [0] as int[];
    static id as string= "ArtOfEngima_Auto_Generated_ThaumCraft_Id_";
    static research as string= "FIRSTSTEPS";
    function getId()as string{
        var ans = id~(recipeNum[0]);
        //print(ans);
        recipeNum[0] = recipeNum[0] + 1;
        return ans;
    }
    function shaped(output as It, inputs as In[][]){
        var aspects as ASt[] = [];
        mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(getId(),research,0,aspects,output,inputs);
    }
    function shaped(output as It, inputs as In[][], vis as int){
        var aspects as ASt[] = [];
        mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(getId(),research,vis,aspects,output,inputs);
    }
    function shaped(output as It, inputs as In[][], vis as int, aspects as ASt[]){
        mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(getId(),"FIRSTSTEPS",vis,aspects,output,inputs);
    }
    function shaped(output as It, inputs as In[][], vis as int, aspects as int[]){
        mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(getId(),"FIRSTSTEPS",vis,
            scripts.recipes.libs.Aspects.aspect6(aspects),
            output,inputs);
    }
    function shaped(output as It, inputs as In[][], vis as int, aspects as ASt[], research as string){
        mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(getId(),research,vis,aspects,output,inputs);
    }
    function shaped(output as It, inputs as In[][], vis as int, aspects as int[], research as string){
        mods.thaumcraft.ArcaneWorkbench.registerShapedRecipe(getId(),research,vis,
            scripts.recipes.libs.Aspects.aspect6(aspects),
            output,inputs);
    }
    function shapeless(output as It, inputs as In[], vis as int = 0){
        var aspects as ASt[] = [];
        mods.thaumcraft.ArcaneWorkbench.registerShapelessRecipe(getId(),research,vis,aspects,output,inputs);
    }
    function shapeless(output as It, inputs as In[], vis as int, aspects as ASt[], research as string = "FIRSTSTEPS"){
        mods.thaumcraft.ArcaneWorkbench.registerShapelessRecipe(getId(),research,vis,aspects,output,inputs);
    }
    function shapeless(output as It, inputs as In[], vis as int, aspects as int[], research as string = "FIRSTSTEPS"){
        mods.thaumcraft.ArcaneWorkbench.registerShapelessRecipe(getId(),research,vis,
            scripts.recipes.libs.Aspects.aspect6(aspects),
            output,inputs);
    }
    function crucible(output as It, input as In, aspects as ASt[] = [] as ASt[], research as string = "FIRSTSTEPS"){
        mods.thaumcraft.Crucible.registerRecipe(getId(),research,output, input, aspects);
    }
    function infusion(output as It, input as In, inputs as In[], aspects as ASt[], instability as int = 3, research as string = "FIRSTSTEPS"){
        mods.thaumcraft.Infusion.registerRecipe(getId(),research,output,instability,aspects,input,inputs);
    }
}
static tc as TC = TC();
zenClass Embers{
    zenConstructor(){}
    function melt(outputs as IL[], input as In){
        if(outputs.length==1)mods.embers.Melter.add(outputs[0], input);
        if(outputs.length>1)mods.embers.Melter.add(outputs[0],input,outputs[1]);
    }
    function melter(outputs as IL[], input as In){
        melt(outputs,input);
    }
    function melting(outputs as IL[], input as In){
        melt(outputs,input);
    }
    function stamp(output as It, liquidInput as IL, itemInputs as It[]){
        if(itemInputs.length==1)mods.embers.Stamper.add(output,liquidInput,itemInputs[0]);
        if(itemInputs.length>1)mods.embers.Stamper.add(output,liquidInput,itemInputs[0],itemInputs[1]);
    }
    function stamper(output as It, liquidInput as IL, itemInputs as It[]){
        stamp(output,liquidInput,itemInputs);
    }
    function stamping(output as It, liquidInput as IL, itemInputs as It[]){
        stamp(output,liquidInput,itemInputs);
    }
    //There can be 4 inputs, but JEI only shows 3
    function mix(output as IL, inputs as IL[]){
        mods.embers.Mixer.add(output, inputs);
    }
    function mixer(output as IL, inputs as IL[]){
        mods.embers.Mixer.add(output, inputs);
    }
    function mixing(output as IL, inputs as IL[]){
        mods.embers.Mixer.add(output, inputs);
    }

    function alchemy(output as It, inputs as In[]){
        //TODO
    }
    function anvil(){
        //TODO
    }
}
static embers as Embers = Embers();
static ember as Embers = Embers();
zenClass AS{
    zenConstructor(){}
    //TODO
}
static astralSocery as AS = AS();