#reloadable
import scripts.recipes.libs.Mapping as Mp;
import crafttweaker.text.ITextComponent;
import scripts.advanced.libs.Data as D;
import scripts.advanced.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
static coinId="contenttweaker:coin";
function coin(x)as IItemStack{
    return itemUtils.getItem(coinId~x); 
}
for i in 1 to 9{
    coin(i).addTooltip(game.localize("description.crt.tooltip.coin"));
}
//Right click to see cooldown
event.onPlayerRightClickItem(function(event as crafttweaker.event.PlayerRightClickItemEvent){
    var item = event.item;
    if(isNull(item))return;
    if(isNUll(item.definition))return;
    var itemId = item.definition.id;
    if(isNull(itemId))return;
    if(!(itemId has coinId))return;
    var player = event.player;
    var data = player.nbt.deepGet("ForgeData");
    if(isNull(data))return;
    var t1 = data.deepGet("Persisted.coinCD."~itemId);
    if(isNull(t1))return;
    var cd = t1.asInt();
    var cd2 = 1.0*cd / 1200.0;
    if(cd<1)player.sendRichTextStatusMessage(ITextComponent.fromTranslation("crt.chat.coin.cd3"));
    else player.sendRichTextStatusMessage(ITextComponent.fromTranslation("crt.chat.coin.cd1"~cd2~"crt.chat.coin.cd2"));
});
//update cooldown
events.onPlayerTick(function(event as crafttweaker.event.PlayerTickEvent) {
    val player = event.player;
    var data = player.nbt.deepGet("ForgeData");
    if(isNull(data))return;
    if (!player.world.remote) {
        var datatemp=data.deepGet("PlayerPersisted.coinCD");
        if(isNull(datatemp))return;
        var Map = datatemp.asMap();
        if(isNull(Map))return;
        for cid,cd in Map{
            var cdNew = cd<1 ? 0 : cd - 1;
            data=data.deepSet(cdNew,"PlayerPersisted.coinCD."~cid);
        }
        player.update(data);
    }
});
//CD Enchanting Recipe
//recipes