#reloadable
#priority 100000000
import crafttweaker.item.IIngredient as I;
static dev as bool= scripts.Config.dev;
static whiteSpaces as string[]=["\n","\r"," ","\t"];
function read1d(pattern as string, map as I[string])as I[]{
    var result as I[] = [] as I[];
    for index in 0 to pattern.length{
        var i = pattern[index];
        if(i=="_")result+=null as I;
        else if(map has i)result+=map[i];
        else if(dev){
            if(whiteSpaces has i)continue;
            else print("[Warning] mapping.zs: invalid key \""~i~"\"");
        }
    }
    return result;
}
function read(pattern as string, map as I[string], deleteLastEmptyLines as bool = true)as I[][]{
    var result as I[][] = [] as I[][];
    for i in pattern.split(";"){
        result+=read1d(i,map);
    }
    if(!deleteLastEmptyLines)return result;
    var r2 as I[][] = [] as I[][];
    var n = 0;
    for i in 0 to result.length{
        if(result[i].length>0)n=i+1;
    }
    for i in 0 to n{
        r2+=result[i];
    }
    return r2;
}
function read3d(pattern as string, map as I[string])as I[][][]{
    var result as I[][][]=[] as I[][][];
    for i in pattern.split("."){
        result+=read(i,map,false);
    }
    return result;
}

static CHARS as string[]=[
    "@","#","$","%","&","*","~",
    "1","2","3","4","5","6","7","8","9","0","`","!","^",
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
    "(",")","[","]","{","}","|","/","<",">",":",","
]as string[];

function getMap(ingredients as I[])as I[string]{
    var list as string[] = [] as string[];
    var result as I[string] = {} as I[string];
    var n = 0;
    for i in ingredients{
        if(isNull(i))continue;
        if(list has i.commandString)continue;
        if(n>=CHARS.length){
            if(dev)print("[ERROR] mapping.zs: too various inputs! cannot be coded as map!");
            return {}as I[string];
        }
        result[CHARS[n]]=i;
        list+=i.commandString;
        n+=1;
    }
    return result;
}
function reverseMap(m as I[string])as string[I]{
    var w as string[I] = {}as string[I];
    for k,v in m{
        w[v]=k;
    }
    return w;
}
function getPattern1d(inputs as I[], map as I[string])as string{
    var rm = reverseMap(map);
    var result = "";
    for i in inputs{
        //print(i.commandString());
        if(isNull(i))result+="_";
        else result+=rm[i];
    }
    return result;
}
function getPattern(inputs as I[][], map as I[string])as string{
    var result = "";
    for i in inputs{
        result+=getPattern1d(i,map);
        result+=";\n    ";
    }
    return result;
}
function getPattern3d(inputs as I[][][], map as I[string])as string{
    var result = "";
    for i in inputs{
        result+=getPattern(i,map);
        result+=".\n\n    ";
    }
    return result;
}
function displayMap(map as I[string])as string{
    var result="{";
    for k,v in map{
        if(result!="{")result+=",";
        result+="\n    \""~k~"\":"~v.commandString;
    }
    result+="\n}";
    return result;
}