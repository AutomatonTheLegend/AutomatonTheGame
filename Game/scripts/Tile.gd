extends Reference

var occupant
var right
var down
var left
var up
var neighbors
var pos

func build(pos):
	self.pos=pos
	occupant=null
	neighbors={}
