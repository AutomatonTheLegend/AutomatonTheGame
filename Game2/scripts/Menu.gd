extends Node

var game
var options=[]
var text_color=Color("#EE6C4D")
var background_color=Color("#293241")
var rectangles=[]

func build_rectangles():
	var y=game.menu_font.height
	for i in range(len(options)):
		var size=game.menu_font.dynamic.get_string_size(options[i])
		size.y=game.menu_font.height
		var x=game.configuration.viewport_size.x/2-size.x/2
		rectangles.append(Rect2(Vector2(x,y),size))
		y+=game.menu_font.height*2
		

func draw():
	game.root.draw_rect(Rect2(Vector2.ZERO,game.configuration.viewport_size),background_color)
	for i in range(len(options)):
		game.painter.draw_string(game.menu_font,rectangles[i].position,text_color,options[i])

func handle_left_button_pressed(event):
	for i in range(len(rectangles)):
		if rectangles[i].has_point(event.position):
			return options[i]
	return null
