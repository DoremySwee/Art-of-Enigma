#reloadable
#priority 100
import scripts.recipes.libs.Mapping as Mp;
import crafttweaker.text.ITextComponent;
import scripts.advanced.libs.Data as D;
import scripts.advanced.libs.Misc as M;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import mods.zenutils.I18n;

static coinId as string="contenttweaker:coin";
static coinNum as int = 8;
static cdMinutes as int = 1;
static cd as int = cdMinutes * 1200;

function coin(x as int)as IItemStack{
    return itemUtils.getItem(coinId~x); 
}

print(mods.zenutils.StaticString.format("a %.2f b", [0.0555555f]));

for i in 1 to coinNum+1{
    coin(i).addTooltip(game.localize("description.crt.tooltip.coin"));
    coin(i).addAdvancedTooltip(function(item) {
        val cd = client.player.getCooldown(item);
        if (cd > 0.0f) {
            return I18n.format("description.crt.tooltip.coin.cd", [cd * cdMinutes]);
        } else {
            return null;
        }
    });
}

// TODO: persisted cd

