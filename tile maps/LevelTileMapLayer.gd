class_name LevelTileMapLayer extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	LevalManager.ChangeTilemapBounds( GetTileMapBounds() )
	pass # Replace with function body.


func GetTileMapBounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( get_used_rect().position * rendering_quadrant_size ) + position
	)
	bounds.append(
		Vector2( get_used_rect().end * rendering_quadrant_size ) + position
	)
	return bounds
