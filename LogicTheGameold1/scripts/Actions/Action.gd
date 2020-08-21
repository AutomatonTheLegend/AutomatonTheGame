extends Reference

var OptionAction=load("res://scripts/Actions/OptionAction.gd")
var ButtonAction=load("res://scripts/Actions/ButtonAction.gd")
var SpecialAction=load("res://scripts/Actions/SpecialAction.gd")

var type
var special

func build(type,data=null):
	self.type=type
	match type:
		"none":
			special=null
		"option":
			special=OptionAction.new()
			special.build(data)
		"button":
			special=ButtonAction.new()
			special.build(data)
		"special":
			special=SpecialAction.new()
			special.build(data)
