#loader crafttweaker reloadableevents
if(scripts.Config.alpha){
    events.onPlayerLoggedIn(function(event as crafttweaker.event.PlayerLoggedInEvent){
        event.player.sendChat(game.localize("crt.chat.alphaversion"));
    });
}