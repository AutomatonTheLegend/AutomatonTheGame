extends Node2D

var Manager=load("res://scripts/Manager.gd")

var manager
var display

func _ready():
	display=Rect2(Vector2.ZERO,Vector2(2048,1024))
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,display.size)
	manager=Manager.new()
	manager.build(self)
	manager.set_state("main_menu")
	#OS.window_fullscreen=true

func _draw():
	manager.draw()

func _unhandled_input(event):
	manager.input(event)

func quit():
	get_tree().quit()
