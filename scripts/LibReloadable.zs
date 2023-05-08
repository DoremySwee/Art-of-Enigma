#loader crafttweaker reloadableevents
#priority 114
import crafttweaker.command.ICommandManager;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
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