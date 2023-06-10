#loader crafttweaker reloadableevents
#priority 100000014
import crafttweaker.command.ICommandManager;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.world.IBlockPos;
import crafttweaker.entity.IEntity;
import crafttweaker.player.IPlayer;
import crafttweaker.world.IWorld;
import crafttweaker.block.IBlock;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
static PIE as double=3.1415927;
static Pie as double=3.1415927;
function executeCommand(s as string){
    server.commandManager.executeCommandSilent(server,s);
}
function say(s as string){
    executeCommand("say "~s);
}
function tell(p as IPlayer,s as string){
    p.sendChat(s);
}
function NBTToString(dat as IData)as string{
    if((!isNull(dat))&&(dat has "id")){
        var s="<"~dat.id;
        if(dat has "Damage")s=s~":"~(dat.Damage as int);
        s=s~">";
        //if(dat has "Count")s=s~"*"~(dat.Count as int);
        if(dat has "tag")s=s~" .withTag("~(dat.tag as IData).asString()~")";
        return s;
    }
    else return "null";
}
function MergeData(dat1 as IData,dat2 as IData/*, mode as string = "override"*/)as IData{
    /*if(isNull(dat1))return dat2;
    if(isNull(dat2))return dat1;
    if(!isNull(dat1.asList())){
        //return dat1+dat2;
        return dat2;
    }
    else if(!isNull(dat1.asMap())){
        var dat as IData=IData.createEmptyMutableDataMap();
        for key,value in dat1.asMap(){
            dat.memberSet(key,dat1.memberGet(key));
        }
        for key,value in dat2.asMap(){
            if(dat has key)dat.memberSet(key,MergeData(dat.memberGet(key),dat2.memberGet(key)));
            else dat.memberSet(key,dat2.memberGet(key));
        }
        return dat;
    }
    else{
        return dat2;
    }*/
    return ({}as IData+dat1).deepUpdate(dat2,mods.zenutils.DataUpdateOperation.MERGE);
}
static CHARS as string[]=["@","#","$","%","&","*","~",
"1","2","3","4","5","6","7","8","9","0","`","!","^",
"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
"(",")","[","]","{","}","|","/","<",">",":",".",","]as string[];
function getReducedRecipeDef(ins as string[])as string[string]{
    var map={"null":"_"}as string[string];
    var index as int=0;
    for i in ins{
        if(isNull(map[i])){
            map[i]=CHARS[index];
            index=index+1;
            if(index>=CHARS.length)return null;
        }
    }
    return map;
}
function getReducedIIngredientArray(ins as string[],sidelength as int)as string{
    var map as string[string]=getReducedRecipeDef(ins);
    if(isNull(map)){
        var index=1;
        var result="";
        var temp="";
        for i in ins{
            temp=temp~i;
            if(index==sidelength){
                if(result!="")result=result~",\n\t\t";
                result=result~"["~temp~"]";
                temp="";
                index=1;
            }
            else{
                temp=temp~",";
                index=index+1;
            }
        }
        if(temp!=""){
            if(result!="")result=result~",";
            result=result~"["~temp~"]";
        }
        if(sidelength<0) return result;
        return "\n["~result~"]";
    }
    else{
        var r1 as string="{";
        for k in map.keys{
            if(r1!="{")r1=r1~",";
            r1=r1~"\n\t\t\""~map[k]~"\":"~k;
        }
        //r1=r1~"\n\t} as crafttweaker.item.IIngredient[string],";
        r1=r1~"\n\t},";
        var index=1;
        var r2 as string="\"";
        var temp as string="";
        for i in ins{
            temp=temp~map[i];
            if(index==sidelength){
                //if(r2!="")r2=r2~";";
                r2=r2~"\n\t\t"~temp~";";
                temp="";
                index=1;
            }
            else{
                //temp=temp~",";
                index=index+1;
            }
        }
        if(temp!=""){
            //if(r2!="")r2=r2~",";
            r2=r2~"\n\t\t"~temp~";";
        }/*
        var r3 as string="["~r2~"]";
        if(sidelength<0)r3=r2;*/
        return "\nLib.Mapper("~r1~r2~"\"\n)";
    }/*/
    return "null";/**/
}
function isBlock(world as IWorld, pos as IBlockPos, id as string, meta as int=100)as bool{
    if(isNull(world.getBlock(pos)))return false;
    return world.getBlock(pos).definition.id==id && (meta==100 || world.getBlock(pos).meta==meta);
}
function formStackFromNBT(data as IData)as IItemStack{
    if(data has "id"){
        var stack as IItemStack=itemUtils.getItem(data.id as string);
        if(data has "Damage")stack=stack.definition.makeStack(data.Damage as int);
        if(data has "tag")stack=stack.withTag(data.tag);
        return stack;
    }
    return null;
}
function getItemsInChest(block as IBlock)as IItemStack[]{
    if(block.definition.id!="minecraft:chest")return [];
    if(isNull(block.data))return [];
    var data as IData=block.data;
    if(!(data has "Items"))return [];
    var data1 as [IData]=data.Items.asList();
    var result as IItemStack[]=[];
    for data2 in data1{
        var stack=formStackFromNBT(data2);
        result+=stack;
    }
    return result;
}
function floor(x as double)as int{
    if(x==(x as int)as double)return x as int;
    if(x>=0)return x as int;
    return 0-((0-x)as int)- 1;
}/*
say(floor(-1));
say(floor(-1.2));
say(floor(0));
say(floor(1));
say(floor(1.2));*/
function formBlockPos(x as double, y as double, z as double)as IBlockPos{
    return IBlockPos.create(floor(x),floor(y),floor(z));
}
function formBlockPosVector(v as double[])as IBlockPos{
    return formBlockPos(v[0],v[1],v[2]);
}


