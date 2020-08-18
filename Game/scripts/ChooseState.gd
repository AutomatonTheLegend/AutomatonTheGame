extends Reference

var Menu=load("res://scripts/Menu.gd")

var game
var menu

func build(game):
	self.game=game
	menu=Menu.new()
	var options=[]
	var files=list_files_in_directory("./levels")
	for i in range(len(files)):
		options.append(files[i])
	options.append("Go back")
	menu.build(game,options)

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

func draw():
	menu.draw()

func handle_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_ENTER:
					var selection = menu.get_selection()
					if selection=="Go back":
						game.switch_state(game.state_meta.Type.MAIN_MENU)
						game.redraw()
					else:
						game.state_changing_data=selection
						game.switch_state(game.state_meta.Type.PLAYING)
						game.redraw()
				KEY_DOWN:
					if menu.move_cursor_down():
						game.redraw()
				KEY_UP:
					if menu.move_cursor_up():
						game.redraw()
