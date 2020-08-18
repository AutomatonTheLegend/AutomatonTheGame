extends Reference

var Level=load("res://scripts/Level.gd")
var View=load("res://scripts/View.gd")
var OccupantMeta=load("res://scripts/OccupantMeta.gd")

var game
var view
var level
var occupant_meta
var player
var sources
var leds

func build(game,level_name):
	self.game=game
	occupant_meta=OccupantMeta.new()
	occupant_meta.build()
	level=Level.new()
	#level.build(self,Vector2(16,8))
	level.open(game,level_name)
	view=View.new()
	view.build(game)
	player=level.get_player()
	sources=level.get_sources()
	leds=level.get_leds()
	assign_directions()

func all_negative():
	for x in range(level.size.x):
		for y in range(level.size.y):
			var occupant=level.tiles[x][y].occupant
			if occupant!=null:
				occupant.charge="NEGATIVE"

func assign_directions():
	for x in range(level.size.x):
		for y in range(level.size.y):
			var occupant=level.tiles[x][y].occupant
			if occupant!=null:
				var directions = occupant_meta.directions[occupant_meta.names[occupant.type]]
				occupant.directions=directions


func can_push(occupant,direction):
	var tile=occupant.tile
	var neighbour=tile.neighbors[direction]
	if neighbour==null:
		return false
	if neighbour.occupant==null:
		return false
	return can_move(neighbour.occupant,direction)

func can_move(occupant,direction):
	var tile=occupant.tile
	var neighbour=tile.neighbors[direction]
	if neighbour==null:
		return false
	if neighbour.occupant!=null:
		return false
	return true

func move(occupant,direction):
	var tile=occupant.tile
	var neighbour=tile.neighbors[direction]
	tile.occupant=null
	neighbour.occupant=occupant
	occupant.tile=neighbour

func push(occupant,direction):
	var tile=occupant.tile
	var neighbour=tile.neighbors[direction]
	move(neighbour.occupant,direction)
	move(occupant,direction)

func get_opposite(direction):
	match direction:
		"RIGHT":
			return "LEFT"
		"DOWN":
			return "UP"
		"LEFT":
			return "RIGHT"
		"UP":
			return "DOWN"

func try_player_pull(direction):
	var opposite=get_opposite(direction)
	var pull_neighbour=player.tile.neighbors[opposite]
	if can_move(player,direction):
		move(player,direction)
		if pull_neighbour!=null:
			var pull_occupant=pull_neighbour.occupant
			if pull_occupant!=null:
				move(pull_occupant,direction)
		return true
	elif can_push(player,direction):
		if pull_neighbour==null:
			push(player,direction)
			return true
		var pull_occupant=pull_neighbour.occupant
		if pull_occupant==null:
			push(player,direction)
			return true
		return false
	return false

func try_player_move(direction,pull):
	if pull:
		return try_player_pull(direction)
	else:
		if can_move(player,direction):
			move(player,direction)
			return true
		elif can_push(player,direction):
			push(player,direction)
			return true
		return false

func expand_charge(occupant,direction):
	var tile=occupant.tile
	var neighbour=tile.neighbors[direction]
	if neighbour==null:
		return
	if neighbour.occupant==null:
		return
	if neighbour.occupant.charge=="POSITIVE":
		return
	neighbour.occupant.charge="POSITIVE"
	var directions=neighbour.occupant.directions
	for i in range(len(directions)):
		expand_charge(neighbour.occupant,directions[i])
	

func expand_sources():
	for i in range(len(sources)):
		var source=sources[i]
		source.charge="POSITIVE"
		var directions=source.directions
		for j in range(len(directions)):
			expand_charge(source,directions[j])

func iteration():
	all_negative()
	expand_sources()
	pass

func handle_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_D,KEY_RIGHT:
					if try_player_move("RIGHT",event.shift):
						iteration()
						game.redraw()
				KEY_S,KEY_DOWN:
					if try_player_move("DOWN",event.shift):
						iteration()
						game.redraw()
				KEY_A,KEY_LEFT:
					if try_player_move("LEFT",event.shift):
						iteration()
						game.redraw()
				KEY_W,KEY_UP:
					if try_player_move("UP",event.shift):
						iteration()
						game.redraw()

func draw():
	view.draw()
