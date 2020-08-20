extends Reference

var Actions=load("res://scripts/Actions/Actions.gd")

var manager
var painter
var size
var width
var height
var offset
var actions

func build(manager):
	self.manager=manager
	painter=manager.painter
	size=painter.visuals.size
	width=32
	height=32
	offset=16
	visual_update()
	actions=Actions.new()
	actions.build(manager)
	action_update()

func action_update():
	actions.button(0,1,"decrease_width")
	actions.button(5,1,"increase_width")
	
	actions.button(0,3,"decrease_height")
	actions.button(5,3,"increase_height")
	
	actions.button(0,5,"decrease_offset")
	actions.button(5,5,"increase_offset")
	
	actions.option(0,6,"Design")
	actions.option(0,7,"Go back")

func visual_update():
	var left_texture=manager.textures.list["scroll_left"]
	var right_texture=manager.textures.list["scroll_right"]
	painter.visuals.clear(Color.white)
	
	painter.visuals.string(0,0,"Width:",painter.font,Color.black,Color.white,size.x)
	painter.visuals.texture(0,1,left_texture,Color.white)
	painter.visuals.number(1,1,width,painter.font,Color.white,Color.black,4)
	painter.visuals.texture(5,1,right_texture,Color.white)
	
	painter.visuals.string(0,2,"Height:",painter.font,Color.black,Color.white,size.x)
	painter.visuals.texture(0,3,left_texture,Color.white)
	painter.visuals.number(1,3,height,painter.font,Color.white,Color.black,4)
	painter.visuals.texture(5,3,right_texture,Color.white)
	
	painter.visuals.string(0,4,"Offset:",painter.font,Color.black,Color.white,size.x)
	painter.visuals.texture(0,5,left_texture,Color.white)
	painter.visuals.number(1,5,offset,painter.font,Color.white,Color.black,4)
	painter.visuals.texture(5,5,right_texture,Color.white)
	
	painter.visuals.string(0,6,"Design",painter.font,Color.black,Color.white,size.x)
	
	painter.visuals.string(0,7,"Go back",painter.font,Color.white,Color.black,size.x)

func draw(painter):
	pass

func decrease_width():
	width-=offset
	if width<8:
		width=8

func increase_width():
	width+=offset
	if width>1024:
		width=1024

func decrease_height():
	height-=offset
	if height<8:
		height=8

func increase_height():
	height+=offset
	if height>1024:
		height=1024

func decrease_offset():
	offset-=8
	if offset<8:
		offset=8

func increase_offset():
	offset+=8
	if offset>1024:
		offset=1024

func input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_LEFT:
					var visual_pos=manager.painter.visuals.to_visual_pos(event.position)
					var action=actions.get_action(visual_pos)
					match action.type:
						"option":
							match action.special.option:
								"Go back":
									manager.set_state("design_menu")
									manager.painter.update()
								"Design":
									var level_size=Vector2(width,height)
									manager.set_state("design",level_size)
									manager.painter.update()
						"button":
							match action.special.name:
								"decrease_width":
									decrease_width()
									visual_update()
									manager.painter.update()
								"increase_width":
									increase_width()
									visual_update()
									manager.painter.update()
								"decrease_height":
									decrease_height()
									visual_update()
									manager.painter.update()
								"increase_height":
									increase_height()
									visual_update()
									manager.painter.update()
								"decrease_offset":
									decrease_offset()
									visual_update()
									manager.painter.update()
								"increase_offset":
									increase_offset()
									visual_update()
									manager.painter.update()
