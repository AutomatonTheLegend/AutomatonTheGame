extends Reference

var Visual=load("res://scripts/Visuals/Visual.gd")

var array
var size
var display
var visual_size

func get_rectangle(x,y):
	return Rect2(Vector2(x*visual_size.x,y*visual_size.y),visual_size)

func build(size,display):
	self.size=size
	visual_size=Vector2(display.size.x/size.x,display.size.y/size.y)
	array=[]
	for x in range(size.x):
		array.append([])
		for y in range(size.y):
			var visual=Visual.new()
			visual.build(get_rectangle(x,y),"color",Color.white)
			array[x].append(visual)

func clear(color):
	for x in range(size.x):
		for y in range(size.y):
			color(x,y,color)

func color(x,y,color):
	var visual=Visual.new()
	visual.build(get_rectangle(x,y),"color",color)
	array[x][y]=visual

func top(x,y,texture):
	array[x][y].tops.append(texture)

func texture(x,y,texture,color):
	var visual=Visual.new()
	visual.build(get_rectangle(x,y),"texture",[texture,color])
	array[x][y]=visual

func string(x,y,string,font,font_color,color,max_length):
	for i in range(len(string)):
		if i >=max_length:
			return
		var visual=Visual.new()
		var data={}
		data["font"]=font
		data["font_color"]=font_color
		data["character"]=string[i]
		data["color"]=color
		visual.build(get_rectangle(x+i,y),"character",data)
		array[x+i][y]=visual

func number(x,y,number,font,font_color,color,max_length):
	var string=String(number)
	for i in range(max_length):
		color(x+i,y,color)
	for i in range(len(string)):
		if i >=max_length:
			return
		var visual=Visual.new()
		var data={}
		data["font"]=font
		data["font_color"]=font_color
		data["character"]=string[len(string)-1-i]
		data["color"]=color
		var x_index=x+max_length-1-i
		visual.build(get_rectangle(x_index,y),"character",data)
		array[x_index][y]=visual

func draw(painter):
	for x in range(size.x):
		for y in range(size.y):
			array[x][y].draw(painter)

func to_visual_pos(pos):
	return Vector2(pos.x/visual_size.x,pos.y/visual_size.y).floor()
