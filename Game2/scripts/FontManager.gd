extends Node

var MetaFont=load("res://scripts/MetaFont.gd")

func load_font_data(name):
	return load("res://fonts/"+name)

func build_meta(font_data,size):
	var meta_font=MetaFont.new()
	meta_font.dynamic=DynamicFont.new()
	meta_font.dynamic.font_data=font_data
	meta_font.dynamic.size=size
	meta_font.height=meta_font.dynamic.get_height()+16
	return meta_font
