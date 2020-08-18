extends Reference

var FontManager=load("res://scripts/FontManager.gd")
var StringDrawer=load("res://scripts/StringDrawer.gd")

var game
var options
var size
var cursor
var line_size
var font
var font_manager
var string_drawer

func get_selection():
	return options[cursor]

func build(game,options):
	self.game=game
	line_size=game.display.size.y/16
	self.options=[]
	cursor=0
	size=len(options)
	for i in range(size):
		self.options.append(options[i])
	font_manager=FontManager.new()
	font=font_manager.build_meta("dogicabold.ttf", 64)
	string_drawer=StringDrawer.new()
	string_drawer.build(game)

func draw():
	game.root.draw_rect(game.display,Color(1,1,1))
	var pos=Vector2(32,line_size)
	var quad_size=Vector2(line_size,line_size)
	for i in range(size):
		var texture
		if i==cursor:
			texture=game.texture_manager.textures["OPTION_SELECTED"]
		else:
			texture=game.texture_manager.textures["OPTION"]
		var rectangle=Rect2(pos,quad_size)
		game.root.draw_texture_rect(texture,Rect2(pos,quad_size),false)
		pos.x+=line_size*2
		string_drawer.draw_string(font,pos,Color(0,0,0),options[i])
		pos.x-=line_size*2
		pos.y+=line_size*2

func move_cursor_down():
	if cursor<size-1:
		cursor+=1
		return true
	return false

func move_cursor_up():
	if cursor>0:
		cursor-=1
		return true
	return false
