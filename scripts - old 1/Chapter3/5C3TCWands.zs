import mods.thaumcraft.ArcaneWorkbench as AWB;
import thaumcraft.aspect.CTAspectStack;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import mods.thaumicwands.WandCaps;
import mods.thaumicwands.WandRods;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import mods.ctutils.utils.Math;
import scripts.Lib;


mods.jei.JEI.removeAndHide(<thaumicwands:item_wand_cap>);
recipes.remove(<thaumicwands:item_wand>);
for i in [1,2,3,5,7]as int[]{
    AWB.removeRecipe(<thaumicwands:item_wand_cap>.definition.makeStack(i));
    mods.jei.JEI.removeAndHide(<thaumicwands:item_wand_cap>.definition.makeStack(i));
}
for i in [0,1,2,4,6,8]as int[]{
    WandCaps.remove(<thaumicwands:item_wand_cap>.definition.makeStack(i));
    mods.jei.JEI.removeAndHide(<thaumicwands:item_wand_cap>.definition.makeStack(i));
}
for i in 0 to 8{
    WandRods.remove(<thaumicwands:item_wand_rod>.definition.makeStack(i));
    AWB.removeRecipe(<thaumicwands:item_wand_rod>.definition.makeStack(i));
    mods.jei.JEI.removeAndHide(<thaumicwands:item_wand_rod>.definition.makeStack(i));
}
WandRods.remove(<minecraft:stick>);
/*
String name, String research, float discount,@Optional AspectArray crystalDiscount, ItemStack item, int craftcost
WandCaps.register("diamond","FIRSTSTEPS", 2, [<aspect:aer>*2], <minecraft:diamond>,7);

String name, String research, int capacity, ItemStack item, int craftCost
WandRods.register("beet", "FIRSTSTEPS", 10, <minecraft:beetroot>, 5);

Naming: item.wand. [name] .cap/rod
*/
static RodCapacities as int[string]={};
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
        else if(RodCapacities has rodName){
            capacity=RodCapacities[rodName]as double;
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
    function getAspects()as CTAspectStack[]{
        return Lib.aspect6(
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
zenClass capData{
    var aspects as CTAspectStack[]=[];
    var vis as float;
    zenConstructor(aspectIn as CTAspectStack[],visIn as float){
        if(aspectIn.length>0){
            for a in aspectIn{
                aspects+=a;
            }
        }
        vis=visIn;
    }
    function getVis()as float{return vis;}
    function getAspects()as CTAspectStack[]{return aspects;}
    function getAspectAmount(n as int)as int{
        var name as string[]=["aer","terra","ignis","aqua","ordo","perditio"];
        for a in aspects{
            if(a.internal.name==name[n])return a.amount;
        }
        return 0;
    }
}
static capDiscounts as capData[string]={}; 
function RegRod(name as string, capacity as int,cd as craftData){
    WandRods.register(name,FS,capacity,<minecraft:stick>.withTag({"registeringTag":name}),0);
    RodCapacities[name]=capacity;
    rodCraftCost[0][name]=cd;
}
function RegCap(name as string, discount as float, aspect as CTAspectStack[],cd as craftData){
    WandCaps.register(name,FS,discount,aspect,<thaumicwands:item_wand_cap>.withTag({"registeringTag":name}),0);
    capDiscounts[name]=capData(aspect,discount);
    capCraftCost[0][name]=cd;
}
function endUp(){
    var n=0;
    for rodName,rodCC in rodCraftCost[0]{
        for capName,capCC in capCraftCost[0]{
            n=n+1;
            var CC as craftData=rodCC.combine(capCC);
            if(CC.getVis()<1){
                recipes.addShaped(<thaumicwands:item_wand>.withTag({"cap": capName, "rod": rodName}),
                [[null,null,capCC.getItem()],[null,rodCC.getItem(),null],[capCC.getItem(),null,null]]);
            }
            AWB.registerShapedRecipe("Art_of_Enigma_WandCraft"~n,FS,
                CC.getVis(),CC.getAspects(),
                <thaumicwands:item_wand>.withTag({"cap": capName, "rod": rodName}),
                [[null,null,capCC.getItem()],[null,rodCC.getItem(),null],[capCC.getItem(),null,null]]
            );
        }
    }
}
<thaumicwands:item_wand>.clearTooltip(true);
//Show the vis inside
<thaumicwands:item_wand>.addAdvancedTooltip(function(item as IItemStack){
    if(!item.hasTag)return "";
    if(!(item.tag has "rod"))return "";
    var vis as double=(0.0+(0+getVis(item.tag)*100))/100;
    var rodName as string=item.tag.rod as string;
    var cap as int=(RodCapacities has rodName)?(RodCapacities[rodName]as int):10;
    var p as string="";
    if(0+vis>cap)p="§r§o§d";
    else if(vis>0.75*cap)p="§r§o§9";
    else if(vis>0.50*cap)p="§r§o§b";
    else if(vis>0.30*cap)p="§r§o§a";
    else if(vis>0.15*cap)p="§r§o§e";
    else if(vis>0.99)p="§r§o§c";
    else p="§r§o§4";
    return p~vis~"/"~cap~".00";
});
//Show discounts
<thaumicwands:item_wand>.addAdvancedTooltip(function(item as IItemStack){
    if(!item.hasTag)return "";
    if(!(item.tag has "cap"))return "";
    var cap as string=item.tag.cap as string;
    var dis as capData=(capDiscounts has cap)?(capDiscounts[cap]):(capData([],0.0f));
    return "§r§d§k**§r§d * "~(100*dis.getVis())~"%"~"       "~
        "§r§o§e-"~dis.getAspectAmount(0)~"  "~
        "§r§o§2-"~dis.getAspectAmount(1)~"  "~
        "§r§o§c-"~dis.getAspectAmount(2)~"  "~
        "§r§o§b-"~dis.getAspectAmount(3)~"  "~
        "§r§o§f-"~dis.getAspectAmount(4)~"  "~
        "§r§o§7-"~dis.getAspectAmount(5);
});
for rodName,cap2 in manaRods{
    for capName,aaaa in manaRates{
        <thaumicwands:item_wand>.withTag({"rod":rodName,"cap":capName}).addAdvancedTooltip(function(item as IItemStack){
            return "§r"~game.localize("descrption.crt.wand.manarod")~"§d "~cap2~" vis§r !";
        });
    }
}



RegRod("wood",10,craftData([],0,<minecraft:stick>));
RegRod("livingwood",12,craftData([],3,<contenttweaker:wand_rod_livingwood>));
RegRod("dreamwood",50,craftData([],10,<contenttweaker:wand_rod_dreamwood>));
RegCap("iron",3.0,Lib.aspect6(1,1,1,1,1,1),craftData([],0,<contenttweaker:wand_cap_iron>));
RegCap("manasteel",2.0,Lib.aspect6(1,1,1,1,1,1),craftData([],5,<contenttweaker:wand_cap_manasteel>));
RegCap("elementium",2.0,Lib.aspect6(1,1,1,1,1,1),craftData([],10,<contenttweaker:wand_cap_elementium>));
endUp();
/**/