extends Reference

var Tile=load("res://scripts/Tiles/Tile.gd")

var array
var size

func get_tile(pos):
	return array[pos.x][pos.y]

func build(size):
	self.size=size
	array=[]
	for x in range(size.x):
		array.append([])
		for y in range(size.y):
			var tile=Tile.new()
			tile.build(Vector2(x,y))
			array[x].append(tile)
	for x in range(size.x):
		for y in range(size.y):
			var tile=array[x][y]
			if x<size.x-1:
				tile.neighbors["right"]=array[x+1][y]
			if y<size.y-1:
				tile.neighbors["down"]=array[x][y+1]
			if x!=0:
				tile.neighbors["left"]=array[x-1][y]
			if y!=0:
				tile.neighbors["up"]=array[x][y-1]
