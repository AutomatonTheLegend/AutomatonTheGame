extends Node2D

var Game = load("res://scripts/Game.gd")

var game

func _ready():
	game = Game.new()
	game.run(self)

func _draw():
	game.draw()

func _unhandled_input(event):
	game.handle_input(event)
