extends Node

var Tile=load("res://scripts/Tile.gd")

var game
var tiles
var height=8
var size=Vector2(height*2,height)
var exit=size-Vector2.ONE
var enemy_counter

func is_exit(position):
	return exit==position

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
	var turn=tiles[position.x][position.y].occupant.turn
	tiles[position.x][position.y].occupant.type=0
	tiles[position.x][position.y].occupant.turn=-1
	return turn

func put_player(position):
	tiles[position.x][position.y].occupant.type=1
	tiles[position.x][position.y].occupant.turn=0

func put_enemy(position,turn):
	tiles[position.x][position.y].occupant.type=2
	tiles[position.x][position.y].occupant.turn=turn

func search_enemies():
	var enemies=[]
	for x in range(size.x):
		for y in range(size.y):
			if game.occupant_types[tiles[x][y].occupant.type]=="ENEMY":
				enemies.append(Vector2(x,y))
	return enemies

func search_enemies_in_order():
	var enemies=search_enemies()
	for i in range(len(enemies)):
		tiles[enemies[i].x][enemies[i].y].occupant.turn=i+1
	return enemies

func build_tiles():
	tiles=[]
	for x in range(size.x):
		tiles.append([])
		for y in range(size.y):
			var tile=Tile.new()
			tile.build(Vector2(x,y),0,0,-1)
			tiles[x].append(tile)

func can_put_random_enemy(position):
	if position==Vector2.ZERO:
		return false
	if position==exit:
		return false
	if has_enemy(position):
		return false
	return true

func build_tiles_randomly():
	tiles=[]
	for x in range(size.x):
		tiles.append([])
		for y in range(size.y):
			var tile=Tile.new()
			tile.build(Vector2(x,y),game.random.randi()%4,0,-1)
			tiles[x].append(tile)
	put_player(Vector2.ZERO)
	enemy_counter=0
	while enemy_counter<4:
		var position=Vector2(game.random.randi()%int(size.x),game.random.randi()%int(size.y))
		if can_put_random_enemy(position):
			enemy_counter+=1
			put_enemy(position,enemy_counter)


func build(game):
	self.game=game
	build_tiles()
	
func build_randomly(game):
	self.game=game
	build_tiles_randomly()

func draw():
	var tile_width=game.camera_rectangle.size.x/size.x
	var tile_height=game.camera_rectangle.size.y/size.y
	var tile_size=Vector2(tile_width,tile_height)
	var texture
	var position
	var rectangle
	
	for x in range(size.x):
		for y in range(size.y):
			var tile=tiles[x][y]
			texture=game.texture_manager.textures["backgrounds"][tile.background.type]
			position=game.camera_rectangle.position+Vector2(x*tile_size.x,y*tile_size.y)
			game.root.draw_texture_rect(texture,Rect2(position,tile_size),false)
			if exit==Vector2(x,y):
				texture=game.texture_manager.textures["exit_pointer"]
				position=game.camera_rectangle.position+Vector2(exit.x*tile_size.x,exit.y*tile_size.y)
				rectangle=Rect2(position,tile_size)
				game.root.draw_texture_rect(texture,rectangle,false)
			if tile.occupant.type!=0:
				texture=game.texture_manager.textures["occupants"][tile.occupant.type]
				game.root.draw_texture_rect(texture,Rect2(position,tile_size),false)
				var text=String(tile.occupant.turn+1)
				match tile.background.type:
					0:
						texture=game.texture_manager.textures["arrow_right"]
					1:
						texture=game.texture_manager.textures["arrow_down"]
					2:
						texture=game.texture_manager.textures["arrow_left"]
					3:
						texture=game.texture_manager.textures["arrow_up"]
				game.painter.draw_string(game.game_font,position+tile_size/2-Vector2(tile_size.x/4,0),Color(1,1,1),text)
				game.root.draw_texture_rect(texture,Rect2(position+tile_size/2,tile_size/4),false)
	position=game.camera_rectangle.position+Vector2(game.pointer.x*tile_size.x,game.pointer.y*tile_size.y)
	if game.pointer.y<size.y/2:
		texture=game.texture_manager.textures["pointer_up"]
		position.y+=tile_size.y
	else:
		texture=game.texture_manager.textures["pointer_down"]
		position.y-=tile_size.y/2
	position.x+=tile_size.x/4
	rectangle=Rect2(position,tile_size/2)
	game.root.draw_texture_rect(texture,rectangle,false)
	
