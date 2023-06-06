#loader crafttweaker reloadableevents
#priority 1000000
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

//display
function executeCommand(s as string){
    server.commandManager.executeCommandSilent(server,s);
}
function shout(s as string){
    executeCommand("say "~s);
}
function say(world as IWorld, pos as IBlockPos, s as string, range as double = 300.0){
    for player in world.getAllPlayers(){
        var dx = player.x-pos.x;
        var dy = player.y-pos.y;
        var dz = player.z-pos.z;
        if(dx*dx+dy*dy+dz*dz>range*range)continue;
        player.sendChat(s);
    }
}
/*
function isBlock(world as IWorld, pos as IBlockPos, id as string, meta)as bool{
    
}*/