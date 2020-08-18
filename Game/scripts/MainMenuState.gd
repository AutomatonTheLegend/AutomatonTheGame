extends Reference

var Menu=load("res://scripts/Menu.gd")

var game
var menu

func build(game):
	self.game=game
	menu=Menu.new()
	var options=["Play level","Design level"]
	menu.build(game,options)

func draw():
	menu.draw()

func handle_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_ENTER:
					match menu.cursor:
						0:
							game.switch_state(game.state_meta.Type.CHOOSING)
							game.redraw()
						1:
							game.switch_state(game.state_meta.Type.DESIGNING)
							game.redraw()
				KEY_DOWN:
					if menu.move_cursor_down():
						game.redraw()
				KEY_UP:
					if menu.move_cursor_up():
						game.redraw()
