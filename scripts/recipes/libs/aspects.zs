#loader crafttweaker reloadableevents
#priority 100000000
import thaumcraft.aspect.CTAspectStack;
import scripts.advanced.libs.Data as D;
import thaumcraft.aspect.CTAspect;
import crafttweaker.data.IData;

static elements6 as string[] = ["aer","terra","ignis","aqua","ordo","perditio"];

function aspect6Raw(aer as int, terra as int, ignis as int, aqua as int, ordo as int, perditio as int)as CTAspectStack[]{
    var stacks as CTAspectStack[]=[];
    if(aer>0)stacks+=<aspect:aer>*aer;
    if(terra>0)stacks+=<aspect:terra>*terra;
    if(ignis>0)stacks+=<aspect:ignis>*ignis;
    if(aqua>0)stacks+=<aspect:aqua>*aqua;
    if(ordo>0)stacks+=<aspect:ordo>*ordo;
    if(perditio>0)stacks+=<aspect:perditio>*perditio;
    return stacks;
}
function aspect6(b as int[])as CTAspectStack[]{
    var a as int[]=[];
    for i in b{a+=i;}
    while(a.length<6){a+=0;}
    return aspect6Raw(a[0],a[1],a[2],a[3],a[4],a[5]);
}
function aspects6(b as int[])as CTAspectStack[]{
    return aspect6(b);
}

function arrayToData(array as int[])as IData{
    var data = IData.createEmptyMutableDataMap();
    for i in 0 to 6{
        var t as int=0;
        if(i<array.length)t=array[i];
        data.memberSet(elements6[i],t as IData);
    }
    return data;
}
function dataToArray(data as IData)as int[]{
    var a as int[]=[0,0,0,0,0,0];
    if(isNull(data))return a;
    for i in 0 to 6{
        if(data has elements6[i])a[i]=data.memberGet(elements6[i]);
    }
    return a;
}
function fromData(data as IData)as CTAspectStack[]{
    return aspect6(dataToArray(data));
}
static listAspects as CTAspect[]= [
    <aspect:aer>.internal,
    <aspect:terra>.internal,
    <aspect:ignis>.internal,
    <aspect:aqua>.internal,
    <aspect:ordo>.internal,
    <aspect:perditio>.internal,
    <aspect:vacuos>.internal,
    <aspect:lux>.internal,
    <aspect:motus>.internal,
    <aspect:gelum>.internal,
    <aspect:vitreus>.internal,
    <aspect:metallum>.internal,
    <aspect:victus>.internal,
    <aspect:mortuus>.internal,
    <aspect:potentia>.internal,
    <aspect:permutatio>.internal,
    <aspect:praecantatio>.internal,
    <aspect:auram>.internal,
    <aspect:alkimia>.internal,
    <aspect:vitium>.internal,
    <aspect:tenebrae>.internal,
    <aspect:alienis>.internal,
    <aspect:volatus>.internal,
    <aspect:herba>.internal,
    <aspect:instrumentum>.internal,
    <aspect:fabrico>.internal,
    <aspect:machina>.internal,
    <aspect:vinculum>.internal,
    <aspect:spiritus>.internal,
    <aspect:cognitio>.internal,
    <aspect:sensus>.internal,
    <aspect:aversio>.internal,
    <aspect:praemunio>.internal,
    <aspect:desiderium>.internal,
    <aspect:exanimis>.internal,
    <aspect:bestia>.internal,
    <aspect:humanus>.internal
] as CTAspect[];
//TODO:
    //Get aspect of an IItemStack