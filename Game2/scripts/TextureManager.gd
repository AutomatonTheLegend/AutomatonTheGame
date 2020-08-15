extends Node

var textures

func build():
	textures={}
	textures["backgrounds"]=[]
	textures["backgrounds"].append(load("res://textures/BG0.png"))
	textures["backgrounds"].append(load("res://textures/BG1.png"))
	textures["backgrounds"].append(load("res://textures/BG2.png"))
	textures["backgrounds"].append(load("res://textures/BG3.png"))
	textures["pointer"]=load("res://textures/POINTER.png")
	textures["pointer_up"]=load("res://textures/POINTER_UP.png")
	textures["pointer_down"]=load("res://textures/POINTER_DOWN.png")
	textures["occupants"]=[]
	textures["occupants"].append(null)
	textures["occupants"].append(load("res://textures/OP1.png"))
	textures["occupants"].append(load("res://textures/OP2.png"))
