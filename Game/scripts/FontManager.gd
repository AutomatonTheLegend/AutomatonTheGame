extends Reference

var MetaFont=load("res://scripts/MetaFont.gd")

func load_font_data(name):
	return load("res://fonts/"+name)

func build_meta_from_data(font_data,size):
	var meta_font=MetaFont.new()
	meta_font.dynamic=DynamicFont.new()
	meta_font.dynamic.font_data=font_data
	meta_font.dynamic.size=size
	meta_font.height=meta_font.dynamic.get_height()+size/4
	return meta_font

func build_meta(name,size):
	var data=load_font_data(name)
	return build_meta_from_data(data,size)
