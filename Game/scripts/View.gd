extends Reference



var game
var size
var tile_size
var pos
var rectangle
var occupant_meta
var level
var game_state



func build(game):
	self.game=game
	pos=Vector2.ZERO
	size=Vector2(8,8)
	rectangle=Rect2(0,0,1024,1024)
	tile_size=Vector2(rectangle.size.x/size.x,rectangle.size.y/size.y)
	level=game.game_state.special.level
	game_state=game.game_state
	occupant_meta=game_state.special.occupant_meta



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
				var occupant=level.tiles[x+pos.x][y+pos.y].occupant
				if occupant!=null:
					var type=occupant_meta.names[occupant.type]
					match type:
						"LED":
							if occupant.charge=="NEGATIVE":
								texture=game.texture_manager.textures["OCCUPANTS"]["LED"]
							else:
								texture=game.texture_manager.textures["OCCUPANTS"]["LED_ON"]
						_:
							texture=game.texture_manager.textures["OCCUPANTS"][type]
					game.root.draw_texture_rect(texture,drectangle,false)
				if game_state.type==game.state_meta.Type.DESIGNING:
					if game_state.special.selection==Vector2(x,y):
						texture=game.texture_manager.textures["TILE_SELECTION"]
						game.root.draw_texture_rect(texture,drectangle,false)


