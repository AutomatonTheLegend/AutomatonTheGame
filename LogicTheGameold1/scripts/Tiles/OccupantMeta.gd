extends Reference

var directions
var names

func add_ocupant(name,direction_array):
	names.append(name)
	directions[name]=direction_array

func build():
	names=[]
	directions={}
	add_ocupant("cable_down_left",["down","left"])
	add_ocupant("cable_down_left_up",["down","left","up"])
	add_ocupant("cable_down_up",["down","up"])
	add_ocupant("cable_left_up",["left","up"])
	add_ocupant("cable_right_down",["right","down"])
	add_ocupant("cable_right_down_left",["right","down","left"])
	add_ocupant("cable_right_down_left_up",["right","down","left","up"])
	add_ocupant("cable_right_down_up",["right","down","up"])
	add_ocupant("cable_right_left",["right","left"])
	add_ocupant("cable_right_left_up",["right","left","up"])
	add_ocupant("cable_right_up",["right","up"])
	add_ocupant("led",["right","down","left","up"])
	add_ocupant("player",["right","down","left","up"])
	add_ocupant("source",["right","down","left","up"])
