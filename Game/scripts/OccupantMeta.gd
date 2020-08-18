extends Reference

var names
var indexes
var types

func build():
	names=[]
	names.append("PLAYER")
	names.append("LED")
	names.append("POWER")
	
	names.append("CABLE_RIGHT_DOWN")
	names.append("CABLE_DOWN_LEFT")
	names.append("CABLE_LEFT_UP")
	names.append("CABLE_RIGHT_UP")
	
	names.append("CABLE_RIGHT_LEFT")
	names.append("CABLE_DOWN_UP")
	
	names.append("CABLE_RIGHT_DOWN_LEFT")
	names.append("CABLE_DOWN_LEFT_UP")
	names.append("CABLE_RIGHT_LEFT_UP")
	names.append("CABLE_RIGHT_DOWN_UP")
	
	names.append("CABLE_RIGHT_DOWN_LEFT_UP")
	
	types=len(names)
	indexes={}
	for i in range(types):
		indexes[names[i]]=i
