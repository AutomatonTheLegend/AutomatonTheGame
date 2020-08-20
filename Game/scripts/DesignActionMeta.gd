extends Reference

var names
var indices
var types

func build():
	names=["NONE","REMOVE_OCCUPANT","PLACE_OCCUPANT"]
	types=len(names)
	indices={}
	for i in range(types):
		indices[names[i]]=i
