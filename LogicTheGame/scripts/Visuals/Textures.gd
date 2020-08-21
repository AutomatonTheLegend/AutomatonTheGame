extends Reference

var list

func load_texture(name):
	list[name]=load("res://textures/"+name+".png")

func build():
	list={}
