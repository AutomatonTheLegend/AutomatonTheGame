extends Reference

var MainMenuState=load("res://scripts/MainMenuState.gd")
var DesignState=load("res://scripts/DesignState.gd")
var PlayState=load("res://scripts/PlayState.gd")
var ChooseState=load("res://scripts/ChooseState.gd")

var game
var type
var special
var state_meta

func build(game,type):
	self.game=game
	self.type=type
	state_meta=game.state_meta
	match type:
		state_meta.Type.MAIN_MENU:
			special=MainMenuState.new()
			special.build(game)
		state_meta.Type.DESIGNING:
			special=DesignState.new()
			special.build(game)
		state_meta.Type.PLAYING:
			special=PlayState.new()
			special.build(game,game.state_changing_data)
		state_meta.Type.CHOOSING:
			special=ChooseState.new()
			special.build(game)

func draw():
	special.draw()

func handle_input(event):
	special.handle_input(event)
