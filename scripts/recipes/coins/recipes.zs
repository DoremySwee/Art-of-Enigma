#reloadable
import scripts.recipes.libs.Mapping as Mp;
import crafttweaker.text.ITextComponent;
import scripts.advanced.libs.Data as D;
import scripts.advanced.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
static coinId as string="contenttweaker:coin";
static coinNum as int = 8;
function coin(x as int)as IItemStack{
    return itemUtils.getItem(coinId~x); 
}
for i in 1 to coinNum+1{
    coin(i).addTooltip(game.localize("description.crt.tooltip.coin"));
}
//Right click to see cooldown

events.onPlayerRightClickItem(function(event as crafttweaker.event.PlayerRightClickItemEvent){
    var item = event.item;
    if(isNull(item))return;
    if(isNull(item.definition))return;
    var itemId = item.definition.id;
    if(isNull(itemId))return;
    if(!(itemId has coinId))return;
    var player = event.player;
    if(isNull(player))return;
    if(player.world.remote)return;
    var data = player.nbt.deepGet("ForgeData");
    if(isNull(data))return;
    var t1 = data.deepGet("PlayerPersisted.coinCD."~itemId);
    var cd = 0;
    if(!isNull(t1))cd = t1.asInt();
    var cd2 = 1.0*(0+100.0*(1.0*cd / 1200.0))/100;
    if(cd<1)player.sendRichTextStatusMessage(ITextComponent.fromTranslation("crt.chat.coin.cd3"));
    else player.sendRichTextStatusMessage(ITextComponent.fromTranslation("crt.chat.coin.cd1")~ITextComponent.fromString(""~cd2)~ITextComponent.fromTranslation("crt.chat.coin.cd2"));
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
//static CD as int[]= [30,30,30,]
static CD as int=30;
static tag as IData = {ench: [{lvl: 1 as short, id: 29 as short}],canCraft:true};
for i in 1 to coinNum+1{
    var c = coin(i);
    recipes.addShapeless("coinEnchant"~i,c.withTag(tag),[c],function(o,i,info){
        if(isNull(info.player))return c;
        var data = info.player.nbt.deepGet("ForgeData.PlayerPersisted.coinCD."~c.definition.id);
        if(isNull(data)){
            return c.withTag(tag);
        }
        if(data.asInt()<1) return c.withTag(tag);
        return c;
    },function(o,info,player){
        if(isNull(player))return;
        if(c.withTag(tag).matches(o)){
            var d1 = player.nbt.deepGet("ForgeData");
            if(isNull(d1))return;
            d1=d1.deepSet(CD*20*60,"PlayerPersisted.coinCD."~c.definition.id);
            player.update(d1);
        }
    });
}
//recipes