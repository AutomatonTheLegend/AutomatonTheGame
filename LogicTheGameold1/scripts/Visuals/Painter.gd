extends Reference

var Visuals=load("res://scripts/Visuals/Visuals.gd")
var Fonts=load("res://scripts/Font/Fonts.gd")

var root
var display
var manager
var visuals
var font
var fonts

func build(manager):
	self.manager=manager
	root=manager.root
	display=root.display
	visuals=Visuals.new()
	visuals.build(Vector2(16,8),display)
	fonts=Fonts.new()
	font=fonts.build_meta("PressStart2P.ttf",96)

func draw_string(font,position,color,text):
	var new_position=Vector2(position.x,position.y+font.height)
	root.draw_string(font.dynamic,new_position,text,color)

func draw_sting_centered_on_screen(font,y,color,text):
	var size=font.dynamic.get_string_size(text)
	var x=display.size.x/2-size.x/2
	var position=Vector2(x,y)
	draw_string(font,position,color,text)

func draw_string_centered(string,rectangle,font,color):
	var size=font.dynamic.get_string_size(string)
	var x=rectangle.position.x+rectangle.size.x/2-size.x/2
	var pos=Vector2(x,rectangle.position.y)
	draw_string(font,pos,color,string)

func character(character,rectangle,font,color):
	draw_string_centered(character,rectangle,font,color)

func rectangle(color,rectangle):
	root.draw_rect(rectangle,color)

func texture(texture,rectangle):
	root.draw_texture_rect(texture,rectangle,false)

func draw():
	visuals.draw(self)

func update():
	root.update()
