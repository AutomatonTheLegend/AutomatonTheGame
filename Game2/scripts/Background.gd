extends Node

var type
var types=4

func build(type):
	self.type=type
	
func switch():
	type+=1
	type%=types
