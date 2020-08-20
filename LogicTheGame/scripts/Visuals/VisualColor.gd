extends Reference

var color
var visual

func build(visual,color):
	self.color=color
	self.visual=visual

func draw(painter):
	painter.rectangle(color,visual.rectangle)
