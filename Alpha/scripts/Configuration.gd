extends Node

var stretch_mode=SceneTree.STRETCH_MODE_VIEWPORT
var stretch_aspect=SceneTree.STRETCH_ASPECT_KEEP
var viewport_size=Vector2(2048,1024)

func configure(scene_tree):
	scene_tree.set_screen_stretch(stretch_mode,stretch_aspect,viewport_size)
