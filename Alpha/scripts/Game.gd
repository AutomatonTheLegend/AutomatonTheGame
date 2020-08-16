extends Node

enum GameState{NONE,MAIN_MENU,DESIGN_LEVEL,PLAY_LEVEL,WINNER_MENU,LOSER_MENU}

var Configuration=load("res://scripts/Configuration.gd")
var FontManager=load("res://scripts/FontManager.gd")
var Menu=load("res://scripts/Menu.gd")
var Painter=load("res://scripts/Painter.gd")
var Level=load("res://scripts/Level.gd")
var TextureManager=load("res://scripts/TextureManager.gd")

var root
var configuration=Configuration.new()
var game_state=GameState.NONE
var font_manager=FontManager.new()
var menu_font
var game_font
var font_data
var main_menu
var winner_menu
var loser_menu
var painter
var level
var texture_manager
var camera_rectangle
var pointer
var player
var occupant_types
var background_types
var enemies
var can_switch
var player_needs_move
var enemy_index
var random=RandomNumberGenerator.new()

func build_painter():
	painter=Painter.new()
	painter.game=self

func build_main_menu():
	main_menu=Menu.new()
	main_menu.game=self
	main_menu.options.append("PLAY RANDOM LEVEL")
	main_menu.build_rectangles()

func build_winner_menu():
	winner_menu=Menu.new()
	winner_menu.game=self
	winner_menu.options.append("YOU WIN!!!")
	winner_menu.options.append("GO BACK")
	winner_menu.build_rectangles()

func build_loser_menu():
	loser_menu=Menu.new()
	loser_menu.game=self
	loser_menu.options.append("YOU LOSE :C")
	loser_menu.options.append("GO BACK")
	loser_menu.build_rectangles()

func start(root):
	configure(root)
	play()

func configure(root):
	self.root=root
	configuration.configure(root.get_tree())
	font_data=font_manager.load_font_data("dogicapixelbold.ttf")
	menu_font=font_manager.build_meta(font_data,64)
	game_font=font_manager.build_meta(font_data,24)
	build_painter()
	build_main_menu()
	build_winner_menu()
	build_loser_menu()
	texture_manager=TextureManager.new()
	texture_manager.build()
	camera_rectangle=Rect2(Vector2.ZERO,configuration.viewport_size)
	occupant_types=[]
	occupant_types.append("NONE")
	occupant_types.append("PLAYER")
	occupant_types.append("ENEMY")
	background_types=[]
	background_types.append("RIGHT")
	background_types.append("DOWN")
	background_types.append("LEFT")
	background_types.append("UP")
	random.randomize()

func play():
	print("Playing")
	show_main_menu()

func show_main_menu():
	game_state=GameState.MAIN_MENU
	redraw()

func draw():
	match game_state:
		GameState.MAIN_MENU:
			main_menu.draw()
		GameState.WINNER_MENU:
			winner_menu.draw()
		GameState.LOSER_MENU:
			loser_menu.draw()
		GameState.DESIGN_LEVEL:
			level.draw()
		GameState.PLAY_LEVEL:
			level.draw()

func redraw():
	root.update()

func design_level():
	level=Level.new()
	level.build(self)
	pointer=Vector2(0,0)
	game_state=GameState.DESIGN_LEVEL
	redraw()

func change_pointer_location(position):
	pointer=position
	redraw()

func to_level_position(position):
	var level_position=position-camera_rectangle.position
	var tile_width=camera_rectangle.size.x/level.size.x
	var tile_height=camera_rectangle.size.y/level.size.y
	return Vector2(floor(level_position.x/tile_width),floor(level_position.y/tile_height))

func play_random_level():
	level=Level.new()
	level.build_randomly(self)
	play_level()

func handle_mouse_button_event(event):
	match game_state:
		GameState.MAIN_MENU:
			if event.pressed:
				if event.button_index==BUTTON_LEFT:
					var menu_option = main_menu.handle_left_button_pressed(event)
					match menu_option:
						"PLAY RANDOM LEVEL":
							play_random_level()
		GameState.WINNER_MENU:
			if event.pressed:
				if event.button_index==BUTTON_LEFT:
					var menu_option = winner_menu.handle_left_button_pressed(event)
					match menu_option:
						"GO BACK":
							show_main_menu()
		GameState.LOSER_MENU:
			if event.pressed:
				if event.button_index==BUTTON_LEFT:
					var menu_option = loser_menu.handle_left_button_pressed(event)
					match menu_option:
						"GO BACK":
							show_main_menu()
		GameState.DESIGN_LEVEL:
			if event.pressed:
				if event.button_index==BUTTON_LEFT:
					if camera_rectangle.has_point(event.position):
						var level_position=to_level_position(event.position)
						change_pointer_location(level_position)

func switch_background():
	level.tiles[pointer.x][pointer.y].background.switch()
	redraw()

func switch_occupant():
	level.tiles[pointer.x][pointer.y].occupant.switch()
	redraw()

