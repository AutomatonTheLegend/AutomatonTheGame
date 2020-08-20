extends Reference

var Painter=load("res://scripts/Visuals/Painter.gd")
var State=load("res://scripts/States/State.gd")
var Textures=load("res://scripts/Visuals/Textures.gd")

var root
var state
var painter
var textures

func build(root):
	self.root=root
	painter=Painter.new()
	painter.build(self)
	textures=Textures.new()
	textures.build()

func texture(name):
	return textures.list[name]
	

func set_state(state_type,data=null):
	state=State.new()
	state.build(self,state_type,data)

func draw():
	painter.draw()
	state.draw(painter)

func input(event):
	state.input(event)

func leave():
	root.quit()
