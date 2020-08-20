extends Reference

var manager
var level
var painter
var visuals
var size
var pos

func build(manager,level):
	self.manager=manager
	self.level=level
	painter=manager.painter
	visuals=painter.visuals
	size=Vector2(visuals.size.x/2,visuals.size.y)
	pos=Vector2.ZERO

func visual_update():
	for x in range(size.x):
		for y in range(size.y):
			var level_pos=pos+Vector2(x,y)
			if level_pos.x<0 or level_pos.y<0 or level_pos.x>=level.size.x or level_pos.y>=level.size.y:
				visuals.color(x,y,Color.black)
			else:
				var tile=level.get_tile(level_pos)
				if tile.occupant==null:
					var texture=manager.textures.list["tile"]
					visuals.texture(x,y,texture,Color.white)
