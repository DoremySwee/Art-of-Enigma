#loader contenttweaker
import crafttweaker.command.ICommandManager;
import crafttweaker.player.IPlayer;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
var RS=mods.contenttweaker.VanillaFactory.createSubTileFunctional("reversedspectrolus",0xAAAAAAA);
RS.range=0;
RS.maxMana=700000;
RS.acceptRedstone=true;
RS.onBlockPlaceBy=function(world as IWorld, pos as IBlockPos, state, entity, stack){
    
};
RS.onUpdate=function(subTile as mods.randomtweaker.cote.SubTileEntityInGame,
    world as IWorld, pos as IBlockPos){

};