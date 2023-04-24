#loader crafttweaker reloadableevents

import crafttweaker.events.IEventManager;

import crafttweaker.block.IBlockDefinition;
import crafttweaker.block.IBlockState;
import crafttweaker.block.IBlock;

import crafttweaker.world.IFacing;
import crafttweaker.util.Position3f;
import crafttweaker.world.IBlockPos;

import crafttweaker.world.IWorld;
import crafttweaker.data.IData;

import crafttweaker.server.IServer;
import crafttweaker.command.ICommandSender;

import crafttweaker.event.WorldTickEvent;
import crafttweaker.event.BlockNeighborNotifyEvent;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.entity.IEntityItem;
import mods.ctutils.utils.Math;/*
function a() {

  var b as function()void =function(){
    print("b");
  };
  print("a");

  b();
}

events.onBlockNeighborNotify(function(event as BlockNeighborNotifyEvent){
    a();
});*/