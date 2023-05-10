#loader crafttweaker reloadableevents
#norun
import scripts.LibReloadable as L;
import mods.thaumcraft.ArcaneWorkbench as AWB;
import thaumcraft.aspect.CTAspectStack;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import mods.thaumicwands.WandCaps;
import mods.thaumicwands.WandRods;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import mods.ctutils.utils.Math;

static RodCapacities as [int[string]]=[{}as int[string]];
function aspect6(aer as int, terra as int, ignis as int, aqua as int, ordo as int, perditio as int)as CTAspectStack[]{
    var stacks as CTAspectStack[]=[];
    if(aer>0)stacks+=<aspect:aer>*aer;
    if(terra>0)stacks+=<aspect:terra>*terra;
    if(ignis>0)stacks+=<aspect:ignis>*ignis;
    if(aqua>0)stacks+=<aspect:aqua>*aqua;
    if(ordo>0)stacks+=<aspect:ordo>*ordo;
    if(perditio>0)stacks+=<aspect:perditio>*perditio;
    return stacks;
}
function getVis(data as IData)as double{
    var vis=0.0;
    if(data has "tc.charge")vis+=data.memberGet("tc.charge")as int;
    if(data has "cvis")vis+=data.cvis as double;
    return vis;
}
function formVis(vis as double)as IData{
    var intp as int=vis as int;
    var cvis as double=vis-intp;
    return {"tc.charge":intp,"cvis":cvis}as IData;
}
function setVis(vis as double,dat as IData)as IData{
    return dat+formVis(vis);
}
function addVis(vis as double,dat as IData)as IData{
    return setVis(getVis(dat)+vis,dat);
}
static manaRods as double[string]={
    "livingwood":20.0,
    "dreamwood":80.0
};
static manaRates as double[string]={
    "manasteel":2000.0,
    "elementium":10000.0
};
static visRates as double[string]={
    "manasteel":0.02,
    "elementium":0.3
};
events.onPoolTrade(function(event as mods.randomtweaker.botania.PoolTradeEvent){
    var wand=event.input.item;
    if(wand.definition.id!=<thaumicwands:item_wand>.definition.id)return;
    event.cancel();
    if(!wand.hasTag)return;
    var capName as string=wand.tag.cap as string;
    if(manaRates has capName && visRates has capName){
        var manaRate as double=manaRates[capName]as double;
        var visRate as double=visRates[capName]as double;
        var rodName as string=wand.tag.rod as string;
        var capacity as double=10.0;
        if(manaRods has rodName){
            capacity=manaRods[rodName]as double;
        }
        else if(RodCapacities[0] has rodName){
            capacity=RodCapacities[0][rodName]as double;
        }
        if(getVis(wand.tag)<capacity && event.currentMana>0){
            var maxMana as double=event.currentMana as double;
            var maxVis as double=capacity-getVis(wand.tag);
            if(maxMana>manaRate)maxMana=manaRate;
            if(maxVis>visRate)maxVis=visRate;
            if(maxMana*visRate>maxVis*manaRate)maxMana=maxVis*manaRate/visRate;
            if(maxMana*visRate<maxVis*manaRate)maxVis=visRate*maxMana/manaRate;
            var w as IWorld=event.world;
            var p as IBlockPos=event.blockPos;
            var manaLeft=w.getBlock(p).data.mana as int;
            manaLeft=manaLeft-(0.9999+maxMana);
            w.setBlockState(w.getBlockState(p),w.getBlock(p).data+{"mana":manaLeft},p);
            event.input.item.mutable().withTag(addVis(maxVis,wand.tag));
        }
    }
});


