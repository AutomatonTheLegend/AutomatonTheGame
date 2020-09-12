extends Node2D

var module_manager

func _ready():
	module_manager=build_manager({"main_module":self})
	main({"manager":module_manager})

func _draw():
	draw({"manager":module_manager})

func _unhandled_input(event):
	react({"manager":module_manager,"event":event})

func react(_input):
	pass

func build_bidimensional_array(input):
	var array=[]
	for x in range(input["size"]["x"]):
		array.append([])
		for y in range(input["size"]["y"]):
			var element={}
			element["position"]=build_position({"x":x,"y":y})
			array[x].append(element)
	for x in range(input["size"]["x"]):
		for y in range(input["size"]["y"]):
			array[x][y]["neighbors"]={"right":null,"down":null,"left":null,"up":null}
			if x<input["size"]["x"]-1:
				array[x][y]["neighbors"]["right"]=array[x+1][y]
			if y<input["size"]["y"]-1:
				array[x][y]["neighbors"]["down"]=array[x][y+1]
			if x>0:
				array[x][y]["neighbors"]["left"]=array[x-1][y]
			if y>0:
				array[x][y]["neighbors"]["up"]=array[x][y-1]
	return array

func build_rectangle(input):
	var rectangle={}
	rectangle["position"]=input["position"]
	rectangle["size"]=input["size"]
	return rectangle

func build_visual(input):
	var visual={}
	visual["type"]="color"
	visual["color"]=Color.white
	return visual

func multiply_tuples(input):
	var x=input["a"]["x"]*input["b"]["x"]
	var y=input["a"]["y"]*input["b"]["y"]
	return build_tuple({"x":x,"y":y})

func divide_tuples(input):
	var x=input["a"]["x"]/input["b"]["x"]
	var y=input["a"]["y"]/input["b"]["y"]
	return build_tuple({"x":x,"y":y})

func build_action(input):
	var action={}
	action["type"]="none"
	return action

func build_actions(input):
	var actions={}
	actions["size"]=input["size"]
	actions["element_size"]=input["element_size"]
	actions["array"]=build_bidimensional_array({"size":input["size"]})
	for x in range(input["size"]["x"]):
		for y in range(input["size"]["y"]):
			var element=actions["array"][x][y]
			var position=multiply_tuples({"a":element["position"],"b":input["element_size"]})
			element["rectangle"]=build_rectangle({"position":position,"size":input["element_size"]})
			element["action"]=build_action({})
	return actions

func build_visuals(input):
	var visuals={}
	visuals["size"]=input["size"]
	visuals["element_size"]=input["element_size"]
	visuals["array"]=build_bidimensional_array({"size":input["size"]})
	for x in range(input["size"]["x"]):
		for y in range(input["size"]["y"]):
			var element=visuals["array"][x][y]
			var position=multiply_tuples({"a":element["position"],"b":input["element_size"]})
			element["rectangle"]=build_rectangle({"position":position,"size":input["element_size"]})
			element["visual"]=build_visual({})
	return visuals

func main(input):
	configure_display({"manager":input["manager"]})
	#invoke({"procedure":manager["greet"],"input":{"a":"pepe","b":"pepeb","c":"pepec","d":"peped"}})

func draw(input):
	var visuals=input["manager"]["visuals"]
	var size=visuals["size"]
	for x in range(size["x"]):
		for y in range(size["y"]):
			var element=visuals["array"][x][y]
			match element["visual"]["type"]:
				"color":
					draw_visual_color({"element":element})
				"character":
					draw_visual_color({"element":element})
					draw_visual_character({"element":element})

func rectangle_to_godot(input):
	var pos=tuple_to_godot({"tuple":input["rectangle"]["position"]})
	var size=tuple_to_godot({"tuple":input["rectangle"]["size"]})
	return Rect2(pos,size)

func draw_rectangle(input):
	draw_rect(rectangle_to_godot({"rectangle":input["rectangle"]}),input["color"])

func draw_visual_color(input):
	draw_rectangle({"rectangle":input["element"]["rectangle"],"color":input["element"]["visual"]["color"]})

func invoke(input):
	input["procedure"]["module"].call(input["procedure"]["name"],input["input"])

func build_size(input):
	return build_tuple(input)

func build_position(input):
	return build_tuple(input)

func build_tuple(input):
	var tuple={}
	tuple["x"]=input["x"]
	tuple["y"]=input["y"]
	return tuple

