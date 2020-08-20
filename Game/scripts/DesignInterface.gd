extends Reference

var DesignTile=load("res://scripts/DesignTile.gd")
var PlaceAction=load("res://scripts/PlaceAction.gd")

var game
var design_state
var size
var rectangle
var tile_size
var tiles


func build(game):
	self.game=game
	design_state=game.game_state.special
	size=Vector2(8,8)
	rectangle=Rect2(1024,0,1024,1024)
	tile_size=Vector2(rectangle.size.x/size.x,rectangle.size.y/size.y)
	build_tiles()

func build_tiles():
	tiles=[]
	for x in range(size.x):
		tiles.append([])
		for y in range(size.y):
			var tile=DesignTile.new()
			tile.build("NONE")
			tiles[x].append(tile)
	tiles[0][0].action.type="REMOVE_OCCUPANT"
	var occupant_meta=design_state.occupant_meta
	var x=1
	var y=0
	for i in range(occupant_meta.types):
		var action=tiles[x][y].action
		action.type="PLACE_OCCUPANT"
		action.special=PlaceAction.new()
		action.special.build(occupant_meta.names[i])
		x+=1
		if x==size.x:
			x=0
			y+=1



func draw():
	for x in range(size.x):
		for y in range(size.y):
			var texture=game.texture_manager.textures["DESIGN_INTERFACE_TILE"]
			var drectangle=Rect2(rectangle.position+Vector2(x*tile_size.x,y*tile_size.y),tile_size)
			game.root.draw_texture_rect(texture,drectangle,false)
			var tile=tiles[x][y]
			var action=tile.action
			if action.type!="NONE":
				drectangle=Rect2(drectangle.position+tile_size/4,tile_size/4+tile_size/2)
				match action.type:
					"REMOVE_OCCUPANT":
						texture=game.texture_manager.textures["REMOVE_OCCUPANT_ACTION"]
						game.root.draw_texture_rect(texture,drectangle,false)
					"PLACE_OCCUPANT":
						texture=game.texture_manager.textures["OCCUPANTS"][action.special.occupant_type]
						game.root.draw_texture_rect(texture,drectangle,false)
func to_tile_pos(pos):
	pos=pos-Vector2(1024,0)
	return Vector2(pos.x/tile_size.x,pos.y/tile_size.y).floor()



func get_action(tile_pos):
	return tiles[tile_pos.x][tile_pos.y].action
