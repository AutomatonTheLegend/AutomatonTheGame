extends Node

var types=3
var type

func build(type):
	self.type=type

func switch():
	type+=1
	type%=types
