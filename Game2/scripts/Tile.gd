extends Node

var Background=load("res://scripts/Background.gd")
var Occupant=load("res://scripts/Occupant.gd")

var background
var occupant
var position

func build(position,background_type,occupant_type):
	self.position=position
	background=Background.new()
	background.build(background_type)
	occupant=Occupant.new()
	occupant.build(occupant_type)
	
