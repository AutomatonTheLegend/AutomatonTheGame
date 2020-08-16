extends Node2D

var Game=load("res://scripts/Game.gd")
var game=Game.new()
var mutex=Mutex.new()

func _ready():
	game.start(self)

func _draw():
	game.draw()

func _unhandled_input(event):
	mutex.lock()
	game.handle_event(event)
	mutex.unlock()
