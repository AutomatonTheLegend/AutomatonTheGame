extends Reference


var TextureManager=load("res://scripts/TextureManager.gd")
var GameState=load("res://scripts/GameState.gd")
var StateMeta=load("res://scripts/StateMeta.gd")

var root
var display
var view
var texture_manager
var game_state
var state_meta
var state_changing_data

func configure_display():
	display=Rect2(Vector2.ZERO,Vector2(2048,1024))
	root.get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,display.size)

func run(root):
	self.root=root
	configure_display()
	texture_manager=TextureManager.new()
	texture_manager.build()
	state_meta=StateMeta.new()
	game_state=GameState.new()
	game_state.build(self,state_meta.Type.MAIN_MENU)

func switch_state(state):
	game_state=GameState.new()
	game_state.build(self,state)

func redraw():
	root.update()

func draw():
	game_state.draw()

func handle_input(event):
	game_state.handle_input(event)
