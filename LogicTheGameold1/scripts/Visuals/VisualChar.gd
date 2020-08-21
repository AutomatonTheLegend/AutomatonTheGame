extends Reference

var visual
var character
var font
var font_color
var color

func build(visual,data):
	self.visual=visual
	character=data["character"]
	font=data["font"]
	font_color=data["font_color"]
	color=data["color"]

func draw(painter):
	painter.rectangle(color,visual.rectangle)
	painter.character(character,visual.rectangle,font,font_color)
