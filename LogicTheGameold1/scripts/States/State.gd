extends Reference

var MainMenu=load("res://scripts/States/MainMenu.gd")
var PlayMenu=load("res://scripts/States/PlayMenu.gd")
var DesignMenu=load("res://scripts/States/DesignMenu.gd")
var SizeMenu=load("res://scripts/States/SizeMenu.gd")
var DesignState=load("res://scripts/States/DesignState.gd")

var special
var manager

func build(manager,type,data=null):
	self.manager=manager
	match type:
		"main_menu":
			special=MainMenu.new()
			special.build(manager)
		"play_menu":
			special=PlayMenu.new()
			special.build(manager)
		"design_menu":
			special=DesignMenu.new()
			special.build(manager)
		"size_menu":
			special=SizeMenu.new()
			special.build(manager)
		"design":
			special=DesignState.new()
			special.build(manager,data)

func draw(painter):
	special.draw(painter)

func input(event):
	special.input(event)
