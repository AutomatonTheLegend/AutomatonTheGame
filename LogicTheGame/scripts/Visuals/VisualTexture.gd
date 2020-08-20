extends Reference

var texture
var visual
var color

func build(visual,data):
	self.visual=visual
	texture=data[0]
	color=data[1]

func draw(painter):
	painter.rectangle(color,visual.rectangle)
	painter.texture(texture,visual.rectangle)