zenClass craftData{ 
    var aspects as double[]=[];
    var vis as int;
    var item as IItemStack;
    zenConstructor(aspectIn as double[],visIn as int,itemIn as IItemStack){
        if(aspectIn.length>0)for a in aspectIn{aspects+=a;}
        while(aspects.length<6){aspects+=0.0;}
        vis=visIn;item=itemIn;
    }
    function combine(b as craftData)as craftData{
        var newA as double[]=[];
        for i in 0 to aspects.length{
            if(i<b.aspects.length)newA+=aspects[i]*b.aspects[i];
        }
        return craftData(newA,vis+b.vis,item);
    }
    function aspect6(aer as int, terra as int, ignis as int, aqua as int, ordo as int, perditio as int)as CTAspectStack[]{
        var stacks as CTAspectStack[]=[];
        if(aer>0)stacks+=<aspect:aer>*aer;
        if(terra>0)stacks+=<aspect:terra>*terra;
        if(ignis>0)stacks+=<aspect:ignis>*ignis;
        if(aqua>0)stacks+=<aspect:aqua>*aqua;
        if(ordo>0)stacks+=<aspect:ordo>*ordo;
        if(perditio>0)stacks+=<aspect:perditio>*perditio;
        return stacks;
    }
    function getAspects()as CTAspectStack[]{
        L.say((Math.tanh(aspects[0])*64.5)as int);
        return aspect6(
            ((Math.tanh(aspects[0])*64.5)as int),
            ((Math.tanh(aspects[1])*64.5)as int),
            ((Math.tanh(aspects[2])*64.5)as int),
            ((Math.tanh(aspects[3])*64.5)as int),
            ((Math.tanh(aspects[4])*64.5)as int),
            ((Math.tanh(aspects[5])*64.5)as int)
        );
    }
    function getVis()as int{return vis;}
    function getItem()as IItemStack{return item;}
}
static FS as string="FIRSTSTEPS";
static rodCraftCost as [craftData[string]]=[{}as craftData[string]];
static capCraftCost as [craftData[string]]=[{}as craftData[string]];
function RegRod(name as string, capacity as int,cd as craftData){
    WandRods.register(name,FS,capacity,<minecraft:stick>.withTag({"registeringTag":name}),0);
    RodCapacities[0][name]=capacity;
    rodCraftCost[0][name]=cd;
}
function RegCap(name as string, discount as float, aspect as CTAspectStack[],cd as craftData){
    WandCaps.register(name,FS,discount,aspect,<thaumicwands:item_wand_cap>.withTag({"registeringTag":name}),0);
    capCraftCost[0][name]=cd;
}
function endUp(){
    var n=0;
    for rodName,rodCC in rodCraftCost[0]{
        for capName,capCC in capCraftCost[0]{
            n=n+1;
            var CC as craftData=rodCC.combine(capCC);
            CC.getAspects();
        }
    }
}
AWB.registerShapedRecipe("Art_of_Enigma_WandCrafteeeee3","",0,[],<minecraft:stick>,[[null,null,<minecraft:stick>],[null,<contenttweaker:wand_cap_iron>,null],[<minecraft:stick>,null,null]]);
AWB.registerShapedRecipe("Art_of_Enigma_WandCrafteeeeeee",FS,0,[],<minecraft:stick>,[[null,null,<minecraft:stick>],[null,<contenttweaker:wand_rod_livingwood>,null],[<minecraft:stick>,null,null]]);
RegRod("wood",10,craftData([],0,<minecraft:stick>));
RegRod("livingwood",15,craftData([],1,<contenttweaker:wand_rod_livingwood>));
RegRod("dreamwood",50,craftData([],10,<contenttweaker:wand_rod_dreamwood>));
RegCap("iron",2.0,aspect6(1,1,1,1,1,1),craftData([],0,<contenttweaker:wand_cap_iron>));
RegCap("manasteel",2.0,aspect6(1,1,1,1,1,1),craftData([],1,<contenttweaker:wand_cap_manasteel>));
RegCap("elementium",2.0,aspect6(1,1,1,1,1,1),craftData([],10,<contenttweaker:wand_cap_elementium>));
endUp();