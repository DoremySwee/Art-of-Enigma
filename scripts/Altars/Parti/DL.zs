//Danmuku Lib
#loader crafttweaker
#loader crafttweaker reloadableevents
#priority 100
//#suppress errors
import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
import crafttweaker.player.IPlayer;

import mods.zenutils.IByteBuf;
import mods.zenutils.NetworkHandler;

import crafttweaker.events.IEventManager;
import crafttweaker.event.BlockHarvestDropsEvent;
import crafttweaker.event.BlockNeighborNotifyEvent;
import crafttweaker.event.BlockPlaceEvent;

import scripts.Altars.Parti.DanmukuLibBase3;
import scripts.Altars.Parti.DanmukuLibBase3.FX;
import scripts.Altars.Parti.DanmukuLibBase3.FXM;
import scripts.Altars.Parti.DanmukuLibBase3.FXMF;
import scripts.Altars.Parti.DanmukuLibBase3.FXSF;

import scripts.Altars.L;
import scripts.Altars.L.V;
import mods.ctutils.utils.Math;
//FX Spawner
zenClass FXS{
    var f as FXSF;
    var d as IData;
    var ml as [FXM]=[] as [FXM]; //FXM List
    var S2Cid as int=-1 as int;
    static registeredS2CNum as int[]=[0];
    zenConstructor(f1 as FXSF,d1 as IData){
        f=f1;d=d1;
    }
    function getFX(time as int)as[FX]{
        var list as[FX]=f.run(time,d);
        if(ml.length*list.length>0){
            for m in ml{
                for i in list{
                    i.write(m.run(i));
                }
            }
        }
        return list;
    }
    function pushModifier(m as FXM)as FXS{
        ml+=m;
        return this;
    }
    function shift(v as V)as FXS{
        return pushModifier(FXM(DanmukuLibBase3.shift,v.toData()));
    }
    function scale(r as double, size as bool)as FXS{
        if(size)return pushModifier(FXM(DanmukuLibBase3.scale,{a:r,FXSizeScale:1}as IData));
        return pushModifier(FXM(DanmukuLibBase3.scale,{a:r}as IData));
    }
    function scale(r as double)as FXS{
        return scale(r,false);
    }
    function stretch(v as V)as FXS{
        return pushModifier(FXM(DanmukuLibBase3.stretch,v.toData()));
    }
    function rot(v as V, r as double)as FXS{
        return pushModifier(FXM(DanmukuLibBase3.rot,
            {"x":v.x,"y":v.y,"z":v.z,"a":r}as IData));
    }
    function colorRegu(w as IWorld)as FXS{
        L.say(w.getProvider().getWorldTime());
        var temp as bool=((w.getProvider().getWorldTime()%24000)<12000);
        L.say(temp);
        return pushModifier(FXM(DanmukuLibBase3.colorRegu,{a:temp}as IData));
    }
    function run(t as int, w as IWorld, p as IBlockPos)as void{
        if(!w.isRemote()){
            if(S2Cid<0)L.say("哪个burnbee没在服务端注册弹幕就开始生成？要先用regiS2C()注册不知道吗？");
            else{
                NetworkHandler.sendToAllAround("DoremySwee_danmukuLib_DanmukuS2CMessage_id_"~S2Cid,
                p.x,p.y,p.z,300,w.getDimension(),function(b){
                    b.writeBlockPos(p);
                });
            }
            return;
        }
        var list as [FX]=getFX(t);
        if(list.length>0)
        {
            if(list[0].c<0)return;
            for i in list{
                i.p=i.p.add(V(p));
                i.regi(w);
            }
        }
        //print("catenation On!");
        //print(w.isRemote());
        //print(t);
        client.catenation().run(function(w1,c){
            //print("In catenation");
            //print(w1.isRemote());
            this.run(t+1,w1,p);
        }).start();
    }
    function run(w as IWorld, p as IBlockPos)as void{
        run(0,w,p);
    }

    function regiS2C()as FXS{
        registeredS2CNum[0]=registeredS2CNum[0]+1;
        var s as string="DoremySwee_danmukuLib_DanmukuS2CMessage_id_"~registeredS2CNum[0];
        S2Cid=registeredS2CNum[0];
        //print("S2Cid"~S2Cid);
        NetworkHandler.registerServer2ClientMessage(s,function(p,b){
            this.run(p.world,b.readBlockPos());
        });
        return this;
    }
}

