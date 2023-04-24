#loader crafttweaker
#loader crafttweaker reloadableevents
#priority 101
import crafttweaker.world.IVector3d;
import crafttweaker.world.IBlockPos;
import crafttweaker.util.Position3f;
import mods.ctutils.utils.Math;

import scripts.Altars.L;
import scripts.Altars.L.V;
import mods.randomtweaker.botania.IBotaniaFXHelper;

import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;

import crafttweaker.events.IEventManager;

import mods.zenutils.IByteBuf;
import mods.zenutils.NetworkHandler;

val MAX_FX_1GT as int=3000;
/*
How to use?
    FX can be only directly registered on Client.
    FXSF can be registered on Server, it will be then sent to client sides.
*/

IBotaniaFXHelper.setWispFXDistanceLimit(false);
zenClass FX{
    var p as V;
    var v as V;
    var c as int;
    var s as double;
    var a as double;
    zenConstructor(p1 as V, v1 as V, c1 as int, s1 as double, a1 as double){
        p=p1;v=v1;c=c1;s=s1;a=a1;
    }
    zenConstructor(p1 as V, v1 as V, c1 as int, s1 as double){
        p=p1;v=v1;c=c1;s=s1;a=10;
    }
    zenConstructor(p1 as V, v1 as V, c1 as int){
        p=p1;v=v1;c=c1;s=0.3;a=10;
    }
    zenConstructor(p1 as V, v1 as V){
        p=p1;v=v1;c=0xFFFFFF;s=0.3;a=10;
    }
    zenConstructor(d as IData){
        p=L.V0;v=L.V0;c=0xFFFFFF;s=0.3;a=10;
        if(d has "p")p=V(d.p);
        if(d has "v")v=V(d.v);
        if(d has "c")c=d.c;
        if(d has "s")s=d.s;
        if(d has "a")a=d.a;
    }
    zenConstructor(){
        p=L.V0;v=L.V0;c=0xFFFFFF;s=0.3;a=10;
    }

    function toString()as string{
        return "Position:"~p.asString()~";   V:"~v.asString()~";   CSA:"~c~", "~s~", "~a;
    }
    function toData()as IData{
        return {
            "p": {"x":p.x, "y":p.y, "z":p.z},
            "v": {"x":v.x, "y":v.y, "z":v.z},
            "c": c, "s":s, "a":a
        } as IData;
    }
    function copy()as FX{
        return FX(toData());
    }
    function write(b as FX)as FX{
        p=b.p;v=b.v;c=b.c;s=b.s;a=b.a;
        return this;
    }
    function actualSpawnFunction()as FX{
        var cc as int=c;
        var r as double=1.0*(cc/65536)/255.0;
        var g as double=1.0*(cc/256%256)/255.0;
        var b as double=1.0*(cc%256)/255.0;
        //L.say(toString());
        IBotaniaFXHelper.wispFX(p.x,p.y,p.z,r,g,b,s,v.x,v.y,v.z,a);
        return this;
    }

    static RL0 as [FX]=[] as [FX];
    static RL1 as [FX]=[] as [FX];
    static RLI as int[]=[0,0] as int[];
    static IL as [FX]=[] as [FX];

    function regi(w as IWorld, immediate as bool)as void{
        if(!w.isRemote()){
            L.say("哪个burnBee在服务端生成粒子效果？粒子效果刷在服务端是看不见的不知道？");
            return;
        }
        if(immediate)IL+=copy();
        else if(RLI[0]==0)RL0+=copy();
        else RL1+=copy();
    }
    function regi(w as IWorld)as void{
        regi(w,false);
    }
}

events.onClientTick(function(event as crafttweaker.event.ClientTickEvent){
    var SpawnNum as int=0;
    if(FX.IL.length>0){
        for i in FX.IL{
            i.actualSpawnFunction();
            SpawnNum+=1;
        }
    }
    while(true){
        if(FX.RL0.length+FX.RL1.length<1)break;
        if(SpawnNum>MAX_FX_1GT)break;
        var List as [FX];
        if(FX.RLI[0]>0) List=FX.RL0;
        else List=FX.RL1;
        var j as int=0;
        for i in List{
            if(SpawnNum>MAX_FX_1GT)break;
            j+=1;
            if(j<FX.RLI[1])continue;
            i.actualSpawnFunction();
            SpawnNum+=1;
            FX.RLI[1]=FX.RLI[1]+1;
        }
        if(j==List.length){
            FX.RLI[0]=1-FX.RLI[0];
            FX.RLI[1]=0;
            if(FX.RLI[0]==0)FX.RL0=[] as [FX];
            if(FX.RLI[0]==1)FX.RL1=[] as [FX];
        }
    }
});
/**
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    var w as IWorld=event.world;
    if(!w.isRemote())return;
    for i in 0 to 100{
        FX(V(event.position).add(L.VX.scale(1.0*i/30)),L.V0).regi(w);
    }
});
/**/

//FX Modifying Function
zenClass FXMF{
    var f as function(FX,IData)FX;
    zenConstructor(f1 as function(FX,IData)FX){
        f=f1;
    }
    function run(a as FX,b as IData)as FX{
        return f(a,b);
    }
}
//FX Modifier
zenClass FXM{
    var f as FXMF;
    var para as IData;
    zenConstructor(f1 as FXMF, p as IData){
        f=f1;para=p;
    }
    function run(a as FX)as FX{
        return f.run(a,para);
    }
}
//Basic FXMFs
//d={x,y,z,a}as IData;
static shift as FXMF=FXMF(function(x as FX,d as IData)as FX{
    x.p=x.p.add(V(d));
    return x;
});
static scale as FXMF=FXMF(function(x as FX,d as IData)as FX{
    x.p=x.p.scale(d.a as double);
    x.v=x.v.scale(d.a as double);
    if(d has "FXSizeScale")x.s=x.s*d.a;
    return x;
});
static stretch as FXMF=FXMF(function(x as FX,d as IData)as FX{
    x.p=x.p.stretch(V(d));
    x.v=x.v.stretch(V(d));
    return x;
});
static rot as FXMF=FXMF(function(x as FX,d as IData)as FX{
    var a as double=d.a as double;
    //print("rotA"~x.p.asString());
    x.p=x.p.rot(V(d),a);
    //print("rotB"~x.p.asString());
    x.v=x.v.rot(V(d),a);
    return x;
});
static colorRegu as FXMF=FXMF(function(x as FX,d as IData)as FX{
    //d.a: isDayTime?
    if(d.a as bool){
        var r as int=(x.c/65536);
        var g as int=(x.c/256%256);
        var b as int=(x.c%256);
        x.c=(r*r/256*65536+g*g/256*256+b*b/256)as int;
    }
    return x;
});



//FX Spawning Function
zenClass FXSF{
    var TMax as int = -1 as int;
    var f as [function(int,IData)[FX]];
    //var id as string;
    zenConstructor(/*id1 as string, */tmax as int, f1 as[function(int,IData)[FX]]){
        f=f1;/*id=id1;*/TMax=tmax;
    }
    function run(a as int,b as IData)as[FX]{
        if(a>=TMax){
            if(TMax>-1){
                var t as FX=FX();
                t.c=-1;
                return [t] as [FX];
            }
        }
        return f[0](a,b);
    }
}
