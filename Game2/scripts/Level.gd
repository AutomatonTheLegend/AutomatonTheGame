extends Node

var Tile=load("res://scripts/Tile.gd")

var game
var tiles
var height=8
var size=Vector2(height*2,height)

func search_player():
	for x in range(size.x):
		for y in range(size.y):
			if game.occupant_types[tiles[x][y].occupant.type]=="PLAYER":
				return Vector2(x,y)
	return null

func has_enemy(position):
	if game.occupant_types[tiles[position.x][position.y].occupant.type]=="ENEMY":
		return true
	return false

func has_player(position):
	if game.occupant_types[tiles[position.x][position.y].occupant.type]=="PLAYER":
		return true
	return false

func remove(position):
	tiles[position.x][position.y].occupant.type=0

func put_player(position):
	tiles[position.x][position.y].occupant.type=1

func put_enemy(position):
	tiles[position.x][position.y].occupant.type=2

func search_enemies():
	var enemies=[]
	for x in range(size.x):
		for y in range(size.y):
			if game.occupant_types[tiles[x][y].occupant.type]=="ENEMY":
				enemies.append(Vector2(x,y))
	return enemies

func build_tiles():
	tiles=[]
	for x in range(size.x):
		tiles.append([])
		for y in range(size.y):
			var tile=Tile.new()
			tile.build(Vector2(x,y),0,0)
			tiles[x].append(tile)

func build(game):
	self.game=game
	build_tiles()

func draw():
	var tile_width=game.camera_rectangle.size.x/size.x
	var tile_height=game.camera_rectangle.size.y/size.y
	var tile_size=Vector2(tile_width,tile_height)
	for x in range(size.x):
		for y in range(size.y):
			var tile=tiles[x][y]
			var texture=game.texture_manager.textures["backgrounds"][tile.background.type]
			var position=game.camera_rectangle.position+Vector2(x*tile_size.x,y*tile_size.y)
			game.root.draw_texture_rect(texture,Rect2(position,tile_size),false)
			if tile.occupant.type!=0:
				texture=game.texture_manager.textures["occupants"][tile.occupant.type]
				game.root.draw_texture_rect(texture,Rect2(position,tile_size),false)
	var texture
	var position=game.camera_rectangle.position+Vector2(game.pointer.x*tile_size.x,game.pointer.y*tile_size.y)
	if game.pointer.y<size.y/2:
		texture=game.texture_manager.textures["pointer_up"]
		position.y+=tile_size.y
	else:
		texture=game.texture_manager.textures["pointer_down"]
		position.y-=tile_size.y
	var rectangle=Rect2(position,tile_size)
	game.root.draw_texture_rect(texture,rectangle,false)
