#loader crafttweaker reloadableevents
import scripts.recipes.libs.Mapping as Mp;
import scripts.advanced.libs.Data as D;
import scripts.advanced.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.data.IData;

var wand=<minecraft:iron_axe>;

if(scripts.Config.dev){
    //Items in chest are printed as list and map.
    events.onPlayerInteractBlock(function(event as crafttweaker.event.PlayerInteractBlockEvent){
        if(event.player.world.remote)return;
        if(!isNull(event.block)&&event.block.definition.id=="minecraft:chest"){
            var list = M.getItemsInChest(event.block);
            var logstring as string="";
            print("Items in chest:");
            print("as list:");
            for i in list{
                logstring=logstring~i.commandString~",\n";
            }
            print(logstring);
            print("as map:");

            var map = Mp.getMap(list);
            var pattern = Mp.getPattern1d(list,map);
            print(
                "Mp.read(\""~pattern~"\", "~Mp.displayMap(map)~")[0]"
            );
            M.tellAuto(event.player,"contents have been listed/mapped in the log!");
        }
    });

    //create 9x9 input
    events.onPlayerLeftClickBlock(function(event as crafttweaker.event.PlayerLeftClickBlockEvent){
        if(isNull(event.item))return;
        if(wand.matches(event.item)){
            if(event.block.definition.id==<avaritia:extreme_crafting_table>.definition.id){
                var datas as IData=event.block.data;
                if(isNull(datas))return;
                var list as IIngredient[]=[] as IIngredient[];
                var tt as IIngredient[]=[] as IIngredient[];
                var inputs as IIngredient[][]=[] as IIngredient[][];
                for i in 0 to 81 {
                    var key as string="Craft"~i;
                    var data as IData=datas.memberGet(key);
                    if(isNull(data)){
                        tt+=null;
                    }
                    else{
                        tt+=D.getStack(data);
                        list+=D.getStack(data);
                    }
                    if(i%9==8){
                        inputs+=tt;
                        tt=[]as IIngredient[];
                    }
                }
                var map = Mp.getMap(list);
                //if(1.0 * (map.keys.length+0.7) / (list.length+1) > 0.8){
                if(map.keys.length>65){
                    var logstring = "[\n";
                    for i in inputs{
                        if(logstring!="[\n")logstring+=",\n";
                        var t = "[";
                        for j in i{
                            if(t!="[")t+=", ";
                            if(isNull(j))t+="null";
                            else t+=j.commandString;
                        }
                        logstring+=t~"]";
                    }
                    logstring+="\n]";
                    print(logstring);
                }
                else{
                    var pattern = Mp.getPattern(inputs,map);
                    print("Mp.read(\"\n    "~pattern~"\","~Mp.displayMap(map)~")");
                }
                M.tellAuto(event.player,"Recipe has been outputed to crafttweaker.log!");
                event.cancel();
            }
        }
    });
}