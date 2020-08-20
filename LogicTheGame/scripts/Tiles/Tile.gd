extends Reference

var occupant
var neighbors
var pos

func build(pos):
	self.pos=pos
	occupant=null
	neighbors={}
	neighbors["right"]=null
	neighbors["down"]=null
	neighbors["left"]=null
	neighbors["up"]=null
