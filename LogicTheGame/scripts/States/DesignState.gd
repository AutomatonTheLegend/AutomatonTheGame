extends Reference

var Level=load("res://scripts/Tiles/Level.gd")
var View=load("res://scripts/Tiles/View.gd")
var Actions=load("res://scripts/Actions/Actions.gd")
var OccupantMeta=load("res://scripts/Tiles/OccupantMeta.gd")

var occupant_meta
var manager
var painter
var visuals
var size
var level
var view
var selection
var actions
var commands

func build(manager,size):
	self.manager=manager
	painter=manager.painter
	visuals=painter.visuals
	self.size=size
	level=Level.new()
	level.build(manager,size)
	view=View.new()
	view.build(manager,level)
	selection=Vector2.ZERO
	actions=Actions.new()
	actions.build(manager)
	occupant_meta=OccupantMeta.new()
	occupant_meta.build()

	action_update()
	visual_update()

func add_commands():
	commands=[]

func add_command(name,data):
	commands.append({"name":name,"data":data})

func draw(painter):
	pass

func input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_LEFT:
					var visual_pos=manager.painter.visuals.to_visual_pos(event.position)
					var action=actions.get_action(visual_pos)
					match action.type:
						"special":
							match action.special.name:
								"select":
									selection=action.special.data
									visual_update()
									painter.update()

func action_update():
	for x in range(8):
		for y in range(8):
			actions.special(x,y,"select",Vector2(x,y))
	var i=0
	for x in range(8):
		for y in range(8):
			if i<len(commands):
				var command=commands[i] 
				actions.special(x+8,y,command["name"],command["data"])
				i+=1
			else:
				actions.none(x+8,y)

func visual_update():
	visuals.clear(Color.white)
	view.visual_update()
	visuals.top(selection.x,selection.y,manager.texture("selection"))