function newV(x as double,y as double,z as double)as V{
    return V(x,y,z);
}


static FXBad as[FX]=[FX(V(0,0,0),V(0,0,0),-1,-1,-1)]as[FX];
static SingleParticle as FXSF=FXSF(/*"singleParticle",*/1,[function(t as int,d as IData)as[FX]{
    return [FX(d)]as[FX];
}]as[function(int,IData)[FX]]);
static Line as FXSF=FXSF(/*"line",*/-1,[function(t as int,d as IData)as[FX]{
    var p as int=1;
    if(d has "d")p=d.d as int;
    if(t>=p)return FXBad;
    var res as[FX]=[]as[FX];
    var n=1;
    if(d has "n")n=d.n as int;
    for i in 0 to n{
        var j as int=i+t*d.n;
        var fx as FX=FX(d);
        if(d has "dp")fx.p=fx.p.add(V(d.dp).scale(j));
        res+=fx;
    }
    return res;
}]as[function(int,IData)[FX]]);



static pipi as FXSF=FXSF(/*"pipi",*/1,[function(t as int,d as IData)as[FX]{
    var g as[FX]=[]as[FX];
    var z0 as double=7.0;
    for i in 0 to 30{
        for j in 0 to 2{
            var x0=2.5;
            if(j==0)x0=-2.5;
            g+=FX(V(x0,1,z0).add(V(1,0,0).rot(L.VZ,6*i).stretch(V(1.5,1,1))),L.V0,0x000088,0.4);
            for k in 2 to 5{
                g+=FX(V(x0,1.1- 0.2*k,z0).add(V(1,0,0).rot(L.VZ,6*i).stretch(V(1.5,1,1))),L.V0,0x999999,0.3);
            }
            for k in 2 to 11{
                g+=FX(V(x0+ 0.1,1.2- 0.05*k,z0).add(V(0.05*k,0,0).rot(L.VZ,12*i).stretch(V(1.7,1,1)).rot(L.VZ,172)),L.V0,0x999999,0.25);
            }
            for k in 14 to 23{
                var f as FX=FX(V(x0,0,z0).add(V(0.075*k,0,0).rot(L.VZ,i*2+240).stretch(V(1.5,1,1))),L.V0,0x222277);
                if(f.p.add(V(-1.0*x0,1,-1.0*z0)).stretch(V(0.6,1.1,1)).length()>0.4){
                    g+=f;
                }

            }
        }
    }
    for i in 0 to 30{
        var x0=0.5;
        g+=FX(V(x0,-2.5,z0).add(V(0.5,0,0).rot(L.VZ,8*i+180)).stretch(V(1,1.2,1)),L.V0,0x444444,0.2);
        g+=FX(V(x0,-2.5,z0).add(V(0.5,0,0).rot(L.VZ,8*i+180)).stretch(V(-1,1.2,1)),L.V0,0x444444,0.2);
    }
    for i in 25 to 30{
        g+=FX(V(0,-0.1*i,z0),L.V0,0x444444,0.2);
    }
    return g;
}]as[function(int,IData)[FX]]);


