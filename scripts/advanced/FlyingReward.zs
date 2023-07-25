#reloadable
import mods.zenutils.ftbq.CustomRewardEvent;
import mods.zenutils.NetworkHandler;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.data.IData;

events.onCustomReward(function(event as CustomRewardEvent) {
    if (event.reward.hasTag("flying")) {
        val player = event.player;
        player.update({PlayerPersisted: {Flying: true}});
        NetworkHandler.sendTo("enableFlying", player);
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

NetworkHandler.registerServer2ClientMessage("enableFlying", function(player, byteBuf) {
    player.canFly = true;
});
