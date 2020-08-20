extends Reference

var DesignAction=load("res://scripts/DesignAction.gd")
var action

func build(action_type):
	action=DesignAction.new()
	action.build(action_type)