static StarSpin1 as FXSF=FXSF(1,[function(time as int, p as IData)as[FX]{
    var r=10.0;     if(p has "r")r=p.r as double;
    var m=9;        if(p has "m")m=p.m as int;
    var dside=m/2;  if(p has "dside")dside=p.dside as int;
    var n=150;      if(p has "n")n=p.n as int;
    var convex=1.0; if(p has "convex")convex=p.convex as double;
    var dang=135.0; if(p has "dang")dang=p.dang as double;
    var rat=1.0;    if(p has "rat")rat=p.rat as double;
    var g as [FX]=[] as [FX];
    for i in 0 to m{for k in 0 to n- 1{
        var j as double=k as double;
        var t as double=(j/n- 0.5)*(j/n- 0.5)*4;   //1 at two ends, 0 at the middle
        var pi as double=3.1415926 as double;
        var coxz as double=(4.0*convex-t)/(convex*4.0- 1);
        var p0 as V=V(r,0,0).combine(V(Math.cos(pi*dside/m*2)*r,0,Math.sin(pi*dside/m*2)*r),j/n).scale(coxz).rot(L.VY,1.0*i*360/m);
        var pp as V=p0.add(V(0,(1.0-t),0).scale((0.5-(k%2))*r/10));
        var v as V=p0.rot(L.VY,dang).scale(r*rat*0.001).add(     V(0,(Math.sqrt(t)- 1.0)*0.05,0).scale((0.5-(k%2))*r/10));
        var fx as FX=FX(p);
        fx.p=pp;fx.v=v;
        g+=fx;
    }}
    return g;
}]as[function(int,IData)[FX]]);

static Pillar as FXSF=FXSF(1,[function(time as int,p as IData)as[FX]{
    var g as [FX]=[] as [FX];
    var h=-40.0;if(p has"h")h=p.h as double;
    var n=300;if(p has"n")n=p.n as int;
    var r1=10.0;if(p has"r1")r1=p.r1 as double;
    var r2=3.0;if(p has"r2")r2=p.r2 as double;
    var o1=0.3;if(p has"o1")o1=p.o1 as double;
    var o2=10.0;if(p has"o2")o2=p.o2 as double;
    var m1=5;if(p has"m1")m1=p.m1 as int;
    var m2=3;if(p has"m2")m2=p.m2 as int;
    for b in 0 to m1{for c in 0 to m2{for a in 0 to n{
        var i as double=h*a/n;
        var j as double=b as double/m1 as double;
        var k as double=c as double/m2 as double;
        var pi as double=3.1415926535;
        var fx as FX=FX(p);
        fx.p=V(
            r1*Math.cos(o1*i+pi*2*j)+r2*Math.cos(o2*i+pi*2*k),
            -i,
            r1*Math.sin(o1*i+pi*2*j)+r2*Math.sin(o2*i+pi*2*k)
        );
        fx.v=V(0,-i/10,0);
        var c as int[]=[0xAAAAAA,0xFFEEEE,0xAAAAFF,0xFFFF99,0xFF7777] as int[];
        fx.c=c[b];
        g+=fx;
    }}}
    return g;
}]as[function(int,IData)[FX]]);

static SC_WPDuality_2d as FXSF=FXSF(-1,[function(time as int,p as IData)as[FX]{
    var dura as int=200;
    if(p has "d")dura=p.d as int;
    if(time>=dura)return FXBad;
    var g as [FX]=[] as [FX];
    var v=0.3;if(p has"v")v=p.v as double;
    var n=5;if(p has"n")n=p.n as int;
    var o=2.0/20;if(p has"o")o=p.o as double;
    for i in 0 to n{
        var a as double=o*time*time+360.0/n*i;
        g+=FX(V(-v,0,0).rot(V(0,1,0),a),V(v,0,0).rot(V(0,1,0),a),0xFF00FF,0.3,3);
    }
    return g;
}]as[function(int,IData)[FX]]);


