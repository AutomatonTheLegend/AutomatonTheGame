extends Reference

var game
var size
var tile_size
var pos
var rectangle
var occupant_meta
var level

func build(game):
	self.game=game
	pos=Vector2.ZERO
	size=Vector2(8,8)
	rectangle=Rect2(0,0,1024,1024)
	tile_size=Vector2(rectangle.size.x/size.x,rectangle.size.y/size.y)
	level=game.game_state.special.level
	occupant_meta=game.game_state.special.occupant_meta

func draw():
	game.root.draw_rect(game.display,Color(0,0,0))
	for x in range(size.x):
		for y in range(size.y):
			var dpos=Vector2(x*tile_size.x,y*tile_size.y)
			var dsize=tile_size
			var drectangle=Rect2(dpos,dsize)
			if x+pos.x>=level.size.x or y+pos.y>=level.size.y:
				game.root.draw_rect(drectangle,Color(0,0,0))
			else:
				var texture=game.texture_manager.textures["BACKGROUND"]
				game.root.draw_texture_rect(texture,drectangle,false)
				var tile=level.tiles[x+pos.x][y+pos.y]
				if tile.occupant!=null:
					texture=game.texture_manager.textures["OCCUPANTS"][occupant_meta.names[tile.occupant.type]]
					game.root.draw_texture_rect(texture,drectangle,false)
