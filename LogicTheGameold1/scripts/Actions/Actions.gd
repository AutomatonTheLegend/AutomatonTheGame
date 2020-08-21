extends Reference

var Action=load("res://scripts/Actions/Action.gd")

var manager
var array
var size
var action_size

func build(manager):
	self.manager=manager
	size=manager.painter.visuals.size
	action_size=manager.painter.visuals.visual_size
	array=[]
	for x in range(size.x):
		array.append([])
		for y in range(size.y):
			var action=Action.new()
			action.build("none")
			array[x].append(action)

func none(x,y):
	var action=Action.new()
	action.build("none")
	array[x][y]=action

func button(x,y,name):
	var action=Action.new()
	action.build("button",name)
	array[x][y]=action

func option(x,y,option):
	for i in range(len(option)):
		var action=Action.new()
		action.build("option",option)
		array[x+i][y]=action

func special(x,y,name,data):
	var action=Action.new()
	action.build("special",[name,data])
	array[x][y]=action

func get_action(pos):
	return array[pos.x][pos.y]
