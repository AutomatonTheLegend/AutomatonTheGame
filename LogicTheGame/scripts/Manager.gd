extends Reference

var Painter=load("res://scripts/Visuals/Painter.gd")
var State=load("res://scripts/States/State.gd")
var Textures=load("res://scripts/Visuals/Textures.gd")

var root
var state
var painter
var textures

func list_files_in_directory(path,extension):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if file.get_extension()==extension:
				files.append(file.get_basename())

	dir.list_dir_end()

	return files

func load_textures():
	var files=list_files_in_directory("res://textures","png")
	for file in files:
		textures.load_texture(file)

func build(root):
	self.root=root
	painter=Painter.new()
	painter.build(self)
	textures=Textures.new()
	textures.build()
	load_textures()


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
