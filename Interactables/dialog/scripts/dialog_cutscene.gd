@tool
@icon( "res://GUI/dialog_system/icons/cutscene_bubble.svg" )
class_name DialogCutscene extends DialogItem

signal finished

enum Mode { PARRALLEL, SEQUENTIAL }
@export var playback_mode : Mode = Mode.SEQUENTIAL

var actions : Array[ CutsceneAction ] = []
var action_finished_count : int = 0


func _ready() -> void:
	gather_actions()
	pass


func gather_actions() -> void:
	for c in get_children():
		if c is CutsceneAction:
			actions.append( c )
	pass