func tuple_to_godot(input):
	return Vector2(input["tuple"]["x"],input["tuple"]["y"])

func build_procedure(input):
	var procedure={}
	procedure["module"]=input["module"]
	procedure["name"]=input["name"]
	return procedure

func build_menu(input):
	var menu={}
	menu["options"]=input["options"]
	menu["font"]=input["font"]
	return menu

func build_state(input):
	var state={}
	state["type"]=input["type"]
	return state

func visual_color(input):
	var visual=input["element"]["visual"]
	visual["type"]="color"
	visual["color"]=input["color"]

func clear_visuals(input):
	var visuals=input["visuals"]
	var size=visuals["size"]
	for x in range(size["x"]):
		for y in range(size["y"]):
			visual_color({"element":visuals["array"][x][y],"color":input["color"]})

func draw_text(input):
	var font=input["font"]
	var dynamic_font=font["dynamic"]
	var color=font["color"]
	var position_tuple=build_position({"x":input["position"]["x"],"y":input["position"]["y"]+font["height"]})
	var pos=tuple_to_godot({"tuple":position_tuple})
	draw_string(dynamic_font,pos,input["string"],color)

func draw_text_centered(input):
	var string_size=input["font"]["dynamic"].get_string_size(input["string"])
	var x=input["rectangle"]["position"]["x"]+input["rectangle"]["size"]["x"]/2-string_size.x/2
	var pos=build_position({"x":x,"y":input["rectangle"]["position"]["y"]})
	draw_text({"font":input["font"],"position":pos,"string":input["string"]})

func draw_visual_character(input):
	draw_text_centered({"rectangle":input["element"]["rectangle"],"string":input["element"]["visual"]["character"],"font":input["element"]["visual"]["font"]})

func visual_character(input):
	var visual=input["element"]["visual"]
	visual["type"]="character"
	visual["color"]=input["color"]
	visual["character"]=input["character"]
	visual["font"]=input["font"]

func visual_string(input):
	var i=0
	for character in input["string"]:
		if i>=input["length"]:
			return
		var x=input["position"]["x"]
		var y=input["position"]["y"]
		#var rectangle=input["visuals"]["array"][x][y]["rectangle"]
		visual_character({"color":input["color"],"character":character,"element":input["visuals"]["array"][x+i][y],"font":input["font"]})
		i+=1

func menu_update_visuals(input):
	clear_visuals({"visuals":input["manager"]["visuals"],"color":Color.black})
	var menu=input["menu"]
	var i=0
	for option in menu["options"]:
		var length=input["manager"]["visuals"]["size"]["x"]
		visual_string({"visuals":input["manager"]["visuals"],"color":Color.black,"string":option,"length":length,"position":build_position({"x":0,"y":i}),"font":input["menu"]["font"]})
		i+=1

func update_visuals(input):
	match input["manager"]["state"]["type"]:
		"main_menu":
			menu_update_visuals({"manager":input["manager"],"menu":input["manager"]["main_menu"]})

func build_font(input):
	var font={}
	var font_data=load("res://fonts/"+input["name"])
	font["dynamic"]=DynamicFont.new()
	font["dynamic"].font_data=font_data
	font["dynamic"].size=input["size"]
	font["color"]=input["color"]
	font["height"]=font["dynamic"].get_height()+input["size"]/4
	return font

func build_manager(input):
	var manager={}
	manager["modules"]={}
	manager["modules"]["main"]=input["main_module"]
	manager["display"]=build_size({"x":2048,"y":1024})
	var size=build_size({"x":16,"y":8})
	var element_size=divide_tuples({"a":manager["display"],"b":size})
	manager["visuals"]=build_visuals({"size":size,"element_size":element_size})
	manager["actions"]=build_actions({"size":size,"element_size":element_size})
	manager["fonts"]={}
	manager["fonts"]["main"]=build_font({"name":"PressStart2P.ttf","color":Color.white,"size":64})
	manager["main_menu"]=build_menu({"options":["Play","Design","Quit"],"font":manager["fonts"]["main"]})
	manager["state"]=build_state({"type":"main_menu"})
	update_visuals({"manager":manager})
	return manager

func vector_from_size(input):
	return Vector2(input["size"]["x"],input["size"]["y"])

func configure_display(input):
	var size=vector_from_size({"size":input["manager"]["display"]})
	input["manager"]["modules"]["main"].get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,size)



















