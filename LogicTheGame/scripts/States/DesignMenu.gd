extends Reference

var Menu=load("res://scripts/GUI/Menu.gd")

var menu
var manager

func build(manager):
	self.manager=manager
	menu=Menu.new()
	menu.build(manager,["New","Load","Go back"])

func draw(painter):
	menu.draw(painter)

func input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				BUTTON_LEFT:
					var visual_pos=manager.painter.visuals.to_visual_pos(event.position)
					var action=menu.actions.get_action(visual_pos)

					match action.type:
						"option":
							match action.special.option:
								"New":
									manager.set_state("size_menu")
									manager.painter.update()
								"Load":
									pass
								"Go back":
									manager.set_state("main_menu")
									manager.painter.update()
