extends Reference

var names
var indexes
var types
var directions

func build():
	names=[]
	directions={}

	names.append("PLAYER")
	directions["PLAYER"]=["RIGHT","DOWN","LEFT","UP"]
	names.append("LED")
	directions["LED"]=["RIGHT","DOWN","LEFT","UP"]
	names.append("SOURCE")
	directions["SOURCE"]=["RIGHT","DOWN","LEFT","UP"]
	
	names.append("CABLE_RIGHT_DOWN")
	directions["CABLE_RIGHT_DOWN"]=["RIGHT","DOWN"]
	names.append("CABLE_DOWN_LEFT")
	directions["CABLE_DOWN_LEFT"]=["DOWN","LEFT"]
	names.append("CABLE_LEFT_UP")
	directions["CABLE_LEFT_UP"]=["LEFT","UP"]
	names.append("CABLE_RIGHT_UP")
	directions["CABLE_RIGHT_UP"]=["RIGHT","UP"]
	
	names.append("CABLE_RIGHT_LEFT")
	directions["CABLE_RIGHT_LEFT"]=["RIGHT","LEFT"]
	names.append("CABLE_DOWN_UP")
	directions["CABLE_DOWN_UP"]=["DOWN","UP"]
	
	names.append("CABLE_RIGHT_DOWN_LEFT")
	directions["CABLE_RIGHT_DOWN_LEFT"]=["RIGHT","DOWN","LEFT"]
	names.append("CABLE_DOWN_LEFT_UP")
	directions["CABLE_DOWN_LEFT_UP"]=["DOWN","LEFT","UP"]
	names.append("CABLE_RIGHT_LEFT_UP")
	directions["CABLE_RIGHT_LEFT_UP"]=["RIGHT","LEFT","UP"]
	names.append("CABLE_RIGHT_DOWN_UP")
	directions["CABLE_RIGHT_DOWN_UP"]=["RIGHT","DOWN","UP"]
	
	names.append("CABLE_RIGHT_DOWN_LEFT_UP")
	directions["CABLE_RIGHT_DOWN_LEFT_UP"]=["RIGHT","DOWN","LEFT","UP"]
	
	types=len(names)
	indexes={}
	for i in range(types):
		indexes[names[i]]=i
	