function turnIDataToCommandNBT(rawCommand as string)as string{
    var command=rawCommand;
    var commandFormalized as string="";
    var flag as int=0;
    for i in 0 to command.length{
        if(command[i] == " ")flag = flag - 1;
        if( ([",","{","}","[","]"]as string[]) has command[i])flag=0;
        if(command[i]=="a" && i>0 && i < command.length - 2 && command[i - 1]==" " && command[i+1]=="s" && command[i+2]==" "){
            flag=2;
        }
        if(flag > 0)continue;
        commandFormalized += command[i];
    }
    return commandFormalized;
}


static sinfans as double[]=[]as double[];
for i in 0 to 900{
    sinfans+=Math.sin(PIE*0.1*i/180);
}
function getsinfans(x1 as int)as double{
    var x=(x1%3600+3600)%3600;
    if(x==900)return 1.0;
    if(x<900)return sinfans[x];
    if(x<1800)return getsinfans(1800-x);
    return -getsinfans(x- 1800);
}
function sinf(x as double)as double{
    var a as int=floor(x*10);
    return getsinfans(a)*(1.0+a-x*10)+getsinfans(a+1)*(x*10-a);
}
function cosf(x as double)as double{
    return sinf(x+90);
}
function tanf(x as double)as double{
    if(cosf(x)==0.0)return 0.0;
    return sinf(x)/cosf(x);
}
function sinfR(x as double)as double{
    return sinf(x*PIE/180);
}
function cosfR(x as double)as double{
    return cosf(x*PIE/180);
}
function tanfR(x as double)as double{
    return tanf(x*PIE/180);
}
/*
for i in 0 to 360{
    print("sinf("~0.1*i~")="~sinf(0.1*i));
    print("sin("~0.1*i~")="~Math.sin(PIE/180*0.1*i));
}*/


function getEntitiesAround(world as IWorld, centre as double[], range as double)as [IEntity]{
    return world.getEntitiesInArea(IBlockPos.create(
        (centre[0]-range) as int, (centre[1]-range) as int, (centre[2]-range) as int
    ), IBlockPos.create(
        (centre[0]+range) as int, (centre[1]+range) as int, (centre[2]+range) as int
    ));
}

function shiftIBlockPos(a as IBlockPos, x as int, y as int, z as int)as IBlockPos{
    return IBlockPos.create(a.x+x,a.y+y,a.z+z);
}



function compareBlock(data as IData, block as IBlock)as bool{
    if(data has "id"){
        var id as string="";
        if(!isNull(block.definition)){
            id = block.definition.id;
        }
        else if (!isNull(block.fluid)){
            id = block.fluid.name;
        }
        if(id!=data.memberGet("id").asString())return false;
    }
    if(data has "meta" && block.meta!=data.memberGet("meta").asInt())return false;
    if(data has "data"){
        var d2 = data.memberGet("data");
        //I the [if] should not be used
        if(data has "matchDataExactly" && data.memberGet("matchDataExactly").asBool()){
            if(d2!=block.data)return false;
        }
        else{
            if(block.data != ({}as IData+block.data).deepUpdate(d2,mods.zenutils.DataUpdateOperation.MERGE))return false;
        }
    }
    return true;
}

function checkStructure(world as IWorld, pos as IBlockPos, pattern as string[] , map as IData, xshift as int, yshift as int, zshift as int)as string[]{
    var invalid as string[]=[];
    var dy=yshift;
    for p in pattern{
        var i=0;
        var j=0;
        var k=0;
        for k in 0 to p.length{
            if(p[k]==";"){
                j=0;i+=1;
            }
            else if(map has p[k]){
                var pos2 = shiftIBlockPos(pos,i+xshift,dy,j+zshift);
                if(!compareBlock(map.memberGet(p[k]),world.getBlock(pos2))){
                    var d as IData = map.memberGet(p[k]);
                    var name = (d has "specialInfo")?
                        d.memberGet("specialInfo").asString():
                        itemUtils.getItem(d.id.asString(), ((d has "meta")?(d.meta.asInt()):0)).displayName ~ ((d has "extraInfo")?d.extraInfo.asString():"");
                    invalid += ("( " ~pos2.x~" , "~pos2.y~" , "~pos2.z~" ) : "~ name /*~ "debug:"~i~","~j*/) as string;
                }
                j+=1;
            }
        }
        dy+=1;
    }
    return invalid;
}

function Lightning(world as IWorld, pos as IBlockPos, effectOnly as bool=false){
    world.addWeatherEffect(world.createLightningBolt(0.0+pos.x,0.0+pos.y,0.0+pos.z,effectOnly));
}
function Explode(world as IWorld, pos as IBlockPos, strength as float = 5.0f, causeFire as bool=true, breakBlock as bool=true, entity as IEntity=null){
    world.performExplosion(entity, 0.5+pos.x, 0.5+pos.y, 0.5+pos.z, strength, causeFire, breakBlock);
}