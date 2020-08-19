extends Reference



var game
var size
var rectangle
var tile_size
var tiles


func build(game):
	self.game=game
	size=Vector2(8,8)
	rectangle=Rect2(1024,0,1024,1024)
	tile_size=Vector2(rectangle.size.x/size.x,rectangle.size.y/size.y)


func draw():
	for x in range(size.x):
		for y in range(size.y):
			var texture=game.texture_manager.textures["DESIGN_INTERFACE_TILE"]
			var drectangle=Rect2(rectangle.position+Vector2(x*tile_size.x,y*tile_size.y),tile_size)
			game.root.draw_texture_rect(texture,drectangle,false)
