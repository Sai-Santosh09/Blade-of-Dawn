@tool
class_name LevelTransitionInteract extends LevelTransition


func _ready() -> void:
	super()
	area_entered.connect( _on_area_entered )
	area_exited.connect( _on_area_exited )


func player_interact() -> void:
	
	pass


func _on_area_entered( _a : Area2D ) -> void:
	
	pass


func _on_area_exited( _a : Area2D ) -> void:
	
	pass
