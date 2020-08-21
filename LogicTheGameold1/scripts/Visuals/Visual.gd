extends Reference

var VisualColor=load("res://scripts/Visuals/VisualColor.gd")
var VisualTexture=load("res://scripts/Visuals/VisualTexture.gd")
var VisualChar=load("res://scripts/Visuals/VisualChar.gd")

var rectangle
var special
var tops
var subs

func build(rectangle,type,special_data):
	tops=[]
	subs=[]
	self.rectangle=rectangle
	match type:
		"color":
			special=VisualColor.new()
			special.build(self,special_data)
		"texture":
			special=VisualTexture.new()
			special.build(self,special_data)
		"character":
			special=VisualChar.new()
			special.build(self,special_data)

func draw(painter):
	special.draw(painter)
	for sub in subs:
		painter.texture(sub["texture"],sub["rectangle"])
	for top in tops:
		painter.texture(top,rectangle)
