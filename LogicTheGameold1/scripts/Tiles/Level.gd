extends Reference

var Tiles=load("res://scripts/Tiles/Tiles.gd")
var Occupant=load("res://scripts/Tiles/Occupant.gd")

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

func remove(pos):
	var tile=get_tile(pos)
	tile.occupant=null

func place(pos,occupant_type):
	var tile=get_tile(pos)
	print(pos)
	tile.occupant=Occupant.new()
	tile.occupant.build(occupant_type)
