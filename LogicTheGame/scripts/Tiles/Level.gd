extends Reference

var Tiles=load("res://scripts/Tiles/Tiles.gd")

var size
var manager
var tiles

func build(manager,size):
	self.manager=manager
	self.size=size
	tiles=Tiles.new()
	tiles.build(size)

func get_tile(pos):
	return tiles.get_tile(pos)
