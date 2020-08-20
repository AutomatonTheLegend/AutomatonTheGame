extends Reference



var Level=load("res://scripts/Level.gd")
var View=load("res://scripts/View.gd")
var OccupantMeta=load("res://scripts/OccupantMeta.gd")
var DesignInterface=load("res://scripts/DesignInterface.gd")
var DesignActionMeta=load("res://scripts/DesignActionMeta.gd")


var game
var view
var level
var occupant_meta
var interface
var selection
var action_meta


func build(game):
	self.game=game
	action_meta=DesignActionMeta.new()
	selection=Vector2.ZERO
	occupant_meta=OccupantMeta.new()
	occupant_meta.build()
	level=Level.new()
	level.build(game,Vector2(8,8))
	#level.open(game,"save.level")
	view=View.new()
	view.build(game)
	interface=DesignInterface.new()
	interface.build(game)

func place_occupant(type):
	level.place_occupant(selection,occupant_meta.indexes[type])

func handle_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_RIGHT:
					if view.rectangle.has_point(event.position):
						var tile_pos=level.to_tile_pos(event.position)
						level.switch_occupant(tile_pos)
						game.redraw()
				BUTTON_LEFT:
					if view.rectangle.has_point(event.position):
						var tile_pos=level.to_tile_pos(event.position)
						selection=tile_pos.floor()
						game.redraw()
					else:
						var tile_pos=interface.to_tile_pos(event.position)
						var action=interface.get_action(tile_pos)
						match action.type:
							"PLACE_OCCUPANT":
								place_occupant(action.special.occupant_type)
								game.redraw()
							"REMOVE_OCCUPANT":
								if level.remove_occupant(selection):
									game.redraw()
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_S:
					level.save()



func draw():
	view.draw()
	interface.draw()


