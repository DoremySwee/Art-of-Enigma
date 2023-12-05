#reloadable
import mods.zenutils.ftbq.CustomRewardEvent;
import crafttweaker.event.PlayerTickEvent;
import scripts.advanced.libs.Data;
import scripts.advanced.libs.Misc as M;
/*
events.onCustomReward(function(event as CustomRewardEvent) {
    if (event.reward.hasTag("cd10min")) {
        val player = event.player;
        player.update({PlayerPersisted: {: true}});
    }
});
events.onPlayerTick(function(event as PlayerTickEvent) {
    val player = event.player;
    if (!player.world.remote) {
        val flyingData = player.data.deepGet("PlayerPersisted.Flying");
        if (!isNull(flyingData) && flyingData.asBool() && !player.canFly) {
            player.canFly = true;
            NetworkHandler.sendTo("enableFlying", player);
        }
    }
});
*/
events.onCustomReward(function(event as CustomRewardEvent) {
    val player = event.player;
    var data = player.nbt.deepGet("ForgeData");
    //print(isNull(data));
    if (event.reward.hasTag("cd")) {
        for tag in event.reward.tags{
            if(tag.length>2 && tag[0]~tag[1]=="cd"){
                var n=0;
                for j in 2 to tag.length{
                    n=n*10 + ({"1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"0":0}as int[string])[tag[j]];
                }
                var qid=event.reward.quest.id;
                if(isNull(data))data={};
                data=data.deepSet(n*20*60,"PlayerPersisted.QuestCD."~qid);
                //print(data);
                player.update(data);
                return;
            }
        }
    }
});
events.onPlayerTick(function(event as PlayerTickEvent) {
    val player = event.player;
    var data = player.nbt.deepGet("ForgeData");
    if(isNull(data))return;
    if (!player.world.remote) {
        var datatemp=data.deepGet("PlayerPersisted.QuestCD");
        if(isNull(datatemp))return;
        var Map = datatemp.asMap();
        if(isNull(Map))return;
        for qid,cd in Map{
            var cdNew = cd<0 ? cd+10000 : cd - 1;
            data=data.deepSet(cdNew,"PlayerPersisted.QuestCD."~qid);
            var command = "ftbquests change_progress reset singleplayer "~mods.zenutils.HexHelper.toHexString(qid);
            if(cd<3){
                M.executeCommand(command);
                print(command);
            }
        }
        player.update(data);
    }
});