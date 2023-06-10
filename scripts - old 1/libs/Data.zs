#loader crafttweaker reloadableevents
#priority 1000000000
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
print("PPP");
var temp as string[]= "a.b.c.d".split("\\.");
print(temp.length);
for i in 0 to temp.length{
    print(temp[i]);
}
var temp2 as string[]=["a","b","c","d"];
for i in 0 to temp2.length{
    print(temp2[i]);
}

/*string
function splitString(input as string, char as string)as string[]{
    if(input=="")return [] as string[];
    var ans as string[]= [] as string[];
    var temp = "";
    for i in 0 to input.length{
        if(input[i]==char){
            ans += temp;
            temp = "";
        }
        else{
            temp += input[i];
        }
    }
    if(temp!="") ans += temp;
    for j in ans{
        print("    "~j);
    }
    return ans;
}


//Data
function deepHas(data as IData, path as string)as bool{
    var d = data;
    for key in path.split("\\."){
        print(key);
        //if(!(d has key))return false;
        //print(d);
        //d = d.memberGet(key);
    }
    return true;
}*/
