#loader crafttweaker reloadableevents
import scripts.advanced.libs.ParticleGenerator as D;
import scripts.advanced.libs.Vector3D as V;
import scripts.advanced.libs.Misc as M;
import crafttweaker.event.CommandEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.data.IData;
static whiteList as string[] = [
    "say","tellraw","forge","ftbquests","crafttweaker","backup","trashcan","shutdown"
] as string[];
static messages as string[] = [
    "You feel an evil presence watching you",
    "A horrible chill goes down your spine...",
    //"Screams echo around you...",
    //"This is going to be a terrible night...",
    "You feel vibrations from deep below...",
    "The air is getting colder around you...",
    //"What a horrible night to have a curse.",
    "Your mind goes numb...",
    "You are overwhelmed with pain...",
    "Otherworldly voices linger around you...",
    "Impending doom approaches...",
    "The ancient spirits of light and dark have been released.",
    "The Moon Lord has been defeated !"
] as string[];
static pipi as D.FXGenerator = D.FXGenerator("pipi")
    .addAging(1)
    .updateDefaultData({
        "x":0.0,  "y":0.0,  "z":0.0,
        "Ax":1.0, "Ay":0.0, "Az":0.0,
        "Bx":0.0, "By":1.0, "Bz":0.0
    }as IData)
    .addTick(function(world as IWorld, data as IData)as IData{
        return data;
    })
    .setRender(function(player as IPlayer, data as IData)as void{
        var datas as IData[] = []as IData[];
        var z0 = 0.0;
        for i in 0 to 30{
            var x0 = 2.5;
            for j in 0 to 2{
                datas+=({"color":0x000088,"r":0.4}as IData+
                    V.asData(V.add([x0,1.0,z0],V.stretch(V.rot(V.VX,V.VZ,6.0*i),[1.5,1.0,1.0])))
                );
                for k in 2 to 5{
                    datas+=({"color":0x999999,"r":0.3}as IData+
                        V.asData(V.add([x0 , 1.1- 0.2*k , z0], V.stretch(V.rot(V.VX,V.VZ,6.0*i),[1.5,1.0,1.0])))
                    );
                }
                for k in 2 to 11{
                    datas+=({"color":0x999999,"r":0.25}as IData+
                        V.asData(V.add([x0+0.1, 1.2- 0.05*k, z0], V.rot( V.stretch(V.rot( [0.05*k,0,0], V.VZ, 12.0*i),[1.7,1.0,1.0]), V.VZ, 172)))
                    );
                }
                for k in 14 to 23{
                    var f = V.add([x0,0.0,z0],V.stretch(V.rot( [0.075*k,0,0], V.VZ,2.0*i+240),[1.5,1.0,1.0]));
                    if(V.length(V.stretch(V.add(f,[-x0,1.0,-z0]),[0.6,1.1,1.1]))>0.4)
                        datas+=({"color":0x222277,"r":0.3}as IData+
                            V.asData(f)
                        );
                }
                x0 = -x0;
            }
        }
        for i in 0 to 30{
            var x0 = 0.5;
            datas+=({"color":0x444444,"r":0.2}as IData+
                V.asData(V.stretch(V.add([x0,-2.5,z0],V.rot(V.scale(V.VX,-0.5),V.VZ,8.0*i)),[1.0,1.2,1.0]))
            );
            datas+=({"color":0x444444,"r":0.2}as IData+
                V.asData(V.stretch(V.add([x0,-2.5,z0],V.rot(V.scale(V.VX,-0.5),V.VZ,8.0*i)),[-1.0,1.2,1.0]))
            );
        }
        for i in 25 to 30{
            datas+=({"color":0x444444,"r":0.2}as IData+
                V.asData([0.0,-0.1*i,z0])
            );
        }
        var A = V.readFromData(data,"A");
        var B = V.readFromData(data,"B");
        var scale = V.length(V.cross(A,B));
        for d in datas{
            var p0 = V.readFromData(d);
            var p = V.add(V.readFromData(data),V.add(V.scale(A,p0[0]),V.scale(B,p0[1])));
            var d2 = d + V.asData(p) + V.asData(V.V000,"v") + {"r": d.memberGet("r").asDouble()*scale, "a":100}as IData;
            //M.shout(d2);
            M.createBotFX(d2);
        }
    })
    .regi();
function pipiFX(player as IPlayer){
    for i in 0 to 23{
        var A = V.randomUnitVector();
        var B = V.unify(V.cross(A,V.randomUnitVector()));
        var C = V.cross(A,B);
        pipi.create(player.world, 
            V.asData(V.add(V.getPos(player),V.scale(C,10.0+i*2)))+
            V.asData(V.scale(A,1.0+0.1*i),"A")+
            V.asData(V.scale(B,1.0+0.1*i),"B")
        );
    }
}
events.onCommand(function(event as CommandEvent){
    if(scripts.Config.dev)return;
    if(whiteList has event.command.name)return;
    if(event.commandSender instanceof IPlayer){
        val player as IPlayer=event.commandSender;
        var rand as int=player.world.random.nextInt(messages.length);
        var message as string=messages[rand];
        if(scripts.Config.alpha)player.sendChat("You used command:"~event.command.name~"\nIf you want it to be added to the whiteList, inform the author.");
        M.executeCommand("tellraw "+
            /*p.displayName*/"@a" +
            " [{\"text\":\"" + message +
            "\",\"color\":\"dark_purple\",\"bold\":\"true\",\"italic\":\"true\"}]");

        //M.shout(V.display(V.getPos(player)));
        //print(V.asData(V.getPos(player)));
        //print(V.asData(V.V000));
        pipiFX(player);
    }
});