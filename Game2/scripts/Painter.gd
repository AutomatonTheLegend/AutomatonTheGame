extends Node

var game

func draw_string(font,position,color,text):
	var new_position=Vector2(position.x,position.y+font.height)
	game.root.draw_string(font.dynamic,new_position,text,color)

func draw_sting_centered_on_screen(font,y,color,text):
	var size=font.dynamic.get_string_size(text)
	var x=game.configuration.viewport_size.x/2-size.x/2
	var position=Vector2(x,y)
	draw_string(font,position,color,text)
