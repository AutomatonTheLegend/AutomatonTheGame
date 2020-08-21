extends Reference

var Actions=load("res://scripts/Actions/Actions.gd")

var options
var manager
var painter
var size
var actions

func build(manager,options):
	self.manager=manager
	self.options=options
	painter=manager.painter
	size=painter.visuals.size
	visual_update()
	actions=Actions.new()
	actions.build(manager)
	action_update()

func action_update():
	var option=0
	for y in range(size.y):
		var last_row=int(size.y-1)
		match y:
			0:
				for x in range(size.x):
					actions.none(x,y)
			last_row:
				for x in range(size.x):
					actions.none(x,y)
			_:
				if option<len(options):
					actions.option(1,y,options[option])
					option+=1

func visual_update():
	painter.visuals.clear(Color.white)
	var option=0
	for y in range(size.y):
		var last_row=int(size.y-1)
		match y:
			0:
				var texture=manager.textures.list["scroll_up_disabled"]
				painter.visuals.texture(size.x/2,y,texture,Color.white)
			last_row:
				var texture=manager.textures.list["scroll_down_disabled"]
				painter.visuals.texture(size.x/2,y,texture,Color.white)
			_:
				var last_column=int(size.x)
				var texture=manager.textures.list["scroll_left_disabled"]
				painter.visuals.texture(0,y,texture,Color.white)
				texture=manager.textures.list["scroll_right_disabled"]
				painter.visuals.texture(size.x-1,y,texture,Color.white)
				if option<len(options):
					painter.visuals.string(1,y,options[option],painter.font,Color.black,Color.white,size.x-2)
					option+=1

func draw(painter):
	pass
