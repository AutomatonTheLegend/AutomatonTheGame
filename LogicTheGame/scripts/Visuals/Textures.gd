extends Reference

var list

func load_texture(name):
	list[name]=load("res://textures/"+name+".png")

func build():
	list={}
	load_texture("tile")
	load_texture("scroll_up_disabled")
	load_texture("scroll_down_disabled")
	load_texture("scroll_right_disabled")
	load_texture("scroll_left_disabled")
	load_texture("scroll_right")
	load_texture("scroll_left")
	load_texture("selection")
