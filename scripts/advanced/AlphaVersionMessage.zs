#loader crafttweaker reloadableevents
if(scripts.Config.alpha){
    events.onPlayerLoggedIn(function(event as crafttweaker.event.PlayerLoggedInEvent){
        event.player.sendRichTextStatusMessage(crafttweaker.text.ITextComponent.fromTranslation("crt.chat.alphaversion"),false);
    });
}