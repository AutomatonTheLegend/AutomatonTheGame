extends Reference

var Level=load("res://scripts/Level.gd")
var View=load("res://scripts/View.gd")
var OccupantMeta=load("res://scripts/OccupantMeta.gd")

var game
var view
var level
var occupant_meta
var player

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

func try_player_move(direction):
	if can_move(player,direction):
		move(player,direction)
		return true
	elif can_push(player,direction):
		push(player,direction)
		return true
	return false


func handle_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_D:
					if try_player_move("RIGHT"):
						game.redraw()
				KEY_S:
					if try_player_move("DOWN"):
						game.redraw()
				KEY_A:
					if try_player_move("LEFT"):
						game.redraw()
				KEY_W:
					if try_player_move("UP"):
						game.redraw()

func draw():
	view.draw()
