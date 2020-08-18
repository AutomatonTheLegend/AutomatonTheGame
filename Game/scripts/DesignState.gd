extends Reference

var Level=load("res://scripts/Level.gd")
var View=load("res://scripts/View.gd")
var OccupantMeta=load("res://scripts/OccupantMeta.gd")

var game
var view
var level
var occupant_meta

func build(game):
	self.game=game
	occupant_meta=OccupantMeta.new()
	occupant_meta.build()
	level=Level.new()
	level.build(game,Vector2(8,8))
	#level.open(game,"save.level")
	view=View.new()
	view.build(game)

func handle_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_RIGHT:
					if view.rectangle.has_point(event.position):
						var tile_pos=level.to_tile_pos(event.position)
						level.switch_occupant(tile_pos)
						game.redraw()
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_S:
					level.save()

func draw():
	view.draw()
