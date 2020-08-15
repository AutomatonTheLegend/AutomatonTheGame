extends Node2D

var Game=load("res://scripts/Game.gd")
var game=Game.new()

func _ready():
	game.start(self)

func _draw():
	game.draw()

func _unhandled_input(event):
	game.handle_event(event)
