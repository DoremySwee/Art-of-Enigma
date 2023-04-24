#loader crafttweaker
#loader crafttweaker reloadableevents
#priority 1000
import crafttweaker.server.IServer;
import crafttweaker.command.ICommandSender;
import crafttweaker.block.IBlock;
import crafttweaker.world.IWorld;
import crafttweaker.world.IFacing;
import crafttweaker.world.IBlockPos;
import crafttweaker.block.IBlockState;
import crafttweaker.world.IVector3d;
import crafttweaker.util.Position3f;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;

//say
function say(s as string)as void{
    server.commandManager.executeCommand(server,"say "~s);
}

//Random
function rand(a as double, b as double)as double{
    var t=Math.random();
    return t*a+(1.0-t)*b;
}
function rand1()as double{
    return Math.random();
}
function randInt(a as int, b as int)as int{
    var t=Math.random();
    return a*t+b*(1.0-t);
}

//Math
function toRadius(a as double)as double{
    return 3.1415926*a/180.0;
}

//Structure Checking
static ALLIBlockFacing as IFacing[]=[IFacing.north(),IFacing.east(),IFacing.south(),IFacing.west(),IFacing.down(),IFacing.up()];
function checkStrongPower(w as IWorld,p as IBlockPos)as bool{
    for i in ALLIBlockFacing{
        if(w.getStrongPower(p.getOffset(i,1),i)>0)return true;
    }
    return false;
}          
function checkRSWork(w as IWorld,p as IBlockPos)as bool{
    if(checkStrongPower(w,p))return true;
    for i in ALLIBlockFacing{
        if(checkStrongPower(w,p.getOffset(i,1)))return true;
    }
    return false;
}
function match_by_meta(a as IBlockState, b as IBlockState, c as int)as bool{
    var ret as bool=false;
    if(isNull(b))return true;
    if(a.block.definition.id==b.block.definition.id){
        if(a.meta==c | c<0){
            ret=true;
        }
    }
    return ret;
}
function checkBlockStates(w as IWorld, p as IBlockPos, x_shift as int, y_shift as int, z_shift as int, MultB as IBlockState[][][], MultBMeta as int[][][])as bool{
    for i in 0 to MultB.length for j in 0 to MultB[i].length for k in 0 to MultB[i][j].length{
        if(isNull(MultB[i][j][k]))continue;
        if(!(match_by_meta(w.getBlockState(Position3f.create(
                p.getX()+x_shift+i,
                p.getY()+y_shift+j,
                p.getZ()+z_shift+k).asBlockPos()),
            MultB[i][j][k],MultBMeta[i][j][k])))return false;
    }
    return true;
}
zenClass V{
    var x as double;
    var y as double;
    var z as double;
    zenConstructor(x1 as double, y1 as double, z1 as double){
        x=x1;y=y1;z=z1;
    }
    zenConstructor(v as IBlockPos){
        x=0.5+v.x;y=0.5+v.y;z=0.5+v.z;
    }
    zenConstructor(v as IVector3d){
        x=v.x;y=v.y;z=v.z;
    }
    zenConstructor(v as Position3f){
        x=v.x;y=v.y;z=v.z;
    }
    zenConstructor(d as IData){
        x=0;y=0;z=0;
        if(d has "x")x=d.x as double;
        if(d has "y")y=d.y as double;
        if(d has "z")z=d.z as double;
    }
    zenConstructor(){
        x=0;y=0;z=0;
    }
    zenConstructor(e as crafttweaker.entity.IEntity){
        x=e.x;y=e.y;z=e.z;
    }

    function asIVector3d() as IVector3d{
        return IVector3d.create(x,y,z);
    }
    function asPosition3f() as Position3f{
        return Position3f.create(x,y,z);
    }
    function asIBlockPos() as IBlockPos{
        return Position3f.create(x,y,z) as IBlockPos;
    }
    function asString() as string{
        return "("~x~','~y~','~z~")";
    }
    function toData() as IData{
        return {"x":x,"y":y,"z":z}as IData;
    }

    function copy() as V{
        return V(x,y,z);
    }
    function isZero() as bool{
        return length()==0;
    }

    function add(v as V) as V{
        return V(x+v.x,y+v.y,z+v.z);
    }
    function reverse() as V{
        return V(-x,-y,-z);
    }
    function subtract(v as V) as V{
        return add(v.reverse());
    }
    function scale(r as double) as V{
        return V(x*r,y*r,z*r);
    }
    function stretch(v as V) as V{
        return V(x*v.x,y*v.y,z*v.z);
    }
    function combine(v as V, r as double) as V{
        return scale(r).add(v.scale(1.0-r));
    }
    function length() as double{
        return Math.sqrt(x*x+y*y+z*z);
    }
    function unify() as V{
        if(isZero())return this;
        else return scale(1.0/length());
    }

    function dot(v as V) as double{
        return x*v.x+y*v.y+z*v.z;
    }
    function cross(v as V) as V{
        return V(y*v.z-z*v.y, z*v.x-x*v.z, x*v.y-y*v.x);
    }
    function project(v as V) as V{
        return v.scale(dot(v)/v.length()/v.length());
    }
    function rotR(axis as V, angle as double) as V{
        axis.unify();
        return scale(Math.cos(angle)).add(
            axis.cross(this).scale(Math.sin(angle)).add(
                axis.scale(dot(axis)*(1.0-Math.cos(angle)))
            )
        );
    }
    function rot(axis as V, angle as double) as V{
        return rotR(axis, angle*3.1415926/180.0);
    }
    function ang(v as V)as double{
        return Math.asin(dot(v)/length()/v.length())/3.1415926*180;
    }
}
//print("V.ang() Test, ang between(1,0,0) & (0.5,0.866,0) is?  " ~ V(1,0,0).ang(V(0.5,0.866,0)));
//print("V.rot() Test, (1,0,0).rot((0,1,0),30)=?" ~ V(1,0,0).rot(V(0,1,0),30).asString());

static V0 as V=V();
static VX as V=V(1,0,0);
static VY as V=V(0,1,0);
static VZ as V=V(0,0,1);