static SC_WPDuality_3d as FXSF=FXSF(-1,[function(time as int,p as IData)as[FX]{
    var dura as int=200;
    if(p has "d")dura=p.d as int;
    if(time>=dura)return FXBad;
    var g as [FX]=[] as [FX];
    var v=2.5;if(p has"v")v=p.v as double;
    var n=15;if(p has"n")n=p.n as int;
    var o1=17.0;if(p has"o1")o1=p.o1 as double;
    var o2=5.0;if(p has"o2")o2=p.o2 as double;
    var o3=3.0;if(p has"o3")o3=p.o3 as double;
    var o12=1.7;if(p has"o12")o12=p.o12 as double;
    var o22=6.0;if(p has"o22")o22=p.o22 as double;
    var o32=5.0;if(p has"o23")o32=p.o32 as double;
    var p1=2.0/261;if(p has"p1")p1=p.p1 as double;
    var p2=9.0/261;if(p has"p2")p2=p.p2 as double;
    var p3=6.0/261;if(p has"p3")p3=p.p3 as double;
    for i in 0 to n{
        var a1 as double=o12*time/301+o1*Math.sin(p1*time+360.0/n*i)*60;
        var a2 as double=o22*time/301+o2*Math.sin(p2*time+360.0/n*i)*60;
        var a3 as double=o32*time/301+o3*Math.sin(p3*time+360.0/n*i)*60;
        var c as int[]=[0xAAAAAA,0xFFEEEE,0xAAAAFF,0xFFFF99,0xFF7777] as int[];
        g+=FX(V(-v,0,0).rot(V(1,0,0),a3).rot(V(0,0,1),a2).rot(V(0,1,0),a1)
        ,V(v,0,0).rot(V(1,0,0),a3).rot(V(0,0,1),a2).rot(V(0,1,0),a1),c[i%5],1,4);
    }
    return g;
}]as[function(int,IData)[FX]]);

//Example on Client Side
/**
events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
    var w as IWorld=event.world;
    if(!w.isRemote())return;
    if(event.block.definition.id!="botania:terraplate")return;
    var r as double=L.rand1();
    if(r<0.25){
        FXS(StarSpin1,{r:10,convex:0.3,c:0xFFFF00}as IData).run(w,event.position);
        FXS(StarSpin1,{r:20,convex:0.7,c:0x00FFFF}as IData).run(w,event.position);
        FXS(StarSpin1,{r:70,convex:0.1,c:0xFF00FF,rat:0}as IData).run(w,event.position);
    }
    else if(r<0.5){
        FXS(Pillar,{}as IData).run(w,event.position);
    }
    else if(r<0.75){
        FXS(SC_WPDuality_3d,{}as IData).run(w,event.position);
    }
    else{
        FXS(SC_WPDuality_2d,{}as IData)/*.rot(V(1,0,0),90).shift(V(20,0,0))*.run(w,event.position);
    }
});/**/

//Example on Server Side
static example_pipi1 as FXS=FXS(pipi,{}as IData).scale(0.1,true).rot(V(0,1,0),0.000).shift(V(-1,1.4,0)).regiS2C();
static example_pipi2 as FXS=FXS(pipi,{}as IData).scale(0.1,true).rot(V(0,1,0),90.00).shift(V(-1,1.4,0)).regiS2C();
static example_pipi3 as FXS=FXS(pipi,{}as IData).scale(0.1,true).rot(V(0,1,0),180.0).shift(V(-1,1.4,0)).regiS2C();
static example_pipi4 as FXS=FXS(pipi,{}as IData).scale(0.1,true).rot(V(0,1,0),270.0).shift(V(-1,1.4,0)).regiS2C();
events.onCommand(function(event as crafttweaker.event.CommandEvent){
    if(event.command.name=="say")return;
    if(event.command.name=="tellraw")return;
    if(event.command.name=="forge")return;
    if(event.command.name=="ftbquests")return;
    if(event.command.name=="crafttweaker")return;
    if(event.commandSender instanceof IPlayer){
        val p as IPlayer=event.commandSender;
        example_pipi1.run(p.world,V(p).asIBlockPos());
        example_pipi2.run(p.world,V(p).asIBlockPos());
        example_pipi3.run(p.world,V(p).asIBlockPos());
        example_pipi4.run(p.world,V(p).asIBlockPos());/**/
        //p.server.commandManager.executeCommand(server,"tellraw "+"@p"+" [{\"text\":\"bobne~mimi~\",\"color\":\"dark_purple\",\"bold\":\"true\",\"italic\":\"true\"}]");
    }
});