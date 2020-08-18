extends Node2D

var cells
var size
var display
var colors
var cell_size
var timer
var rule
var base
var switcher
var row_switcher
var copy
var rule_n
var rule_m
var rule_l
var random
var audio_stream
var stream_data
var stream_array
var rep
var l

func set_display():
	display=Vector2(2048,1024)
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,display)

func build_cells():
	random=RandomNumberGenerator.new()
	random.randomize()
	size=Vector2(64,32)
	cells=[]
	for x in range(size.x):
		cells.append([])
		for _y in range(size.y):
			#var condition=true
			var condition=random.randi()%2==0
			if condition:
				cells[x].append(false)
			else:
				cells[x].append(true)

func build():
	set_display()
	build_cells()
	colors={}
	colors[false]=Color(0,0,0)
	colors[true]=Color(1,1,1)
	cell_size=Vector2(display.x/size.x,display.y/size.y)
	rule=[]
	for x in range(size.x):
		rule.append(false)
	base=4
	timer=0.0
	row_switcher=0
	switcher=Vector2(0,0)
	rule_n=0
	rule_l=int(pow(2,base))
	rule_m=int(pow(2,rule_l))
	copy=[]
	for _x in range(size.x):
		copy.append(false)

func _ready():
	var dict={}
	dict[[false]]=12
	print(dict[[false]])
	build()
	rep=1
	l=128
	audio_stream=AudioStreamSample.new()
	stream_data=[]
	for x in range(size.x*rep*l):
		stream_data.append(-128)
	fill_stream_data()
	stream_array=PoolByteArray(stream_data)
	audio_stream.data=stream_array
	$AudioStreamPlayer.stream=audio_stream
	#$AudioStreamPlayer.play()

func fill_stream_data():
	for i in range(rep):
		for x in range(size.x):
			if cells[x][0]:
				for j in range(l):
					stream_data[size.x*i*l+x*l+j]=16
			else:
				for j in range(l):
					stream_data[size.x*i*l+x*l+j]=-16

func are_cells_plain():
	var cell=cells[0][0]
	for x in range(size.x):
		for y in range(size.y):
			if cell!=cells[x][y]:
				return false
	return true

func is_first_row_plain():
	var cell=cells[0][0]
	for x in range(size.x):
		if cell!=cells[x][0]:
				return false
	return true

func switch_one_cell():
	cells[switcher.x][switcher.y]=!cells[switcher.x][switcher.y]
	switcher.x+=1
	if switcher.x==size.x:
		switcher.x=0
		switcher.y+=1
		switcher.y%=int(size.y)

func switch_one_row_cell():
	cells[row_switcher][0]=!cells[row_switcher][0]
	row_switcher+=1
	row_switcher%=int(size.x)

func copy_row():
	for x in range(size.x):
		copy[x]=cells[x][0]

func advance():
	var y=size.y-1
	while y>0:
		for x in range(size.x):
			cells[x][y]=cells[x][y-1]
		y-=1

func copy_cell(x):
	while x>=size.x:
		x-=size.x
	return copy[x]

func apply_rule():
	for x in range(size.x):
		var rule_i=0
		var adder=1
		for i in range(base):
			if copy_cell(x+i):
				rule_i+=adder
			adder*=2
		cells[x][0]=rule[rule_i]

func get_rule():
	rule_n=0
	var i=0
	for x in range(size.x):
		for y in range(size.y):
			i+=1
			i%=rule_m
			if cells[x][y]:
				rule_n+=i
				rule_n%=rule_m
	for j in range(rule_l):
		rule[j]=false
	i = 0
	while rule_n > 0:
		if rule_n%2 == 1:
			rule[i] = true
		rule_n/=2
		i+=1

func apply_xor():
	for x in range(size.x):
		var cell=false
		for y in range(size.y):
			if cell:
				if cells[x][y]:
					cell=false
				else:
					cell=true
			else:
				if cells[x][y]:
					cell=true
				else:
					cell=false
		cells[x][0]=cell

func iterate():
	if are_cells_plain():
		switch_one_cell()
	if is_first_row_plain():
		apply_xor()
	copy_row()
	get_rule()
	advance()
	apply_rule()
	update()

func _process(delta):
	if timer>=0.064:
		timer=0.0
		iterate()
	timer+=delta

func _draw():
	for x in range(size.x):
		for y in range(size.y):
			var position=Vector2(x*cell_size.x,y*cell_size.y)
			var rectangle=Rect2(position,cell_size)
			var color=colors[cells[x][y]]
			draw_rect(rectangle,color)


func _on_AudioStreamPlayer_finished():
	iterate()
	fill_stream_data()
	stream_array=PoolByteArray(stream_data)
	audio_stream.data=stream_array
	$AudioStreamPlayer.stream=audio_stream
	$AudioStreamPlayer.play()
