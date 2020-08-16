extends Node

var types=3
var type
var turn

func build(type,turn):
	self.turn=turn
	self.type=type

func switch():
	type+=1
	type%=types