func name_to_occupant(name):
	match name:
		"NONE":
			return 0
		"PLAYER":
			return 1
		"ENEMY":
			return 2

func play_level():
	enemy_index=0
	can_switch=true
	player_needs_move=true
	player=level.search_player()
	if player==null:
		level.tiles[0][0].occupant.type=name_to_occupant("PLAYER")
		player=Vector2(0,0)
	pointer=player
	enemies=level.search_enemies_in_order()
	game_state=GameState.PLAY_LEVEL
	redraw()

func try_to_switch_background():
	if can_switch:
		can_switch=false
		level.tiles[player.x][player.y].background.switch()
		redraw()

func delete_enemy(position):
	enemies.erase(position)

func move_enemy(direction):
	var turn=level.remove(enemies[enemy_index])
	match direction:
		"RIGHT":
			enemies[enemy_index].x+=1
		"DOWN":
			enemies[enemy_index].y+=1
		"LEFT":
			enemies[enemy_index].x-=1
		"UP":
			enemies[enemy_index].y-=1
	if level.has_player(enemies[enemy_index]):
		player=null
	level.put_enemy(enemies[enemy_index],turn)

func move_player(direction):
	level.remove(player)
	match direction:
		"RIGHT":
			player.x+=1
		"DOWN":
			player.y+=1
		"LEFT":
			player.x-=1
		"UP":
			player.y-=1
	if level.has_enemy(player):
		delete_enemy(player)
	if level.is_exit(player):
		game_state=GameState.WINNER_MENU
	level.put_player(player)


func try_to_move_right(occupant_type):
	match occupant_type:
		"PLAYER":
			if player.x<level.size.x-1:
				move_player("RIGHT")
		"ENEMY":
			if enemies[enemy_index].x<level.size.x-1:
				if not level.has_enemy(enemies[enemy_index]+Vector2(1,0)):
					move_enemy("RIGHT")


func try_to_move_down(occupant_type):
	match occupant_type:
		"PLAYER":
			if player.y<level.size.y-1:
				move_player("DOWN")
		"ENEMY":
			if enemies[enemy_index].y<level.size.y-1:
				if not level.has_enemy(enemies[enemy_index]+Vector2(0,1)):
					move_enemy("DOWN")

func try_to_move_left(occupant_type):
	match occupant_type:
		"PLAYER":
			if player.x>0:
				move_player("LEFT")
		"ENEMY":
			if enemies[enemy_index].x>0:
				if not level.has_enemy(enemies[enemy_index]-Vector2(1,0)):
					move_enemy("LEFT")

func try_to_move_up(occupant_type):
	match occupant_type:
		"PLAYER":
			if player.y>0:
				move_player("UP")
		"ENEMY":
			if enemies[enemy_index].y>0:
				if not level.has_enemy(enemies[enemy_index]-Vector2(0,1)):
					move_enemy("UP")

func try_to_move_player():
	var background=level.tiles[player.x][player.y].background.type
	match background_types[background]:
		"RIGHT":
			try_to_move_right("PLAYER")
		"DOWN":
			try_to_move_down("PLAYER")
		"LEFT":
			try_to_move_left("PLAYER")
		"UP":
			try_to_move_up("PLAYER")

func try_to_move_enemy():
	var background=level.tiles[enemies[enemy_index].x][enemies[enemy_index].y].background.type
	level.tiles[enemies[enemy_index].x][enemies[enemy_index].y].background.switch()
	match background_types[background]:
		"RIGHT":
			try_to_move_right("ENEMY")
		"DOWN":
			try_to_move_down("ENEMY")
		"LEFT":
			try_to_move_left("ENEMY")
		"UP":
			try_to_move_up("ENEMY")

func reset():
	if player!=null:
		player_needs_move=true
		pointer=player
		enemy_index=0
		can_switch=true

func iterate():
	if player_needs_move:
		player_needs_move=false
		try_to_move_player()
		if len(enemies)>0:
			pointer=enemies[enemy_index]
		else:
			reset()
	elif enemy_index<len(enemies):
		try_to_move_enemy()
		enemy_index+=1
		if enemy_index==len(enemies):
			reset()
		else:
			pointer=enemies[enemy_index]
	redraw()

func handle_key_event(event):
	match game_state:
		GameState.DESIGN_LEVEL:
			if event.pressed:
				match event.scancode:
					KEY_B:
						switch_background()
					KEY_O:
						switch_occupant()
					KEY_ENTER:
						play_level()
		GameState.PLAY_LEVEL:
			if event.pressed:
				match event.scancode:
					KEY_SPACE,KEY_ENTER:
						if player==null:
							game_state=GameState.LOSER_MENU
							redraw()
							return
				match event.scancode:
					KEY_SPACE:
						try_to_switch_background()
					KEY_ENTER:
						iterate()

func handle_event(event):
	if event is InputEventMouseButton:
		handle_mouse_button_event(event)
	elif event is InputEventKey:
		handle_key_event(event)
