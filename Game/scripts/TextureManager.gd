extends Reference

var textures

func build():
	textures={}
	textures["OPTION"]=load("res://textures/OPTION.png")
	textures["OPTION_SELECTED"]=load("res://textures/OPTION_SELECTED.png")
	textures["BACKGROUND"]=load("res://textures/BACKGROUND.png")
	textures["DESIGN_INTERFACE_TILE"]=load("res://textures/DESIGN_INTERFACE_TILE.png")
	textures["TILE_SELECTION"]=load("res://textures/TILE_SELECTION.png")
	textures["OCCUPANTS"]={}
	textures["OCCUPANTS"]["PLAYER"]=load("res://textures/PLAYER.png")
	textures["OCCUPANTS"]["SOURCE"]=load("res://textures/SOURCE.png")
	textures["OCCUPANTS"]["LED"]=load("res://textures/LED.png")
	textures["OCCUPANTS"]["LED_ON"]=load("res://textures/LED_ON.png")
	textures["OCCUPANTS"]["CABLE_DOWN_LEFT"]=load("res://textures/CABLE_DOWN_LEFT.png")
	textures["OCCUPANTS"]["CABLE_DOWN_LEFT_UP"]=load("res://textures/CABLE_DOWN_LEFT_UP.png")
	textures["OCCUPANTS"]["CABLE_DOWN_UP"]=load("res://textures/CABLE_DOWN_UP.png")
	textures["OCCUPANTS"]["CABLE_LEFT_UP"]=load("res://textures/CABLE_LEFT_UP.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_DOWN"]=load("res://textures/CABLE_RIGHT_DOWN.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_DOWN_LEFT"]=load("res://textures/CABLE_RIGHT_DOWN_LEFT.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_DOWN_LEFT_UP"]=load("res://textures/CABLE_RIGHT_DOWN_LEFT_UP.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_DOWN_UP"]=load("res://textures/CABLE_RIGHT_DOWN_UP.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_LEFT"]=load("res://textures/CABLE_RIGHT_LEFT.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_LEFT_UP"]=load("res://textures/CABLE_RIGHT_LEFT_UP.png")
	textures["OCCUPANTS"]["CABLE_RIGHT_UP"]=load("res://textures/CABLE_RIGHT_UP.png")
	
