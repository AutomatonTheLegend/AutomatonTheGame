extends Reference

var Tile=load("res://scripts/Tile.gd")
var Occupant=load("res://scripts/Occupant.gd")

var tiles
var size
var game
var view

func to_tile_pos(pos):
	var view=game.game_state.special.view
	return Vector2(pos.x/view.tile_size.x,pos.y/view.tile_size.y)

func get_player():
	var occupant_meta=game.game_state.special.occupant_meta
	for x in range(size.x):
		for y in range(size.y):
			var tile=tiles[x][y]
			if tile.occupant!=null:
				if occupant_meta.names[tile.occupant.type]=="PLAYER":
					return tile.occupant
	return null

func build_tiles():
	tiles=[]
	for x in range(size.x):
		tiles.append([])
		for y in range(size.y):
			var tile=Tile.new()
			tile.build(Vector2(x,y))
			tiles[x].append(tile)
	for x in range(size.x):
		for y in range(size.y):
			var tile=tiles[x][y]
			if x==size.x-1:
				tile.neighbors["RIGHT"]=null
			else:
				tile.neighbors["RIGHT"]=tiles[x+1][y]
			if y==size.y-1:
				tile.neighbors["DOWN"]=null
			else:
				tile.neighbors["DOWN"]=tiles[x][y+1]
			if x==0:
				tile.neighbors["LEFT"]=null
			else:
				tile.neighbors["LEFT"]=tiles[x-1][y]
			if y==0:
				tile.neighbors["UP"]=null
			else:
				tile.neighbors["UP"]=tiles[x][y-1]

func build(game,size):
	self.game=game
	self.size=size
	build_tiles()


func switch_occupant(pos):
	var occupant_meta=game.game_state.special.occupant_meta
	var tile=tiles[pos.x][pos.y]
	if tile.occupant==null:
		tile.occupant=Occupant.new()
		tile.occupant.build(0,tile)
	else:
		if tile.occupant.type==occupant_meta.types-1:
			tile.occupant=null
		else:
			tile.occupant.type+=1

func open(game, name):
	var occupant_meta=game.game_state.special.occupant_meta
	var file=File.new()
	file.open("./levels/"+name,File.READ)
	var size_x=int(file.get_line())
	var size_y=int(file.get_line())
	build(game,Vector2(size_x,size_y))
	for x in range(size.x):
		for y in range(size.y):
			var string=file.get_line()
			if string !="null":
				var type=occupant_meta.indexes[string]
				var tile=tiles[x][y]
				tile.occupant=Occupant.new()
				tile.occupant.build(type,tile)
	file.close()

func save():
	var occupant_meta=game.game_state.special.occupant_meta
	var file=File.new()
	file.open("./levels/save.level",File.WRITE)
	file.store_line(String(size.x))
	file.store_line(String(size.y))
	for x in range(size.x):
		for y in range(size.y):
			var tile=tiles[x][y]
			var string=""
			if tile.occupant==null:
				string+="null"
			else:
				var type=tile.occupant.type
				var name=occupant_meta.names[type]
				string+=name
			file.store_line(string)
	file.close()
